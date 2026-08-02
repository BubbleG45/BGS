# Changelog

All notable features and changes to BGS are logged here as they land, newest first.

## Unreleased

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
