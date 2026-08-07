import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/app_theme.dart';

/// One destination in [AppShell]'s primary navigation.
class AppShellDestination {
  final IconData icon;
  final String label;
  final Widget page;

  const AppShellDestination({required this.icon, required this.label, required this.page});
}

/// Responsive app chrome: a bottom [NavigationBar] on narrow (mobile-shaped)
/// windows, a persistent left sidebar on wide (desktop-shaped) ones --
/// matching the "Kinetic Stadium" mockups' `player_dashboard`/
/// `organizer_dashboard` breakpoint (`md:` in their Tailwind markup, ~768px)
/// -- replaces the app's original top [TabBar] shell.
class AppShell extends StatefulWidget {
  final String title;
  final List<AppShellDestination> destinations;
  final List<Widget> actions;
  final String? headerName;
  final String? headerSubtitle;
  final ImageProvider? headerImage;

  const AppShell({
    super.key,
    required this.title,
    required this.destinations,
    this.actions = const [],
    this.headerName,
    this.headerSubtitle,
    this.headerImage,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final body = IndexedStack(
      index: _index,
      children: [for (final destination in widget.destinations) destination.page],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (AppBreakpoints.isDesktop(constraints.maxWidth)) {
          return Scaffold(
            body: Row(
              children: [
                _Sidebar(
                  destinations: widget.destinations,
                  selectedIndex: _index,
                  onSelect: (index) => setState(() => _index = index),
                  headerName: widget.headerName,
                  headerSubtitle: widget.headerSubtitle,
                  headerImage: widget.headerImage,
                ),
                Expanded(
                  child: Scaffold(
                    appBar: AppBar(title: Text(widget.title), actions: widget.actions),
                    body: body,
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(widget.title), actions: widget.actions),
          body: body,
          bottomNavigationBar: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (index) => setState(() => _index = index),
            destinations: [
              for (final destination in widget.destinations)
                NavigationDestination(
                  icon: Icon(destination.icon),
                  selectedIcon: Icon(destination.icon, fill: 1),
                  label: destination.label,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _Sidebar extends StatelessWidget {
  final List<AppShellDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final String? headerName;
  final String? headerSubtitle;
  final ImageProvider? headerImage;

  const _Sidebar({
    required this.destinations,
    required this.selectedIndex,
    required this.onSelect,
    this.headerName,
    this.headerSubtitle,
    this.headerImage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 280,
      color: theme.colorScheme.surfaceContainerLow,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (headerName != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      backgroundImage: headerImage,
                      child: headerImage == null
                          ? Icon(Symbols.person, color: theme.colorScheme.onPrimaryContainer)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            headerName!,
                            style: theme.textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (headerSubtitle != null)
                            Text(
                              headerSubtitle!,
                              style: theme.textTheme.labelMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const Divider(height: 1),
            const SizedBox(height: 8),
            for (var i = 0; i < destinations.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                child: Material(
                  color: i == selectedIndex ? theme.colorScheme.primaryContainer : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: () => onSelect(i),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Icon(
                            destinations[i].icon,
                            fill: i == selectedIndex ? 1 : 0,
                            color: i == selectedIndex
                                ? theme.colorScheme.onPrimaryContainer
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            destinations[i].label,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: i == selectedIndex
                                  ? theme.colorScheme.onPrimaryContainer
                                  : theme.colorScheme.onSurface,
                              fontWeight: i == selectedIndex ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
