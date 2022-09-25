class WatchListItem {
  final String symbol;
  final double open;
  final double high;
  final double low;
  final double close;
  final double wap;
  final int volume;

  const WatchListItem(this.symbol, this.open, this.high, this.low, this.close,
      this.wap, this.volume);

  static WatchListItem fromMap(dynamic item) {
    return WatchListItem(item['symbol'], item['open'], item['high'],
        item['low'], item['close'], item['wap'], item['volume']);
  }
}

class WatchList {
  WatchList(this.items);
  final List<WatchListItem> items;
}
