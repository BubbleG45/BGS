import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/dashboard_tab_view.dart';
import 'dashboard/manager_dashboard_view.dart';
import 'dashboard/organizer_dashboard_view.dart';
import 'dashboard/player_dashboard_view.dart';

/// Post-sign-in home: the three role dashboards from BUILD_PLAN.md §6 as
/// tabs. Roles aren't a fixed flag on the user -- they're derived from data
/// (team memberships, org memberships), so anyone could have content under
/// any tab. All three are always shown rather than trying to guess which
/// role(s) apply.
class DashboardScreen extends StatelessWidget {
  final Future<void> Function()? onSignOut;

  const DashboardScreen({super.key, this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Better Group Sports'),
          actions: [
            IconButton(
              onPressed: onSignOut,
              icon: const Icon(Icons.logout),
              tooltip: 'Sign out',
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Player', icon: Icon(Icons.sports_volleyball)),
              Tab(text: 'Organizer', icon: Icon(Icons.corporate_fare)),
              Tab(text: 'Manager', icon: Icon(Icons.groups)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DashboardTabView<PlayerDashboard>(
              fetch: () => client.dashboard.player(),
              builder: (context, data) => PlayerDashboardView(dashboard: data),
            ),
            DashboardTabView<OrganizerDashboard>(
              fetch: () => client.dashboard.organizer(),
              builder: (context, data) => OrganizerDashboardView(dashboard: data),
            ),
            DashboardTabView<ManagerDashboard>(
              fetch: () => client.dashboard.manager(),
              builder: (context, data) => ManagerDashboardView(dashboard: data),
            ),
          ],
        ),
      ),
    );
  }
}
