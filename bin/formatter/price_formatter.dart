import 'decimal_formatter.dart';

/// 价格格式化
class PriceFormatter extends DecimalFormatter {
  PriceFormatter({
    float = 2,
    keepTailZero = true,
    withSymbol = false,
  }) : super(
          float: float,
          keepTailZero: keepTailZero,
          withSymbol: withSymbol,
        );

  factory PriceFormatter.price() => PriceFormatter(float: 3);
}
