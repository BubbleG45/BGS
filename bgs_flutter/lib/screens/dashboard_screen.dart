import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';

import '../main.dart';
import '../widgets/app_shell.dart';
import 'browse/search_screen.dart';
import 'dashboard/home_destination.dart';
import 'dashboard/my_leagues_view.dart';
import 'dashboard/my_teams_view.dart';
import 'dashboard/player_profile_screen.dart';

/// Post-sign-in home. Wraps [AppShell] with the app's four primary
/// destinations -- Home (role-switched dashboards), Leagues, Teams,
/// Profile -- replacing the old top-`TabBar`-of-roles shell.
class DashboardScreen extends StatefulWidget {
  final Future<void> Function()? onSignOut;

  const DashboardScreen({super.key, this.onSignOut});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<UserProfileModel?> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _loadProfile();
  }

  Future<UserProfileModel?> _loadProfile() async {
    try {
      return await client.profile.get();
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfileModel?>(
      future: _profileFuture,
      builder: (context, snapshot) {
        final profile = snapshot.data;
        final displayName = profile?.fullName ?? profile?.userName ?? profile?.email;

        return AppShell(
          title: 'Better Group Sports',
          headerName: displayName,
          headerSubtitle: 'Better Group Sports',
          headerImage: profile?.imageUrl == null ? null : NetworkImage(profile!.imageUrl.toString()),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              ),
              icon: const Icon(Symbols.search),
              tooltip: 'Search',
            ),
            IconButton(
              onPressed: widget.onSignOut,
              icon: const Icon(Symbols.logout),
              tooltip: 'Sign out',
            ),
          ],
          destinations: const [
            AppShellDestination(icon: Symbols.home, label: 'Home', page: HomeDestination()),
            AppShellDestination(
              icon: Symbols.emoji_events,
              label: 'Leagues',
              page: MyLeaguesView(),
            ),
            AppShellDestination(icon: Symbols.groups, label: 'Teams', page: MyTeamsView()),
            AppShellDestination(
              icon: Symbols.person,
              label: 'Profile',
              page: PlayerProfileScreen(),
            ),
          ],
        );
      },
    );
  }
}
