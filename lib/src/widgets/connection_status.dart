import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/client.dart';

class ConnectionStatus extends ConsumerWidget {
  const ConnectionStatus({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final events = ref.watch(websocketEventProvider);

    return events.when(
      data: (event) {
        if (event.isError) {
          return Text('Connection error: ${event.detail}');
        } else {
          return Text('Connection good: ${event.detail}');
        }
      },
      loading: () => Container(),
      error: (e, st) => Center(child: Text(e.toString())),
    );
  }
}
