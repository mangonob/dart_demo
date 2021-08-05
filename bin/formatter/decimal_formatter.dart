import 'package:intl/intl.dart';

import 'formatter.dart';

class DecimalFormatter extends Formatter<num> {
  /// 小数位数
  final int float;
  final bool keepTailZero;
  final bool withSymbol;

  DecimalFormatter({
    this.float = 2,
    this.keepTailZero = true,
    this.withSymbol = false,
  });

  @override
  String format(num? value) {
    if (value == null) {
      return '--';
    } else {
      late String withOutSymbol;
      if (keepTailZero) {
        withOutSymbol = NumberFormat('0.' + '0' * float).format(value);
      } else {
        withOutSymbol = NumberFormat('0.' + '#' * float).format(value);
      }
      if (withSymbol && value > 0) {
        return '+' + withOutSymbol;
      } else {
        return withOutSymbol;
      }
    }
  }
}
