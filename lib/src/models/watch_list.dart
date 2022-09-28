import 'package:freezed_annotation/freezed_annotation.dart';

part 'watch_list.freezed.dart';

@freezed
class WatchListItem with _$WatchListItem {
  const factory WatchListItem(
      final String symbol,
      final double open,
      final double high,
      final double low,
      final double close,
      final double wap,
      final int volume) = _WatchListItem;

  factory WatchListItem.fromMap(dynamic item) => WatchListItem(
      item['symbol'],
      item['open'],
      item['high'],
      item['low'],
      item['close'],
      item['wap'],
      item['volume']);

  factory WatchListItem.empty(String symbol) =>
      WatchListItem(symbol, 0, 0, 0, 0, 0, 0);
}

class WatchList {
  WatchList(this.items);
  final List<WatchListItem> items;

  bool has(String symbol) {
    return items.any((item) => (item.symbol == symbol));
  }

  void addEmpty(String symbol) {
    items.add(WatchListItem.empty(symbol));
  }
}

@freezed
class SymbolInfo with _$SymbolInfo {
  const factory SymbolInfo(final String symbol, final String companyName,
      final String? industry, final String? exchage) = _SymbolInfo;

  factory SymbolInfo.fromMap(dynamic item) => SymbolInfo(
      item['symbol'], item['company_name'], item['industry'], item['exchange']);
}
