# Changelog

All notable features and changes to BGS are logged here as they land, newest first.

## Unreleased

### Added (Flutter login screen -- first real UI, first consumer of the backend)
- `bgs_flutter/lib/theme/app_theme.dart`: the theming system promised since day one, actually stood up. `ColorScheme.fromSeed`-based light/dark `ThemeData` with a neutral placeholder seed color, plus themed `AppBarTheme`/`InputDecorationTheme`/`ElevatedButtonTheme`/`CardTheme` so screens never reach for a raw `Color`. Colocated in `bgs_flutter` for now -- BUILD_PLAN's cross-platform shared design-token package (also consumed by the Jaspr public site) is future work, once Jaspr actually has UI to share tokens with.
- Restyled `sign_in_screen.dart`: BGS name/tagline wrapped around the auth module's pre-built `SignInWidget` (unchanged auth logic, just branding + theme + a max-width-constrained, centered layout that works on both mobile and web/desktop).
- New `home_screen.dart` replacing the demo `greetings_screen.dart` (deleted, no longer referenced): minimal post-sign-in landing that calls the real `ProfileEndpoint.get()` and displays the signed-in user's name/email, with a sign-out action. Proves the auth + profile loop works end to end without building out the actual dashboards yet (separate, larger piece of work).
- `main.dart` now actually wires `SignInScreen` → `HomeScreen` (previously commented out, showing the raw demo `GreetingsScreen` unauthenticated) and sets real app branding (`MaterialApp.title`, theme, darkTheme).
- Verified the full flow in-browser against a real local server: sign-up → email verification code (read from the server's dev-mode console log, per the existing `_sendRegistrationCode` in `server.dart`) → password → signed in, profile displayed correctly → sign-out → sign back in with the same credentials. No console errors.

### Fixed
- `bgs_flutter/assets/config.json` had `apiUrl: http://localhost:8080` -- the Serverpod default, never updated after `bgs_server`'s dev ports were remapped to 18080+ (see the port-remap fix earlier in this log). The Flutter app would have silently connected to the wrong local server. Fixed to `http://localhost:18080`. This had gone unnoticed until now because nothing had actually run the Flutter app against a real local server before.
- Added `serverpod_auth_core_flutter` as a direct dependency of `bgs_flutter` -- needed `UserProfileModel` for the home screen and it wasn't reachable through `bgs_client` alone.

### Added (Search endpoint -- closes out Phase 1's backend checklist)
- `SearchEndpoint`: `search(query, sport)` across organizations, leagues, and events. Name matching is a case-insensitive `ILIKE` substring search with LIKE wildcard characters (`%`, `_`) escaped, so a literal search for e.g. `50%` doesn't get interpreted as a wildcard. Both `query` and `sport` are optional and combine with AND; calling with neither is a valid "browse" request, not an error.
- Only *discoverable* rows are searchable: leagues must be `active` and events must be `published` -- a draft an organizer hasn't published yet won't show up just because its name matches. Organizations have no such status. A sport-only search (no name query) skips organizations entirely, since sport doesn't mean anything for them.
- Results are capped at 20 per category, ordered by name (events by `startAt`) -- no ranking or pagination yet.
- New transient DTO `SearchResults`. No writes, no new typed exceptions.
- Integration tests in `search_endpoint_test.dart` (6 cases): name substring match across all three categories, draft/unpublished exclusion, sport-only filtering excluding organizations, name+sport combined filtering, LIKE-wildcard-escaping, and the no-filter browse case.

### Added (Dashboard endpoint)
- `DashboardEndpoint`: `player` (team memberships, event registrations, and upcoming `scheduled` matches for teams the player is *actively* on), `organizer` (org memberships with role, leagues, and events -- org-scoped across those orgs plus any orgless events the caller created), `manager` (only active `manager`-role team memberships). All server-side composition over tables that already exist -- deliberately server-side rather than assembled client-side, to keep the Flutter app thin and avoid N+1-style chains of calls for what's fundamentally one screen's worth of data.
- New transient DTOs `PlayerDashboard`, `OrganizerDashboard`, `ManagerDashboard`. No new writes, no new typed exceptions -- everything here is a read scoped to the calling user.
- Nested `include()` chains (e.g. `TeamMembership → Team → League → Organization`) populate related objects directly on the returned rows, so the dashboard payload carries what the UI needs without follow-up round trips.

### Fixed
- `TeamEndpoint.invitePlayer` had no way to invite someone as a `manager` -- it always defaulted to `player`, and no other write path touched `TeamMemberRole` at all. Found this while writing a Manager Dashboard test that had no way to produce a manager to test with. Added an optional `role` parameter (nullable, defaulting to `player` internally -- not a Dart default value, since those generate as client-required params, same gotcha as `Event.isTournament` earlier).
- Added `TeamEndpoint.listMembers` (public team roster read) -- there was previously no way to list a team's members at all, which the Manager Dashboard needs to be useful.

### Added (Profile endpoint)
- `ProfileEndpoint` extends the auth module's `UserProfileEditBaseEndpoint` directly -- same pattern as `EmailIdpEndpoint` extending `EmailIdpBaseEndpoint`. Gives `get`, `changeUserName`, `changeFullName`, `setUserImage`, `removeUserImage` for free, all self-scoped to the calling user via `session.authenticated`.
- No BGS-specific profile model was needed -- the auth module's `UserProfile`/`UserProfileModel` (userName/fullName/email/image) already covers Phase 1's needs, consistent with the original domain-model decision not to duplicate it.
- `setUserImage`/`removeUserImage` are exposed but not exercised by tests yet -- no file storage backend is configured for local dev, so they'd fail at runtime until that's set up (later phase).
- Integration tests in `profile_endpoint_test.dart` (4 cases): `get` returns the caller's own profile, `changeUserName`/`changeFullName` persist, and `get` throws `UserProfileNotFoundException` for a user with no profile yet.

### Added (ScheduledMatch + Standing endpoints)
- `ScheduledMatchEndpoint`: `create` (`admin`+ on the league's org, validates both teams belong to the league and aren't the same team), `getById`/`listByLeague` (public reads), `update` (reschedule time/location), `cancel` (`scheduled` → `cancelled` only), `recordResult` (`scheduled` → `completed` only, sets both scores and recomputes both teams' `Standing` rows in the same transaction).
- `StandingEndpoint`: `listByLeague` only (public, sorted by wins) -- deliberately no create/update surface, since standings are a recomputed aggregate maintained entirely by `recordResult`, not a separate source of truth. Sort is wins-only for Phase 1; win percentage / point differential as tiebreakers are a later enhancement.
- Typed exceptions: `ScheduledMatchNotFoundException`, `SameTeamMatchException`, `TeamNotInLeagueException`, `MatchActionNotAllowedException` (covers both cancel and recordResult being rejected on a non-`scheduled` match).
- Integration tests in `scheduled_match_endpoint_test.dart` (12 cases): create + org-gating, same-team validation, team-not-in-league validation, reschedule, cancel (success + already-cancelled rejection), recordResult (win/loss standings, tie standings, already-completed rejection, accumulation across two matches for the same team), and public reads.

### Added (Event endpoint + registration flow)
- `EventEndpoint`: `create` (org-scoped or "orgless" -- `organizationId` is optional; org-scoped events require `admin`+ on the org, orgless events just require login), `getById`/`getBySlug`/`listByOrganization` (public reads -- `getBySlug` backs the shareable `/e/<slug>` link), `update`, `publish` (draft → published only), `register`/`cancelRegistration` (event registration, independent of any league team), `listMyRegistrations` (Player Dashboard).
- New permission pattern for `update`/`publish`: org-scoped events check `requireOrgRole` like everything else, but orgless events have no organization to check a role against, so management permission falls to whoever created the event instead. Centralized in a private `_requireManagePermission` helper so the branching lives in one place.
- `cancelRegistration` reuses the "is this your own row" pattern from `TeamEndpoint.acceptInvite`/`declineInvite`, this time for event registrations.
- Typed exceptions: `EventNotFoundException`, `EventSlugTakenException` (slugs are unique platform-wide, not per-org, since orgless events still need a global shareable link), `EventAccessDeniedException`, `EventPublishNotAllowedException`, `EventNotOpenForRegistrationException`, `EventRegistrationAlreadyExistsException`, `EventRegistrationNotFoundException`, `EventRegistrationAccessDeniedException`, `EventRegistrationActionNotAllowedException`.
- Integration tests in `event_endpoint_test.dart` (17 cases) covering org-scoped vs. orgless create/permission branching, slug collisions, publish (org admin, orgless creator, non-creator denial, already-published rejection), partial update, registration (success, unpublished-event rejection, duplicate rejection), cancellation (success, wrong-user denial, double-cancel rejection), `listMyRegistrations`, and public reads by non-members.

### Fixed
- `Event.organizationId` was missing `relation(optional)` in the original domain-model pass, so it generated as a *required* foreign key -- silently breaking the documented "orgless events" design before any endpoint used it. Added `relation(optional)` and applied a migration (`20260803235219982`) to make the column nullable; no data existed yet, so no backfill was needed.

### Added (Team endpoint + player-invite flow)
- `TeamEndpoint`: `create` (`admin`+ on the team's league's org), `getById`/`listByLeague` (public reads), `invitePlayer` (looks the invitee up by verified email via `UserProfile`, `admin`+ required, creates a `TeamMembership` with `status: invited`), `acceptInvite`/`declineInvite`, `listMine` (backs the Player Dashboard's "my teams").
- New authorization pattern for `acceptInvite`/`declineInvite`: not an org-role check like every other write so far -- just "is the calling `AuthUser` the one on this membership row." First player-side write in the app; deliberately kept separate from `requireOrgRole` since the player usually isn't an org member at all.
- Typed exceptions `TeamNotFoundException`, `TeamMembershipNotFoundException`, `PlayerNotFoundException` (invited email has no BGS account yet -- invite-before-signup is a later enhancement), `TeamMembershipAlreadyExistsException`, `TeamMembershipAccessDeniedException` (wrong user resolving someone else's invite), `TeamMembershipActionNotAllowedException` (resolving an already-resolved invite).
- Integration tests in `team_endpoint_test.dart` (11 cases): create + org-gating, invite-by-email success/unknown-email/duplicate, accept/decline success, wrong-user denial, double-resolve rejection, `listMine`, and public reads by non-members.

### Added (League endpoint)
- `LeagueEndpoint`: `create` (draft status, `admin`+ on the org required, slug pre-checked unique within org), `activate` (draft → active only, typed error otherwise), `update` (partial update of basic fields), `getById`/`getByOrgAndSlug`/`listByOrganization` (all public reads — league pages are public, matching the org-read pattern).
- Reused `requireOrgRole` from the Organization work unchanged — confirms the shared authorization helper actually generalizes across endpoints as intended.
- Typed exceptions `LeagueSlugTakenException`, `LeagueNotFoundException`, `LeagueActivationNotAllowedException`.
- Integration tests in `league_endpoint_test.dart`: create/draft-status, non-member denial, slug collision, activate (success + already-active rejection), partial update, and public reads by non-members.

### Added (Organization endpoint — first live endpoint)
- `OrganizationEndpoint`: `create` (creates the org and makes the caller its `owner` via `OrganizationMember`), `getById`, `getBySlug` (public — no membership required, since org homepages are public pages), `listMine` (backs the Organizer Dashboard).
- `requireOrgRole` helper in `organization_access.dart` — the shared authorization pattern for "is this AuthUser a member of this org with sufficient role," meant to be reused by League/Team/Event endpoints rather than re-derived each time.
- Typed exceptions `OrganizationAccessDeniedException`, `OrganizationSlugTakenException` (slug uniqueness pre-checked in `create`, with the DB unique index as the actual race-condition backstop).
- Integration tests in `organization_endpoint_test.dart` covering ownership-on-create, slug collisions, and that org reads stay public while `listMine` stays scoped to actual membership.

### Added (Phase 1 domain model — schema only, no endpoints yet)
- `bgs_server` now references the auth module's `AuthUser` (via `module:auth:AuthUser`) instead of a separate BGS user table. Reused the auth module's built-in `UserProfile` (name/email/image) rather than inventing a duplicate — no BGS-specific profile model exists yet.
- Roles (Player / Organizer / Manager) are **not** stored as a field on the user — they're derived from membership rows (`OrganizationMember`, `TeamMembership`), so one person can be an organizer of their own org and a player on someone else's team.
- New models: `Organization`, `OrganizationMember`, `League`, `Team`, `TeamMembership`, `Event`, `EventRegistration`, `ScheduledMatch`, `Standing`.
- New enums: `Sport` (full list from SPORTS_ROADMAP.md), `SkillLevel`, `OrgMemberRole`, `LeagueStatus`, `TeamMemberRole`, `MembershipStatus`, `EventStatus`, `EventRegistrationStatus`, `MatchStatus`.
- `League.teamFeeCents` / `Event.teamFeeCents` capture the required-at-creation team fee per League_Platform_Pricing_Model.md, ahead of the payments phase actually using it.
- Migration `20260802205013639` created and applied against local Postgres; `dart analyze` clean across the workspace.

### Added
- Initial repo scaffold: Dart workspace with `bgs_server` (Serverpod backend), `bgs_client` (generated API client), `bgs_flutter` (app), and `bgs_web` (Jaspr public site), per [BUILD_PLAN.md](BUILD_PLAN.md).
- `bgs_web` wired to depend on `bgs_client` directly for typed calls into the Serverpod API instead of hand-rolled HTTP.
- Planning docs: [BUILD_PLAN.md](BUILD_PLAN.md), [SPORTS_ROADMAP.md](SPORTS_ROADMAP.md), [League_Platform_Pricing_Model.md](League_Platform_Pricing_Model.md).

### Fixed
- Remapped all local dev ports for `bgs_server` (18080-18091/19090-19091) and `bgs_web` (18180) off Serverpod/Jaspr defaults — this machine already runs another project on the 8080-9091 default range.
