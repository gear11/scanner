import 'package:logging/logging.dart';

bool _isLoggingInit = false;

const currentFile = StackTrace;

void initLogging() {
  if (!_isLoggingInit) {
    hierarchicalLoggingEnabled = true;
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    // ignore: avoid_print
    Logger.root.onRecord.listen((record) => print(format(record)));
    _isLoggingInit = true;
    Logger('null').level = Level.OFF;
  }
}

String format(LogRecord record) {
  final Map<Level, ControlChar> map = {
    Level.FINE: ControlChar.blue,
    Level.INFO: ControlChar.cyan,
    Level.WARNING: ControlChar.yellow,
    Level.SEVERE: ControlChar.red,
    Level.SHOUT: ControlChar.red,
  };
  final cc = map[record.level] ?? ControlChar.none;
  return cc.wrap(message(record));
}

String message(LogRecord record) {
  final level = record.level == Level.WARNING ? 'WARN' : record.level.name;
  return '$level: ${record.time}: [${record.loggerName}] ${record.message}';
}

enum ControlChar {
  red(ch: '\x1B[31m'),
  yellow(ch: '\x1B[33m'),
  white(ch: '\x1B[33m'),
  blue(ch: '\x1B[34m'),
  cyan(ch: '\x1B[36m'),
  none(ch: ''),
  reset(ch: '\x1B[0m');

  const ControlChar({required this.ch});
  final String ch;

  String wrap(String s) {
    if (this == ControlChar.none) {
      return s;
    }
    return '$ch$s${ControlChar.reset.ch}';
  }
}

Logger logger(dynamic context) {
  if (!_isLoggingInit) {
    initLogging();
  }
  String name;
  if (context == StackTrace) {
    name = getCaller(StackTrace.current);
  } else {
    name = context.toString();
  }
  return Logger(name);
}

String getCaller(StackTrace current) {
  RegExp exp = RegExp(r'package:([^:]+)');
  RegExpMatch? match = exp.allMatches(current.toString()).elementAt(1);
  final paths = match[1]!.split('/');
  return paths.getRange(paths.length - 2, paths.length).join('/');
}

Logger nullLogger(dynamic context) {
  // Ignore the context and provide our disabled logger
  return Logger('null');
}

extension NoopLogger on Logger {
  Logger noop() {
    return Logger('null');
  }
}
