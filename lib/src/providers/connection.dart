import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectionEvent {
  ConnectionEvent(this.detail, {this.isError = false});

  final Object detail;
  final bool isError;
}

class ConnectionNotifier extends StateNotifier<ConnectionStatus> {
  ConnectionNotifier() : super(ConnectionStatus.down);

  final int _lookback = 3;
  final _recentEvents = <ConnectionEvent>[];
  int _pointer = 0;

  ConnectionStatus getStatus() {
    return state;
  }

  ConnectionStatus notify(ConnectionEvent event) {
    if (_recentEvents.length < _lookback) {
      _recentEvents.add(event);
    } else {
      _recentEvents[_pointer] = event;
    }
    _pointer = (_pointer + 1) % _lookback;
    return state = _computeState();
  }

  ConnectionStatus _computeState() {
    final anyErrors = _recentEvents.any((event) => event.isError);
    final allErrors = !_recentEvents.any((event) => !event.isError);
    if (_recentEvents.isEmpty || allErrors) {
      return ConnectionStatus.down;
    } else if (anyErrors) {
      return ConnectionStatus.stormy;
    } else {
      return ConnectionStatus.up;
    }
  }
}

enum ConnectionStatus { up, stormy, down }

class ConnectionWrapper<T> {
  ConnectionWrapper(this._factory);
  final T Function() _factory;
  T? _client;

  T get() {
    return _client ??= _factory();
  }

  void reset() {
    _client = null;
  }
}
