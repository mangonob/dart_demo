import 'decimal_formatter.dart';
import 'formatter.dart';

/// 千位缩写格式化
class KiloFormatter extends Formatter<num> {
  final int float;
  final bool keepTailZero;
  final bool withSymbol;
  final DecimalFormatter _decimalFormatter;

  KiloFormatter({
    this.float = 2,
    this.keepTailZero = false,
    this.withSymbol = false,
  }) : _decimalFormatter = DecimalFormatter(
          float: float,
          keepTailZero: keepTailZero,
          withSymbol: withSymbol,
        );

  @override
  String format(num? value) {
    if (value == null) {
      return '--';
    } else {
      final abs = value.abs();
      if (abs < 1000) {
        return _decimalFormatter.format(value);
      } else if (abs < 10000000) {
        return _decimalFormatter.format(value / 1000) + 'K';
      } else {
        return _decimalFormatter.format(value / 1000000) + 'M';
      }
    }
  }
}
