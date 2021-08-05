import 'decimal_formatter.dart';
import 'formatter.dart';

/// 数量格式化
class AmountFormatter extends Formatter<num> {
  final int float;
  final bool keepTailZero;
  final bool withSymbol;

  final DecimalFormatter _decimalFormater;

  AmountFormatter({
    this.float = 2,
    this.keepTailZero = true,
    this.withSymbol = false,
  }) : _decimalFormater = DecimalFormatter(
          float: float,
          keepTailZero: keepTailZero,
          withSymbol: withSymbol,
        );

  @override
  String format(num? value) {
    if (value != null) {
      final abs = value.abs();
      if (abs < 10000) {
        return _decimalFormater.format(value);
      } else if (abs < 100000000) {
        return _decimalFormater.format(value / 10000) + '万';
      } else if (abs < 1000000000000) {
        return _decimalFormater.format(value / 100000000) + '亿';
      } else {
        return _decimalFormater.format(value / 1000000000000) + '万亿';
      }
    }

    return '--';
  }

  /// 成交额
  factory AmountFormatter.turnover() => AmountFormatter(float: 3);

  /// 成交量
  factory AmountFormatter.volume() => UnitAmountFormatter(unit: '股');
}

/// 带单位的数量格式化
class UnitAmountFormatter extends AmountFormatter {
  final String? unit;

  UnitAmountFormatter({
    this.unit,
    int float = 2,
    bool keepTailZero = false,
    bool withSymbol = false,
  }) : super(
          float: float,
          keepTailZero: keepTailZero,
          withSymbol: withSymbol,
        );

  @override
  String format(num? value) {
    if (unit == null || value == null) {
      return super.format(value);
    } else {
      return super.format(value) + unit!;
    }
  }
}
