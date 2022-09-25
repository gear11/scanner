import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scanner/src/models/watch_list.dart';
import '../providers/connection.dart';
import '../providers/watch_list.dart';
import '../providers/client.dart';
import 'util.dart';
import '../providers/logging.dart';

final log = logger(WatchList);

class WatchList extends ConsumerWidget {
  const WatchList({Key? key}) : super(key: key);

  void onRemove(WidgetRef ref, String symbol) async {
    ref.read(watchListServiceProvider).remove(symbol);
  }

  @override
  Widget build(context, ref) {
    final watchlist = ref.watch(watchListUpdateProvider);
    final connectionStatus = ref.watch(connectionStatusProvider);
    //final connectionOkay = ref.watch(connectionOkayProvider);
    log.info('Rebuilding watchlist with connected state $connectionStatus');
    return Freezable(
        frozen: connectionStatus == ConnectionStatus.down,
        child: watchlist.when(
          data: (watchlist) {
            return ListView.builder(
                itemCount: watchlist.items.length,
                itemBuilder: (context, index) {
                  final WatchListItem item = watchlist.items[index];
                  return ListTile(
                    leading: ColoredCircleAvatar(item.symbol),
                    title: Text(item.symbol),
                    subtitle: Text(item.wap.toString()),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove),
                      tooltip: 'Remove ${item.symbol}',
                      onPressed: () => onRemove(ref, item.symbol),
                    ),
                  );
                });
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) {
            return const Center(child: Text("--"));
          },
        ));
  }
}
