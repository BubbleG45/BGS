# Better Group Sports (BGS) — Build Plan

*Working draft — captures decisions from the initial planning discussion (2026-08-02). Revisit and update as decisions change.*

## 1. Guiding Decisions (locked in for now)

| Decision | Choice |
|---|---|
| Scope philosophy | Broad-but-shallow v1 — most feature areas present at a basic depth, rather than one deep vertical slice |
| Launch sport | Volleyball/tennis-style (set-based scoring, best-of-N) |
| Team | Solo developer |
| Timeline | Sept/Oct 2026 is a soft internal goal, not a hard deadline — do not sacrifice payments or core quality to hit it |
| Payments | Marketplace split payments (Stripe Connect) from the start — player pays platform, platform auto-splits organizer's share minus platform fee, per [League_Platform_Pricing_Model.md](League_Platform_Pricing_Model.md) |
| App framework | Flutter (iOS, Android, and authenticated web dashboards) |
| Backend | Serverpod (Dart) |
| Public pages (org homepages, event links, search) | **Jaspr** (Dart SSR framework) — keeps the whole stack in Dart. Pre-1.0 (v0.23.x as of Aug 2026), so expect occasional breaking changes to absorb; accepted trade-off vs. maintaining a second language/ecosystem (Next.js) solo |
| Backend hosting | **Serverpod Cloud** (docs.serverpod.dev/cloud) — first-party managed hosting for Serverpod. Starter tier ~$29/mo (1 podlet + small Postgres add-on), handles TLS/domains/logging/secrets with no Docker/Terraform |
| Public-site hosting | **Railway** — Jaspr runs in "server mode" as a standard Dart server; Railway has a documented Dart deployment path and a cheap hobby tier. Kept as a second small service since Serverpod Cloud's website hosting appears Flutter-web-specific, not confirmed for arbitrary Dart servers |
| Branding | Name confirmed: **Better Group Sports (BGS)**. No visual design yet — build theming as swappable design tokens, ship with a neutral placeholder theme |
| Theming | No hardcoded colors/spacing/type anywhere in the app — everything flows through a central theme/token layer, from day one |
| Change tracking | All features/changes logged in `CHANGELOG.md` as they land |
| Stripe Connect account type | **Express**, built on Stripe's Accounts v2 model. Organizer onboarding (KYC/bank info) uses **Connect embedded components** via the `flutter_stripe_connect` package — renders inside the BGS app, no redirect to stripe.com. Player registration payment uses `flutter_stripe` (PaymentSheet), also fully in-app. Neither side ever leaves the app. |
| v1 auth methods | Serverpod's built-in email + password + verification code, plus **Google Sign-In** and **Apple Sign-In** (both officially supported Serverpod providers with dedicated Flutter packages: `serverpod_auth_google_flutter`, `serverpod_auth_apple_flutter`). True one-click passwordless magic links deferred — Serverpod has no built-in support for that flow (only email+password+code), so it would be custom-built later once core flows are proven. |
| Transactional email | **Resend** — used for verification codes, password resets, and (later) magic links |
| Sport #2 (after volleyball) | Soccer/kickball-style (single running score, not set-based) — chosen deliberately over an easier option (pickleball) to force the scoring data model to prove it generalizes beyond set-based sports early, rather than discovering gaps after more features are built on the volleyball-shaped assumption |

## 2. Why "broad-but-shallow" is riskier solo — and how we manage it

Broad-but-shallow + solo + marketplace payments + a second (public-site) codebase is an ambitious combination. The mitigation is discipline about what "shallow" means per feature area in Phase 1 — see §5. If a feature area can't be built shallow (i.e. it has no meaningful "basic version"), it gets pushed to a later phase rather than allowed to balloon Phase 1.

## 3. Architecture Overview

- **Flutter app** — single codebase targeting iOS, Android, and web. Serves the authenticated experience: player/organizer/manager dashboards, team management, registration flows, in-app scheduling/standings views.
- **Serverpod backend** — Dart backend, Postgres for primary data, handles auth (email+password+code, Google, Apple), business logic, Stripe Connect orchestration, and serves a typed API consumed by both the Flutter app and the public-site layer.
- **Public site layer** — Jaspr (Dart SSR), server-rendered SEO-friendly pages for: org homepages, league/event public pages, shareable event links, and search/discovery. Reads from the same Serverpod API. Deployed as its own small Dart server on Railway, separate from the Serverpod Cloud-hosted backend.
- **Payments** — Stripe Connect Express accounts (Accounts v2) for organizers, onboarded via in-app embedded components (`flutter_stripe_connect`); player registration payment via in-app `flutter_stripe` PaymentSheet. Platform fee computed per the pricing model at league activation / event creation.
- **Theming** — a central design-token package (colors, spacing, typography, radii) consumed by both Flutter (via `ThemeExtension`) and the public-site layer, so a future white-label theme/URL-slug feature doesn't require retrofitting.
- **Notifications** (later phase) — push via FCM/APNs, email via Resend, SMS via Twilio.

## 4. Domain Model Sketch

```
User
 └── Profile (one per user)
      ├── Player roles  → Team memberships → League/Event participation
      ├── Organizer role → owns Organization(s)
      └── Manager role   → manages Team(s) within a League

Organization
 ├── has many Leagues
 ├── has many Events
 └── has an Org Homepage (public, shows its leagues/events)

League (belongs to an Organization)
 ├── has a Schedule
 ├── has Teams (with invited Players)
 ├── has Standings
 └── may generate a Playoff Bracket

Event (one-off; may belong to an Organization, or be "orgless")
 ├── may be a Tournament (bracket-based)
 └── has a shareable Event Link (public)
```

Registration ties a Player to a Team (League) or to an Event directly. Team fee is captured at League activation / Event creation per the pricing model, independent of how payment is actually collected.

## 5. Phasing

### Phase 0 — Foundations
- Initialize git repo, repo structure (Flutter app + Serverpod backend + public-site layer as separate packages/dirs)
- Serverpod project scaffold, Postgres schema baseline, environments (dev/staging/prod)
- Flutter project scaffold (iOS/Android/Web targets), design-token theming system with placeholder BGS theme
- Auth: account creation, login via email+password+verification code, Google Sign-In, Apple Sign-In (Resend for auth email delivery)
- `CHANGELOG.md` established, contribution/logging convention agreed
- CI (build + test on push) — lightweight, not blocking early velocity
- Hosting environment stood up (Serverpod Cloud + Railway)

### Phase 1 — Core broad-but-shallow slice

**Resume point (as of 2026-08-03):** domain model/schema built and migrated; `OrganizationEndpoint`, `LeagueEndpoint`, `TeamEndpoint`, `EventEndpoint`, `ScheduledMatchEndpoint`, `StandingEndpoint`, `ProfileEndpoint`, `DashboardEndpoint`, and `SearchEndpoint` are all live -- **every item on the Phase 1 checklist below now has a server endpoint behind it.** Org/League/Team/Event/ScheduledMatch writes share `requireOrgRole` (`bgs_server/lib/src/organizations/organization_access.dart`) for org-scoped resources; two narrower "is this your own row" patterns exist alongside it -- `TeamMembership.acceptInvite`/`declineInvite` (player accepting/declining their own invite) and `Event.update`/`publish` for *orgless* events (creator-only, since there's no org role to check). `StandingEndpoint` is deliberately read-only -- `Standing` rows are a recomputed aggregate written only by `ScheduledMatchEndpoint.recordResult`, never directly. `ProfileEndpoint` is the odd one out: no BGS code in it at all, just `class ProfileEndpoint extends UserProfileEditBaseEndpoint {}` -- the auth module already ships the full self-service profile surface, same pattern as `EmailIdpEndpoint` extending `EmailIdpBaseEndpoint`. `DashboardEndpoint` (`player`/`organizer`/`manager`) is pure server-side composition over existing tables via nested `include()` chains -- no new writes, no new exceptions. Player lookup for team invites goes through `UserProfile.email` (queryable because `serverpod_auth_core_server`'s top-level export re-exports its full generated protocol, not just the DTOs). See CHANGELOG.md for specifics. Test pattern to copy: `AuthUsers().create()` + `AuthenticationOverride.authenticationInfo()` for authenticated test sessions, `UserProfiles().createUserProfile()` when a test user needs a profile/email, `TestSessionBuilder` (not `Session`) as the type passed into generated `endpoints.x.method(...)` test wrappers.

**Model-yaml gotcha found and fixed:** a nullable relation field (e.g. `organization: Organization?, relation(onDelete=Cascade)`) only makes the *loaded object reference* nullable -- the underlying foreign-key id column still generates as required unless you also add `relation(optional)`. `Event.organizationId` had this bug from the original domain-model pass; caught it before building `EventEndpoint` on top of it. Checked `ScheduledMatch` and `Standing` while building those endpoints -- both correctly non-optional, so no further fix needed there.

**Gap found and fixed while building the Manager Dashboard:** `TeamEndpoint.invitePlayer` had no way to invite someone as a `manager` (always defaulted to `player`), and there was no way to list a team's roster at all. Both fixed (optional `role` param on `invitePlayer`; new public `TeamEndpoint.listMembers`) -- worth remembering that writing the read side surfaced a write-side gap that wouldn't have been obvious otherwise. Same lesson as the `Event.organizationId` fix: build the consumer before trusting the producer is complete.

**Deferred, not forgotten:** profile image upload (`setUserImage`/`removeUserImage`) is exposed but untested -- no file storage backend is configured for local dev yet. Revisit alongside whatever object storage gets picked for the hosting setup (§8/Open Decisions territory, not decided yet).

**Flutter login screen shipped (2026-08-04):** first real UI, and the first thing to actually consume the backend end-to-end. Confirms the whole chain works -- Flutter web → `EmailIdpEndpoint` → `AuthUser`/`UserProfile` creation → session persistence → `ProfileEndpoint` read. Also stood up the theming system that was promised since day one but never actually built (`bgs_flutter/lib/theme/app_theme.dart`), and along the way caught two real gaps: a stale server port in `assets/config.json` (see CHANGELOG "Fixed"), and the theming decision itself having gone unimplemented for the entire backend-building phase -- worth noting as a pattern: decisions recorded in §1 don't enforce themselves, they need something to actually go check them against running code. Local dev workflow for testing the Flutter app: `.claude/launch.json` has a `bgs-flutter-web` config (`flutter run -d web-server --web-port 19200`); needs `bgs_server`'s docker containers up and `dart bin/main.dart` running first. Verification codes during local email sign-up show up in the server console log (`server.dart`'s `_sendRegistrationCode`), not a real inbox -- Resend isn't wired up yet.

**Next up:** no real dashboard UI exists yet -- `home_screen.dart` is a deliberately minimal placeholder (just proves the profile round-trip). Building the actual Player/Organizer/Manager dashboard screens against `DashboardEndpoint` is the natural next chunk of Flutter work. Google/Apple Sign-In (a stated v1 goal in §1) still isn't wired server-side -- only email is registered as a provider in `server.dart`; needs OAuth credentials and platform configuration the user will need to provide before that can happen. A first Jaspr public page is still open too, and still the way to de-risk Jaspr's pre-1.0 status (§7).

Each area shipped at a genuinely minimal but real depth:
- Organization creation + basic org homepage (public, lists leagues/events)
- League creation + basic management (edit details, activate)
- Team management + player invites
- Manual schedule creation (no auto-scheduling algorithm yet)
- Profiles (player)
- Player Dashboard (my teams/leagues/events), Organizer Dashboard (my orgs/leagues), Manager Dashboard (my team)
- Event creation (including orgless one-off events) + shareable Event Links
- Basic standings (win/loss/set record)
- Basic search (by sport, by org/league/event name)

Explicitly deferred out of Phase 1: auto-scheduling, playoff brackets, stats, webcal, message boards, notifications.

### Phase 2 — Sport depth + competition structure
- Volleyball-specific scoring (sets, best-of-N, tiebreak rules)
- Soccer/kickball-specific scoring (single running score) — added deliberately here, not deferred to a separate "sport #2" phase, to validate the scoring abstraction generalizes beyond set-based sports
- Playoff bracket generation
- Webcal (.ics) export for schedules
- Player stats (basic, per-sport)

### Phase 3 — Payments
- Stripe Connect Express onboarding via embedded components (`flutter_stripe_connect`)
- League/event platform fee charge at creation (per pricing model)
- Optional platform payment processing for player registration fees (`flutter_stripe` PaymentSheet)
- Payout handling, basic dispute/refund path

### Phase 4 — Nice-to-haves / consider list
RSVP, attendance, team messages, sub portal, notifications (push/email/SMS), general message board, white-labeling (themes + URL slugs — theming groundwork from Phase 0 pays off here), player connections, apparel store links, championship prize ordering, location management, Mailchimp integration, player data download.

## 6. Roles & Dashboards

- **Player** — joins teams, views schedule/standings, registers for events.
- **Manager** — runs a single team within a league (roster, invites, lineup).
- **Organizer** — runs one or more Organizations (leagues, events, activation, fee setting).
- **Platform Admin** (not in original list, but needed) — internal tooling for support, dispute handling, and monitoring platform-fee collection. Worth scoping minimally in Phase 3 alongside payments.

## 7. Open Decisions

All decisions from the initial planning pass are resolved (see §1). Nothing currently blocks starting Phase 0. Items to revisit later:

- **True passwordless magic links** — deferred by design; revisit once Phase 1 core flows are proven and there's bandwidth to build custom passwordless auth on Serverpod's session primitives.
- **Jaspr pre-1.0 risk** — validate via the Phase 0 spike (see §8); if the API proves too unstable, Next.js remains the fallback, accepting the two-language cost.
- **Sport #3+** — once volleyball and soccer/kickball are both live, decide the next addition based on real organizer demand rather than pre-planning further now. Full long-term sport list tracked in [SPORTS_ROADMAP.md](SPORTS_ROADMAP.md).
- **"Public" currently means "logged in," not "anonymous."** Every endpoint has `requireLogin => true` at the class level, including ones documented as "public" (org homepages, league pages, search). That doc language refers to *no org-role check*, not literal unauthenticated access -- a truly anonymous visitor can't currently call any BGS endpoint. This hasn't mattered yet because nothing has consumed the API anonymously. It *will* matter for the Jaspr public site (org homepages, event links, search are all supposed to be crawlable/shareable without an account) and needs a real answer before that gets built: either flip specific read methods to `requireLogin => false`, or have the Jaspr server authenticate as a fixed service account and treat that as the trust boundary instead. Flagging now so it's a deliberate choice, not a surprise mid-build.

## 8. Immediate Next Steps

1. Scaffold the three-part repo structure (Flutter app / Serverpod backend / Jaspr public-site).
2. Spike: minimal Jaspr page reading from a stub Serverpod endpoint, deployed to Railway — validate the toolchain before building real pages on it.
3. Stand up Serverpod Cloud account/project for the backend.
4. Stand up the design-token theming system with a neutral BGS placeholder theme.
5. Start `CHANGELOG.md`.
