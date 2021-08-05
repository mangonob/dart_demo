import 'formatter/amount_formatter.dart';
import 'formatter/kilo_format.dart';
import 'formatter/percent_format.dart';
import 'formatter/price_formatter.dart';

void main(List<String> arguments) {
  /// 成交额，市值
  final turnover = AmountFormatter.turnover();

  /// 成交量
  final volume = AmountFormatter.volume();

  /// 价格
  final priceFormatter = PriceFormatter();

  /// 百分比
  final percentFormatter = PercentFormatter.percent();

  /// 涨跌幅
  final rateFormatter = PercentFormatter.changeRate();

  final kiloFormatter = KiloFormatter();

  final values = [
    -0.1234123433,
    0.001,
    0.234,
    0.1234124124,
    1,
    9,
    100,
    10000,
    10000000000000,
    12000000000000,
    -100,
  ];

  print('======== Raw value ========');
  values.forEach(print);
  print('======== Turnover ========');
  values.map((e) => turnover.format(e)).forEach((e) => print(e));
  print('======== Volume ========');
  values.map((e) => volume.format(e)).forEach((e) => print(e));
  print('======== Price ========');
  values.map((e) => priceFormatter.format(e)).forEach((e) => print(e));
  print('======== Percentage ========');
  values.map((e) => percentFormatter.format(e)).forEach((e) => print(e));
  print('======== Rate ========');
  values.map((e) => rateFormatter.format(e)).forEach((e) => print(e));
  print('======== KiloFormatter ========');
  values.map((e) => kiloFormatter.format(e)).forEach((e) => print(e));
}
