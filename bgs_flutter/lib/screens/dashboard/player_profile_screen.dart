import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';

import '../../main.dart';

/// The Profile nav destination -- a simplified "trading card" identity
/// view. The `player_profile` mockup shows jersey number, position, and
/// goals/assists stats, none of which exist in the data model (no
/// per-sport position field, no stats tracking -- see BUILD_PLAN.md
/// Phase 4). This keeps the photo-card visual identity with only what's
/// real: name and team affiliation from [PlayerDashboard].
class PlayerProfileScreen extends StatefulWidget {
  const PlayerProfileScreen({super.key});

  @override
  State<PlayerProfileScreen> createState() => _PlayerProfileScreenState();
}

class _ProfileData {
  final UserProfileModel profile;
  final List<TeamMembership> teamMemberships;

  _ProfileData({required this.profile, required this.teamMemberships});
}

class _PlayerProfileScreenState extends State<PlayerProfileScreen> {
  late Future<_ProfileData> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_ProfileData> _load() async {
    final results = await Future.wait([
      client.profile.get(),
      client.dashboard.player(),
    ]);
    final profile = results[0] as UserProfileModel;
    final playerDashboard = results[1] as PlayerDashboard;
    return _ProfileData(
      profile: profile,
      teamMemberships: playerDashboard.teamMemberships
          .where((m) => m.status == MembershipStatus.active)
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<_ProfileData>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Could not load your profile: ${snapshot.error}'));
        }

        final data = snapshot.data!;
        final profile = data.profile;
        final displayName = profile.fullName ?? profile.userName ?? profile.email ?? 'Player';
        final teamNames = data.teamMemberships
            .map((m) => m.team?.name)
            .whereType<String>()
            .toList();

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: theme.colorScheme.outlineVariant),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              theme.colorScheme.primary,
                              theme.colorScheme.primaryContainer,
                            ],
                          ),
                          image: profile.imageUrl == null
                              ? null
                              : DecorationImage(
                                  image: NetworkImage(profile.imageUrl.toString()),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          displayName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.headlineLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('TEAMS', style: theme.textTheme.labelMedium),
                                  const SizedBox(height: 4),
                                  Text(
                                    teamNames.isEmpty ? 'No active teams' : teamNames.join(', '),
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
