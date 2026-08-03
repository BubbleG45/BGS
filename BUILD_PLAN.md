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

**Resume point (as of 2026-08-03):** domain model/schema is built and migrated (see CHANGELOG.md). `OrganizationEndpoint` is live (`create`/`getById`/`getBySlug`/`listMine`), with a reusable `requireOrgRole` authorization helper in `bgs_server/lib/src/organizations/organization_access.dart` — reuse this for League/Team/Event authorization instead of re-deriving the pattern. Covered by integration tests in `bgs_server/test/integration/organization_endpoint_test.dart` (pattern to copy: `AuthUsers().create()` + `AuthenticationOverride.authenticationInfo()` to build an authenticated test session without going through full email registration).

**Next up:** `LeagueEndpoint` (create/get/list within an org, gated by `requireOrgRole(..., minRole: OrgMemberRole.admin)`), then `TeamEndpoint` + the player-invite flow (`TeamMembership` with `status: invited` → an accept/decline action). Both follow the same shape as `OrganizationEndpoint` now that the pattern is established.

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

## 8. Immediate Next Steps

1. Scaffold the three-part repo structure (Flutter app / Serverpod backend / Jaspr public-site).
2. Spike: minimal Jaspr page reading from a stub Serverpod endpoint, deployed to Railway — validate the toolchain before building real pages on it.
3. Stand up Serverpod Cloud account/project for the backend.
4. Stand up the design-token theming system with a neutral BGS placeholder theme.
5. Start `CHANGELOG.md`.
