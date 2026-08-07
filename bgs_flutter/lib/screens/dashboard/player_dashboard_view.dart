import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/format.dart';
import '../../widgets/dashboard_section.dart';
import '../../widgets/status_chip.dart';
import '../../widgets/team_crest.dart';
import '../browse/event_detail_screen.dart';
import '../browse/league_detail_screen.dart';
import '../browse/match_detail_screen.dart';

StatusTone _membershipTone(MembershipStatus status) => switch (status) {
      MembershipStatus.active => StatusTone.positive,
      MembershipStatus.invited => StatusTone.neutral,
      MembershipStatus.declined => StatusTone.negative,
    };

StatusTone _registrationTone(EventRegistrationStatus status) => switch (status) {
      EventRegistrationStatus.registered => StatusTone.positive,
      EventRegistrationStatus.cancelled => StatusTone.negative,
    };

/// "My teams/events" -- backs the Player role of [HomeDestination].
///
/// Match cards are informational only -- no Going/Decline RSVP, since
/// there's no per-player attendance model for RSVP purposes (`ScheduledMatch`
/// is team-vs-team only; see BUILD_PLAN.md Phase C for the deferred RSVP
/// feature -- lightweight manager-recorded attendance is a separate, already
/// -shipped thing, see the Manager dashboard). "My Teams" has no "Join Team"
/// add-card either, since membership stays invite-only.
///
/// Upcoming games are filtered to the next 7 days, and "My Teams" is split
/// into current vs. past based on the team's league status (`completed`
/// leagues are past).
class PlayerDashboardView extends StatelessWidget {
  final PlayerDashboard dashboard;

  const PlayerDashboardView({super.key, required this.dashboard});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final weekFromNow = now.add(const Duration(days: 7));
    final upcomingWithinWeek = dashboard.upcomingMatches
        .where((m) => m.scheduledAt.isBefore(weekFromNow))
        .toList();
    final upcomingEventRegistrations = dashboard.eventRegistrations.where((r) {
      final startAt = r.event?.startAt;
      return startAt != null && startAt.isAfter(now) && startAt.isBefore(weekFromNow);
    }).toList();

    final currentTeams = dashboard.teamMemberships
        .where((m) => m.team?.league?.status != LeagueStatus.completed)
        .toList();
    final pastTeams = dashboard.teamMemberships
        .where((m) => m.team?.league?.status == LeagueStatus.completed)
        .toList();

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        DashboardSection(
          title: 'Upcoming Games (Next 7 Days)',
          emptyMessage: 'No games scheduled in the next week.',
          children: [
            for (final match in upcomingWithinWeek) _GameCard(match: match),
          ],
        ),
        DashboardSection(
          title: 'Upcoming Events (Next 7 Days)',
          emptyMessage: 'No registered events in the next week.',
          children: [
            for (final registration in upcomingEventRegistrations)
              _EventRegistrationTile(registration: registration),
          ],
        ),
        _MyTeamsSection(title: 'My Teams', memberships: currentTeams),
        _MyTeamsSection(title: 'Past Teams', memberships: pastTeams),
      ],
    );
  }
}

class _GameCard extends StatelessWidget {
  final ScheduledMatch match;

  const _GameCard({required this.match});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeName = match.homeTeam?.name ?? 'TBD';
    final awayName = match.awayTeam?.name ?? 'TBD';

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MatchDetailScreen(
              match: match,
              homeTeamName: homeName,
              awayTeamName: awayName,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TeamCrest(name: homeName, size: 56),
                        const SizedBox(height: 8),
                        Text(homeName, textAlign: TextAlign.center, style: theme.textTheme.labelMedium),
                      ],
                    ),
                  ),
                  Text('VS', style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  Expanded(
                    child: Column(
                      children: [
                        TeamCrest(name: awayName, size: 56),
                        const SizedBox(height: 8),
                        Text(awayName, textAlign: TextAlign.center, style: theme.textTheme.labelMedium),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(formatDateTime(match.scheduledAt), style: theme.textTheme.bodyMedium),
                    if (match.location != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        match.location!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventRegistrationTile extends StatelessWidget {
  final EventRegistration registration;

  const _EventRegistrationTile({required this.registration});

  @override
  Widget build(BuildContext context) {
    final event = registration.event;

    return Card(
      child: ListTile(
        title: Text(event?.name ?? 'Unknown event'),
        subtitle: Text([
          if (event != null) formatDateTime(event.startAt),
          if (registration.teamName != null) registration.teamName!,
        ].join(' · ')),
        trailing: StatusChip(
          formatEnumLabel(registration.status.name),
          tone: _registrationTone(registration.status),
        ),
        onTap: event == null
            ? null
            : () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EventDetailScreen(eventId: event.id!)),
                ),
      ),
    );
  }
}

class _MyTeamsSection extends StatelessWidget {
  final String title;
  final List<TeamMembership> memberships;

  const _MyTeamsSection({required this.title, required this.memberships});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.sm),
          if (memberships.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Text(
                "No teams here yet.",
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            )
          else
            SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: memberships.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) => _TeamMembershipCard(membership: memberships[index]),
              ),
            ),
        ],
      ),
    );
  }
}

class _TeamMembershipCard extends StatelessWidget {
  final TeamMembership membership;

  const _TeamMembershipCard({required this.membership});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final team = membership.team;
    final league = team?.league;

    return SizedBox(
      width: 140,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: league == null
              ? null
              : () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LeagueDetailScreen(leagueId: league.id!)),
                  ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TeamCrest(name: team?.name ?? '?', size: 56),
                const SizedBox(height: 8),
                Text(
                  team?.name ?? 'Unknown team',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
                if (league != null)
                  Text(
                    formatEnumLabel(league.sport.name),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                StatusChip(
                  formatEnumLabel(membership.status.name),
                  tone: _membershipTone(membership.status),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
