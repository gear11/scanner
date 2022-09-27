// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'watch_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WatchListItem {
  String get symbol => throw _privateConstructorUsedError;
  double get open => throw _privateConstructorUsedError;
  double get high => throw _privateConstructorUsedError;
  double get low => throw _privateConstructorUsedError;
  double get close => throw _privateConstructorUsedError;
  double get wap => throw _privateConstructorUsedError;
  int get volume => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WatchListItemCopyWith<WatchListItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WatchListItemCopyWith<$Res> {
  factory $WatchListItemCopyWith(
          WatchListItem value, $Res Function(WatchListItem) then) =
      _$WatchListItemCopyWithImpl<$Res>;
  $Res call(
      {String symbol,
      double open,
      double high,
      double low,
      double close,
      double wap,
      int volume});
}

/// @nodoc
class _$WatchListItemCopyWithImpl<$Res>
    implements $WatchListItemCopyWith<$Res> {
  _$WatchListItemCopyWithImpl(this._value, this._then);

  final WatchListItem _value;
  // ignore: unused_field
  final $Res Function(WatchListItem) _then;

  @override
  $Res call({
    Object? symbol = freezed,
    Object? open = freezed,
    Object? high = freezed,
    Object? low = freezed,
    Object? close = freezed,
    Object? wap = freezed,
    Object? volume = freezed,
  }) {
    return _then(_value.copyWith(
      symbol: symbol == freezed
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      open: open == freezed
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as double,
      high: high == freezed
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as double,
      low: low == freezed
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as double,
      close: close == freezed
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as double,
      wap: wap == freezed
          ? _value.wap
          : wap // ignore: cast_nullable_to_non_nullable
              as double,
      volume: volume == freezed
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_WatchListItemCopyWith<$Res>
    implements $WatchListItemCopyWith<$Res> {
  factory _$$_WatchListItemCopyWith(
          _$_WatchListItem value, $Res Function(_$_WatchListItem) then) =
      __$$_WatchListItemCopyWithImpl<$Res>;
  @override
  $Res call(
      {String symbol,
      double open,
      double high,
      double low,
      double close,
      double wap,
      int volume});
}

/// @nodoc
class __$$_WatchListItemCopyWithImpl<$Res>
    extends _$WatchListItemCopyWithImpl<$Res>
    implements _$$_WatchListItemCopyWith<$Res> {
  __$$_WatchListItemCopyWithImpl(
      _$_WatchListItem _value, $Res Function(_$_WatchListItem) _then)
      : super(_value, (v) => _then(v as _$_WatchListItem));

  @override
  _$_WatchListItem get _value => super._value as _$_WatchListItem;

  @override
  $Res call({
    Object? symbol = freezed,
    Object? open = freezed,
    Object? high = freezed,
    Object? low = freezed,
    Object? close = freezed,
    Object? wap = freezed,
    Object? volume = freezed,
  }) {
    return _then(_$_WatchListItem(
      symbol == freezed
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      open == freezed
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as double,
      high == freezed
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as double,
      low == freezed
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as double,
      close == freezed
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as double,
      wap == freezed
          ? _value.wap
          : wap // ignore: cast_nullable_to_non_nullable
              as double,
      volume == freezed
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_WatchListItem implements _WatchListItem {
  const _$_WatchListItem(this.symbol, this.open, this.high, this.low,
      this.close, this.wap, this.volume);

  @override
  final String symbol;
  @override
  final double open;
  @override
  final double high;
  @override
  final double low;
  @override
  final double close;
  @override
  final double wap;
  @override
  final int volume;

  @override
  String toString() {
    return 'WatchListItem(symbol: $symbol, open: $open, high: $high, low: $low, close: $close, wap: $wap, volume: $volume)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WatchListItem &&
            const DeepCollectionEquality().equals(other.symbol, symbol) &&
            const DeepCollectionEquality().equals(other.open, open) &&
            const DeepCollectionEquality().equals(other.high, high) &&
            const DeepCollectionEquality().equals(other.low, low) &&
            const DeepCollectionEquality().equals(other.close, close) &&
            const DeepCollectionEquality().equals(other.wap, wap) &&
            const DeepCollectionEquality().equals(other.volume, volume));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(symbol),
      const DeepCollectionEquality().hash(open),
      const DeepCollectionEquality().hash(high),
      const DeepCollectionEquality().hash(low),
      const DeepCollectionEquality().hash(close),
      const DeepCollectionEquality().hash(wap),
      const DeepCollectionEquality().hash(volume));

  @JsonKey(ignore: true)
  @override
  _$$_WatchListItemCopyWith<_$_WatchListItem> get copyWith =>
      __$$_WatchListItemCopyWithImpl<_$_WatchListItem>(this, _$identity);
}

abstract class _WatchListItem implements WatchListItem {
  const factory _WatchListItem(
      final String symbol,
      final double open,
      final double high,
      final double low,
      final double close,
      final double wap,
      final int volume) = _$_WatchListItem;

  @override
  String get symbol;
  @override
  double get open;
  @override
  double get high;
  @override
  double get low;
  @override
  double get close;
  @override
  double get wap;
  @override
  int get volume;
  @override
  @JsonKey(ignore: true)
  _$$_WatchListItemCopyWith<_$_WatchListItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SymbolInfo {
  String get symbol => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;
  String? get industry => throw _privateConstructorUsedError;
  String? get exchage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SymbolInfoCopyWith<SymbolInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SymbolInfoCopyWith<$Res> {
  factory $SymbolInfoCopyWith(
          SymbolInfo value, $Res Function(SymbolInfo) then) =
      _$SymbolInfoCopyWithImpl<$Res>;
  $Res call(
      {String symbol, String companyName, String? industry, String? exchage});
}

/// @nodoc
class _$SymbolInfoCopyWithImpl<$Res> implements $SymbolInfoCopyWith<$Res> {
  _$SymbolInfoCopyWithImpl(this._value, this._then);

  final SymbolInfo _value;
  // ignore: unused_field
  final $Res Function(SymbolInfo) _then;

  @override
  $Res call({
    Object? symbol = freezed,
    Object? companyName = freezed,
    Object? industry = freezed,
    Object? exchage = freezed,
  }) {
    return _then(_value.copyWith(
      symbol: symbol == freezed
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: companyName == freezed
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      industry: industry == freezed
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String?,
      exchage: exchage == freezed
          ? _value.exchage
          : exchage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_SymbolInfoCopyWith<$Res>
    implements $SymbolInfoCopyWith<$Res> {
  factory _$$_SymbolInfoCopyWith(
          _$_SymbolInfo value, $Res Function(_$_SymbolInfo) then) =
      __$$_SymbolInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String symbol, String companyName, String? industry, String? exchage});
}

/// @nodoc
class __$$_SymbolInfoCopyWithImpl<$Res> extends _$SymbolInfoCopyWithImpl<$Res>
    implements _$$_SymbolInfoCopyWith<$Res> {
  __$$_SymbolInfoCopyWithImpl(
      _$_SymbolInfo _value, $Res Function(_$_SymbolInfo) _then)
      : super(_value, (v) => _then(v as _$_SymbolInfo));

  @override
  _$_SymbolInfo get _value => super._value as _$_SymbolInfo;

  @override
  $Res call({
    Object? symbol = freezed,
    Object? companyName = freezed,
    Object? industry = freezed,
    Object? exchage = freezed,
  }) {
    return _then(_$_SymbolInfo(
      symbol == freezed
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      companyName == freezed
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      industry == freezed
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String?,
      exchage == freezed
          ? _value.exchage
          : exchage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_SymbolInfo implements _SymbolInfo {
  const _$_SymbolInfo(
      this.symbol, this.companyName, this.industry, this.exchage);

  @override
  final String symbol;
  @override
  final String companyName;
  @override
  final String? industry;
  @override
  final String? exchage;

  @override
  String toString() {
    return 'SymbolInfo(symbol: $symbol, companyName: $companyName, industry: $industry, exchage: $exchage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SymbolInfo &&
            const DeepCollectionEquality().equals(other.symbol, symbol) &&
            const DeepCollectionEquality()
                .equals(other.companyName, companyName) &&
            const DeepCollectionEquality().equals(other.industry, industry) &&
            const DeepCollectionEquality().equals(other.exchage, exchage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(symbol),
      const DeepCollectionEquality().hash(companyName),
      const DeepCollectionEquality().hash(industry),
      const DeepCollectionEquality().hash(exchage));

  @JsonKey(ignore: true)
  @override
  _$$_SymbolInfoCopyWith<_$_SymbolInfo> get copyWith =>
      __$$_SymbolInfoCopyWithImpl<_$_SymbolInfo>(this, _$identity);
}

abstract class _SymbolInfo implements SymbolInfo {
  const factory _SymbolInfo(final String symbol, final String companyName,
      final String? industry, final String? exchage) = _$_SymbolInfo;

  @override
  String get symbol;
  @override
  String get companyName;
  @override
  String? get industry;
  @override
  String? get exchage;
  @override
  @JsonKey(ignore: true)
  _$$_SymbolInfoCopyWith<_$_SymbolInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
