import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';

import '../../main.dart';
import '../../theme/app_theme.dart';
import '../../utils/format.dart';
import 'org_settings_screen.dart';

/// The Profile nav destination -- identity, bio, aggregate stats, and (for
/// organizers) a jump-off point to each org's settings. The mockup's
/// jersey number, position, and per-player goals/assists stats aren't
/// built -- no per-sport position field, no player-level stats tracking
/// (see BUILD_PLAN.md Phases C). Wins/losses *are* real: a straight
/// roll-up of every team the player has been on, from `Standing` rows via
/// `PlayerProfileEndpoint.stats`. "Championships" has nothing to honestly
/// compute yet (no bracket/winner concept exists) -- shown as a clearly
/// marked coming-soon section rather than faked.
class PlayerProfileScreen extends StatefulWidget {
  const PlayerProfileScreen({super.key});

  @override
  State<PlayerProfileScreen> createState() => _PlayerProfileScreenState();
}

class _ProfileData {
  final UserProfileModel profile;
  final PlayerProfile? playerProfile;
  final PlayerStats stats;
  final List<TeamMembership> teamMemberships;
  final List<OrganizationMembership> organizations;

  _ProfileData({
    required this.profile,
    required this.playerProfile,
    required this.stats,
    required this.teamMemberships,
    required this.organizations,
  });
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
      client.playerProfile.getMine(),
      client.playerProfile.stats(),
      client.dashboard.player(),
      client.dashboard.organizer(),
    ]);
    final profile = results[0] as UserProfileModel;
    final playerProfile = results[1] as PlayerProfile?;
    final stats = results[2] as PlayerStats;
    final playerDashboard = results[3] as PlayerDashboard;
    final organizerDashboard = results[4] as OrganizerDashboard;

    return _ProfileData(
      profile: profile,
      playerProfile: playerProfile,
      stats: stats,
      teamMemberships: playerDashboard.teamMemberships
          .where((m) => m.status == MembershipStatus.active)
          .toList(),
      organizations: organizerDashboard.organizations,
    );
  }

  Future<void> _refresh() async {
    final data = await _load();
    if (!mounted) return;
    setState(() => _future = Future.value(data));
  }

  Future<void> _editBio(String? currentBio) async {
    final controller = TextEditingController(text: currentBio);
    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit bio'),
        content: TextField(
          controller: controller,
          maxLines: 4,
          decoration: const InputDecoration(hintText: 'Tell other players about yourself'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (saved != true) return;

    try {
      await client.playerProfile.updateBio(controller.text.trim());
      await _refresh();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not save bio: $e')));
    }
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

        final currentTeams = data.teamMemberships
            .where((m) => m.team?.league?.status != LeagueStatus.completed)
            .toList();
        final pastTeams = data.teamMemberships
            .where((m) => m.team?.league?.status == LeagueStatus.completed)
            .toList();

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(color: theme.colorScheme.outlineVariant),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [theme.colorScheme.primary, theme.colorScheme.primaryContainer],
                              ),
                              image: profile.imageUrl == null
                                  ? null
                                  : DecorationImage(
                                      image: NetworkImage(profile.imageUrl.toString()),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.all(AppSpacing.xl),
                            child: Text(
                              displayName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.headlineLarge?.copyWith(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(AppSpacing.xl),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('BIO', style: theme.textTheme.labelMedium),
                                    IconButton(
                                      onPressed: () => _editBio(data.playerProfile?.bio),
                                      icon: const Icon(Symbols.edit, size: 20),
                                      tooltip: 'Edit bio',
                                    ),
                                  ],
                                ),
                                Text(
                                  data.playerProfile?.bio ?? 'No bio yet.',
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _StatColumn(label: 'WINS', value: '${data.stats.wins}'),
                            _StatColumn(label: 'LOSSES', value: '${data.stats.losses}'),
                            _StatColumn(label: 'TIES', value: '${data.stats.ties}'),
                            _StatColumn(label: 'TEAMS', value: '${data.stats.teamCount}'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Symbols.emoji_events, color: theme.colorScheme.onSurfaceVariant),
                                const SizedBox(width: AppSpacing.sm),
                                Text('Championships', style: theme.textTheme.titleMedium),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'Coming soon -- once playoff brackets and league winners are '
                              'tracked, your championships will show up here.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('TEAMS', style: theme.textTheme.labelMedium),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        currentTeams.isEmpty
                            ? 'No current teams'
                            : currentTeams.map((m) => m.team?.name ?? 'Unknown team').join(', '),
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    if (pastTeams.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.md),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('PAST TEAMS', style: theme.textTheme.labelMedium),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          pastTeams.map((m) => m.team?.name ?? 'Unknown team').join(', '),
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                    if (data.organizations.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xl),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('ORGANIZATIONS', style: theme.textTheme.labelMedium),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      for (final membership in data.organizations)
                        Card(
                          child: ListTile(
                            title: Text(membership.organization.name),
                            subtitle: Text(formatEnumLabel(membership.role.name)),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OrgSettingsScreen(
                                  organizationId: membership.organization.id!,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;

  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(value, style: theme.textTheme.headlineMedium),
        Text(label, style: theme.textTheme.labelMedium),
      ],
    );
  }
}
