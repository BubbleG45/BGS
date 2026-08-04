import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../utils/format.dart';
import '../../widgets/dashboard_section.dart';
import '../../widgets/status_chip.dart';

StatusTone _membershipTone(MembershipStatus status) => switch (status) {
      MembershipStatus.active => StatusTone.positive,
      MembershipStatus.invited => StatusTone.neutral,
      MembershipStatus.declined => StatusTone.negative,
    };

StatusTone _registrationTone(EventRegistrationStatus status) => switch (status) {
      EventRegistrationStatus.registered => StatusTone.positive,
      EventRegistrationStatus.cancelled => StatusTone.negative,
    };

/// "My teams/events" -- backs the Player tab of [DashboardScreen].
class PlayerDashboardView extends StatelessWidget {
  final PlayerDashboard dashboard;

  const PlayerDashboardView({super.key, required this.dashboard});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        DashboardSection(
          title: 'My Teams',
          emptyMessage: "You haven't joined any teams yet.",
          children: [
            for (final membership in dashboard.teamMemberships)
              _TeamMembershipTile(membership: membership),
          ],
        ),
        DashboardSection(
          title: 'My Event Registrations',
          emptyMessage: "You haven't registered for any events yet.",
          children: [
            for (final registration in dashboard.eventRegistrations)
              _EventRegistrationTile(registration: registration),
          ],
        ),
        DashboardSection(
          title: 'Upcoming Matches',
          emptyMessage: 'No upcoming matches scheduled.',
          children: [
            for (final match in dashboard.upcomingMatches) _MatchTile(match: match),
          ],
        ),
      ],
    );
  }
}

class _TeamMembershipTile extends StatelessWidget {
  final TeamMembership membership;

  const _TeamMembershipTile({required this.membership});

  @override
  Widget build(BuildContext context) {
    final team = membership.team;
    final league = team?.league;
    final subtitleParts = [
      if (league != null) league.name,
      if (league?.organization != null) league!.organization!.name,
    ];

    return Card(
      child: ListTile(
        title: Text(team?.name ?? 'Unknown team'),
        subtitle: subtitleParts.isEmpty ? null : Text(subtitleParts.join(' · ')),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            StatusChip(
              formatEnumLabel(membership.status.name),
              tone: _membershipTone(membership.status),
            ),
            const SizedBox(height: 4),
            Text(
              formatEnumLabel(membership.role.name),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
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
      ),
    );
  }
}

class _MatchTile extends StatelessWidget {
  final ScheduledMatch match;

  const _MatchTile({required this.match});

  @override
  Widget build(BuildContext context) {
    final homeName = match.homeTeam?.name ?? 'TBD';
    final awayName = match.awayTeam?.name ?? 'TBD';

    return Card(
      child: ListTile(
        title: Text('$homeName vs $awayName'),
        subtitle: Text([
          formatDateTime(match.scheduledAt),
          if (match.location != null) match.location!,
        ].join(' · ')),
      ),
    );
  }
}
