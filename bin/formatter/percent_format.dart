import 'decimal_formatter.dart';
import 'formatter.dart';

/// 百分比格式化
class PercentFormatter extends Formatter<num> {
  final int float;
  final bool keepTailZero;
  final bool withSymbol;

  final DecimalFormatter _decimalFormatter;

  PercentFormatter({
    this.float = 2,
    this.keepTailZero = true,
    this.withSymbol = false,
  }) : _decimalFormatter = DecimalFormatter(
          float: float,
          keepTailZero: keepTailZero,
          withSymbol: withSymbol,
        );

  /// 百分比
  static final _percent = PercentFormatter();
  factory PercentFormatter.percent() => _percent;

  /// 涨跌幅
  static final _changeRate = PercentFormatter(withSymbol: true);
  factory PercentFormatter.changeRate() => _changeRate;

  @override
  String format(num? value) {
    if (value == null) {
      return '--';
    } else {
      return _decimalFormatter.format(value * 100) + '%';
    }
  }
}
