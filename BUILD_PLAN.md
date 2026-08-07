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

**Flutter dashboard UI shipped (2026-08-04):** `DashboardScreen` (Player/Organizer/Manager tabs) replaces the `home_screen.dart` placeholder, backed directly by `DashboardEndpoint`. All three tabs share `DashboardTabView<T>`/`DashboardSection`/`StatusChip` rather than duplicating fetch/loading/error/empty-state boilerplate three times. Verified against real seeded data (org, league, two teams, a scheduled match, a published event with a registration) in-browser -- see CHANGELOG for what was checked. Two things worth remembering for next time: (1) `DashboardEndpoint.player`'s `upcomingMatches` needed `homeTeam`/`awayTeam` added to its `include()` -- easy to miss since the endpoint compiled and tested fine without it, the gap only showed up once real UI tried to display a team name; (2) the locally-running `dart bin/main.dart` process doesn't pick up source edits without a manual restart (no hot-reload for the CLI server), so a stale-server false negative is a real failure mode when iterating -- if a fix "doesn't seem to take effect" locally, restart the server process before assuming the code is wrong.

**Org/league/team creation screens shipped (2026-08-04):** `CreateOrganizationScreen`/`CreateLeagueScreen`/`CreateTeamScreen`, reachable via "+" buttons on the Organizer dashboard (org creation on the section header, league creation per-org, team creation per-league). This is the first write-side Flutter UI -- everything before this was read-only. Found and fixed a real bug in the process: `DashboardTabView`'s refresh mechanism (`setState(() => _future = next)`) silently threw on every call after the first, because an arrow function returning an assignment expression returns the assigned *value* (a `Future`), which violates `setState`'s void-callback contract -- see CHANGELOG "Fixed" for the full root-cause story. This means pull-to-refresh was **never actually working** on any dashboard tab before now, despite shipping in the previous session; it just hadn't been exercised. Worth remembering: a "the network call clearly succeeded but the UI didn't update" symptom in Flutter is worth checking for exactly this `setState` shape, since it fails silently with no visible error in the app.

**Write-side screens shipped (2026-08-04):** the remaining Phase 1 write gaps now have UI -- `LeagueTeamsScreen`/`TeamRosterScreen`/`InvitePlayerScreen` (invite a player to a team), a "Schedule match" action on the Organizer dashboard's league menu (`ScheduleMatchScreen`), an "Activate league" action on that same menu, and `CreateEventScreen` plus a per-event "Publish" action on the Organizer dashboard's Events section. Every Phase 1 write surface listed in the domain model now has a screen, not just an endpoint. One deliberate gap: the team roster screen shows role/status/invited-date, not player names/emails, since `TeamMembership` only carries `authUserId` -- extending `TeamEndpoint.listMembers` to join in a display name is the natural next roster improvement, not done here to keep this unit scoped. See CHANGELOG.md for the full list.

**Public-facing screens shipped (2026-08-04):** `OrgHomeScreen`, `LeagueDetailScreen`, `EventDetailScreen`, and `SearchScreen` (`bgs_flutter/lib/screens/browse/`) close out the last unbuilt item on the Phase 1 checklist below -- org homepage, league standings/schedule display, basic search, and event registration all now have real UI. These are reachable via a new search icon on `DashboardScreen` and by tapping through from dashboard tiles that previously weren't tappable (org/event tiles on the Organizer dashboard; team/registration tiles on Player and Manager). They're still gated behind Flutter's normal login, not truly public -- see the open decision below, unchanged by this work. Caught and fixed the same `setState(() => x = someFuture)` bug from the write-side-screens entry above, reintroduced fresh in `EventDetailScreen`; see CHANGELOG.md. Every Phase 1 feature area listed in §5 now has both a server endpoint and Flutter UI.

**Jaspr public-site spike shipped (2026-08-06):** resolved the §7 "public means logged in" open decision -- went with a new `PublicEndpoint` (`requireLogin => false`, narrow and read-only), over flipping `requireLogin` on the existing endpoints or a service-account login for Jaspr. `bgs_web`'s `/org/:slug` page now server-renders a real organization's active leagues and published events with zero login involved, verified by confirming the content is present in the raw HTML response (true SSR, not client hydration). Deploying to Railway (§8 step 2) is deliberately not done yet -- that's the user's Railway account to set up, not something to do autonomously; this pass proved the toolchain and the anonymous-access approach locally first. See CHANGELOG.md for the full writeup, including why `AsyncStatelessComponent` (not `FutureBuilder`) is the right tool for server-side data fetching in Jaspr.

**Jaspr league/event/search pages shipped (2026-08-06):** the public site now covers everything in the domain model's "public pages" list -- `LeaguePage` (`/org/:orgSlug/league/:leagueSlug`), `EventPage` (`/e/:slug`, matching the shareable-link convention), and `SearchPage` (`/search`, a plain GET form -- no client JS anywhere on this site yet). All three follow the org homepage's pattern exactly: `AsyncStatelessComponent`, not `@client`, reading through `PublicEndpoint`. `SearchEndpoint`'s query logic moved into a shared `performSearch()` helper so the authenticated and anonymous search paths can't drift apart. One known small gap: league results in search aren't clickable, since the search query doesn't currently join in the organization a league would need for its URL -- fine to leave until it's actually annoying someone.

**Kinetic Stadium visual restyle shipped (2026-08-06):** BGS's first real visual identity, sourced from a user-supplied folder of Stitch prototype screens (`stitch_better_group_sports_platform/`). Ported the design system's exact Material 3 color tokens, three-font typography, and Material Symbols icons into `AppTheme`; replaced the top-`TabBar` shell with a responsive bottom-nav (mobile) / sidebar (desktop) `AppShell`; restyled every existing Flutter screen and added three net-new ones (player profile, team detail, match detail) that the mockups depicted but the app didn't have. Did a feature audit against the actual Serverpod models before writing any UI and deliberately left out everything not backed by real data (RSVP, self-serve join/register, stats, chat, capacity, ratings, extra search filters, calendar/maps) rather than building against fake data -- those ideas are captured in Phase 4 below, not lost. Caught two real bugs via manual in-browser testing (a match-detail screen showing "TBD" for teams depending on which screen linked to it; a profile headline breaking on a long email fallback) -- see CHANGELOG.md for the full writeup, including a browser-preview-tooling artifact (not an app bug) noted for future reference. Explicitly did not touch `bgs_web`'s styling -- Jaspr uses a completely different CSS system, separate future effort.

**Next up:** Google/Apple Sign-In (a stated v1 goal in §1) still isn't wired server-side -- only email is registered as a provider in `server.dart`; needs OAuth credentials and platform configuration the user will need to provide before that can happen. Railway deployment is ready to attempt whenever the user has a Railway account/CLI session available -- but note it needs Serverpod Cloud (or some other public backend host) stood up first, since `bgs_web` deployed as-is would have nothing reachable to point `BGS_API_URL` at. Porting the Kinetic Stadium design tokens to `bgs_web` (Jaspr) is now a well-scoped, self-contained follow-up now that the Flutter side is done.

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

**Surfaced while designing the Kinetic Stadium visual restyle (2026-08-06)** — mockup elements with real product intent but no backing data today, captured here rather than built against fake data:
- **Per-player match RSVP** (Going/Decline) — same idea as the "RSVP, attendance" line above, specifically anchored to `ScheduledMatch`; there's no per-player attendance record today, matches are team-vs-team only.
- **Fair, transparent public league registration for captains** — a real self-serve path for a team captain to register their team into a league, distinct from today's invite-only individual player membership. Needs real design work (queueing/fairness rules), not a "Register Now" button wired to nothing.
- **Sport-specific player position** — e.g. "Striker" for soccer, but position vocabulary differs per sport, so this needs modeling as a per-sport lookup, not a flat field on the player/membership.
- **"Spots remaining" on league/event registration pages** — needs a capacity field (neither `League` nor `Event` has one today) plus a live registered-count query.
- **Search filters by day-of-week and skill-level** — built dynamically from what's actually scheduled/available per sport, not a static checkbox list; `SearchEndpoint` currently only filters by query + sport.

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
- ~~**"Public" currently means "logged in," not "anonymous."**~~ **Resolved (2026-08-06):** added `PublicEndpoint` (`bgs_server/lib/src/public/public_endpoint.dart`), a narrow `requireLogin => false` endpoint class exposing exactly what anonymous public pages need (currently: org-by-slug, its active leagues, its published events). Every other endpoint is unchanged and still requires login, including their other "public-in-spirit" read methods -- those remain reachable only from the logged-in Flutter app. Extend `PublicEndpoint` with more narrow methods as Jaspr grows more pages, rather than revisiting this decision per page.

## 8. Immediate Next Steps

1. Scaffold the three-part repo structure (Flutter app / Serverpod backend / Jaspr public-site).
2. ~~Spike: minimal Jaspr page reading from a stub Serverpod endpoint, deployed to Railway — validate the toolchain before building real pages on it.~~ **Done locally (2026-08-06)**, minus the Railway deployment step -- see the Phase 1 resume section above. `/org/:slug` renders real data via `PublicEndpoint`; deploying it to Railway is still open, pending the user's Railway account.
3. Stand up Serverpod Cloud account/project for the backend.
4. Stand up the design-token theming system with a neutral BGS placeholder theme.
5. Start `CHANGELOG.md`.
