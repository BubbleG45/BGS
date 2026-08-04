import 'package:flutter/material.dart';

/// Loads data for one dashboard tab and hands it to [builder], with
/// consistent loading/error/pull-to-refresh handling. All three dashboard
/// tabs (Player/Organizer/Manager) follow this same fetch-and-display shape.
class DashboardTabView<T> extends StatefulWidget {
  final Future<T> Function() fetch;
  final Widget Function(BuildContext context, T data, Future<void> Function() refresh) builder;

  const DashboardTabView({super.key, required this.fetch, required this.builder});

  @override
  State<DashboardTabView<T>> createState() => _DashboardTabViewState<T>();
}

class _DashboardTabViewState<T> extends State<DashboardTabView<T>>
    with AutomaticKeepAliveClientMixin<DashboardTabView<T>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.fetch();
  }

  Future<void> _refresh() async {
    final result = await widget.fetch();
    if (!mounted) return;
    setState(() {
      _future = Future.value(result);
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<T>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Could not load this dashboard: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                ),
              ],
            );
          }

          return widget.builder(context, snapshot.data as T, _refresh);
        },
      ),
    );
  }
}
