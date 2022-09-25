import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scanner/src/providers/connection.dart';
import '../providers/client.dart';

class ConnectionStatusWidget extends ConsumerWidget {
  const ConnectionStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final events = ref.watch(connectionEventProvider);
    final connectionStatus = ref.watch(connectionStatusProvider);

    Text text;
    Color bg = Colors.grey;
    switch (connectionStatus) {
      case ConnectionStatus.up:
        {
          bg = Colors.green;
          text = Text('UP',
              style: TextStyle(color: Colors.white, backgroundColor: bg));
        }
        break;
      case ConnectionStatus.stormy:
        {
          bg = const Color.fromARGB(244, 177, 177, 36);
          text = Text('¯\\_(ツ)_/¯',
              style: TextStyle(color: Colors.white, backgroundColor: bg));
        }
        break;
      case ConnectionStatus.down:
        {
          bg = Colors.red;
          text = Text('DOWN',
              style: TextStyle(color: Colors.white, backgroundColor: bg));
        }
        break;
    }

    return Row(children: [
      Container(
          width: 80,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: bg,
          ),
          child: Center(child: text)),
      Expanded(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: events.when(
                data: (event) {
                  if (event.isError) {
                    return Text(
                      'Connection error: ${event.detail}',
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    );
                  } else {
                    return Text('Connection good: ${event.detail}');
                  }
                },
                loading: () =>
                    const Center(child: Text('Waiting on connection attempt')),
                error: (e, st) => Center(
                    child: Text(
                  e.toString(),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                )),
              )))
    ]);
  }
}
