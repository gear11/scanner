import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import '../widgets/watch_list.dart';
import '../widgets/counter.dart';
import '../widgets/connection_status.dart';

/// Displays a list of SampleItems.
class WatchListView extends StatelessWidget {
  const WatchListView({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Expanded(flex: 8, child: WatchList()),
                  Expanded(flex: 1, child: Counter()),
                  Expanded(flex: 1, child: ConnectionStatusWidget()),
                ])));
  }
}
