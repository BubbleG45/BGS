# Changelog

All notable features and changes to BGS are logged here as they land, newest first.

## Unreleased

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
