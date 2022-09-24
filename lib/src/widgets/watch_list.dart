import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scanner/src/models/watch_list.dart';
import '../providers/watch_list.dart';
import '../providers/client.dart';
import 'freezable.dart';
import '../providers/logging.dart';

final log = logger(WatchList);

class WatchList extends ConsumerWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final watchlist = ref.watch(watchListProvider);
    final connectionOkay = ref.watch(connectionOkayProvider);
    //final connectionOkay = ref.watch(connectionOkayProvider);
    log.info('Rebuilding watchlist with connected state $connectionOkay');
    return Freezable(
        frozen: !connectionOkay,
        child: watchlist.when(
          data: (items) {
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final WatchListItem item = items[index];
                  return ListTile(
                      leading: Text(item.symbol),
                      title: Text(item.wap.toString()));
                });
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) {
            return const Center(child: Text("--"));
          },
        ));
  }
}
