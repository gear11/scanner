import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/client.dart';

class ConnectionStatusWidget extends ConsumerWidget {
  const ConnectionStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final events = ref.watch(connectionEventProvider);
    final connectionOkay = ref.watch(connectionOkayProvider);

    final text = connectionOkay
        ? const Text('Healthy',
            style:
                TextStyle(color: Colors.white, backgroundColor: Colors.green))
        : const Text('UNHEALTHY',
            style: TextStyle(color: Colors.white, backgroundColor: Colors.red));

    return Row(children: [
      text,
      events.when(
        data: (event) {
          if (event.isError) {
            return Text('Connection error: ${event.detail}');
          } else {
            return Text('Connection good: ${event.detail}');
          }
        },
        loading: () =>
            const Center(child: Text('Waiting on connection attempt')),
        error: (e, st) => Center(child: Text(e.toString())),
      )
    ]);
  }
}
