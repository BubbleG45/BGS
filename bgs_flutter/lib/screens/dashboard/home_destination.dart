import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../main.dart';
import '../../widgets/dashboard_tab_view.dart';
import 'manager_dashboard_view.dart';
import 'organizer_dashboard_view.dart';
import 'player_dashboard_view.dart';

enum _Role { player, organizer, manager }

/// The Home nav destination. Roles aren't a fixed flag on the user --
/// they're derived from data (team memberships, org memberships), so
/// anyone could have content under any role. This used to be the app's
/// top-level `TabBar`; it moved one level in, under Home, once the nav
/// shell adopted the mockups' content-based destinations (Home/Leagues/
/// Teams/Profile) instead of role-based ones.
class HomeDestination extends StatefulWidget {
  const HomeDestination({super.key});

  @override
  State<HomeDestination> createState() => _HomeDestinationState();
}

class _HomeDestinationState extends State<HomeDestination> {
  _Role _role = _Role.player;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: SegmentedButton<_Role>(
            showSelectedIcon: false,
            style: SegmentedButton.styleFrom(textStyle: theme.textTheme.labelMedium),
            segments: const [
              ButtonSegment(
                value: _Role.player,
                label: Text('Player', softWrap: false, overflow: TextOverflow.ellipsis),
                icon: Icon(Symbols.sports_volleyball),
              ),
              ButtonSegment(
                value: _Role.organizer,
                label: Text('Organizer', softWrap: false, overflow: TextOverflow.ellipsis),
                icon: Icon(Symbols.corporate_fare),
              ),
              ButtonSegment(
                value: _Role.manager,
                label: Text('Manager', softWrap: false, overflow: TextOverflow.ellipsis),
                icon: Icon(Symbols.groups),
              ),
            ],
            selected: {_role},
            onSelectionChanged: (selected) => setState(() => _role = selected.first),
          ),
        ),
        Expanded(
          child: IndexedStack(
            index: _role.index,
            children: [
              DashboardTabView<PlayerDashboard>(
                fetch: () => client.dashboard.player(),
                builder: (context, data, refresh) => PlayerDashboardView(dashboard: data),
              ),
              DashboardTabView<OrganizerDashboard>(
                fetch: () => client.dashboard.organizer(),
                builder: (context, data, refresh) =>
                    OrganizerDashboardView(dashboard: data, onRefresh: refresh),
              ),
              DashboardTabView<ManagerDashboard>(
                fetch: () => client.dashboard.manager(),
                builder: (context, data, refresh) => ManagerDashboardView(dashboard: data),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
