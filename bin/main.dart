import 'dart:io';

import 'package:hive/hive.dart';

import 'cacher/cacher.dart';

void main(List<String> arguments) async {
  Hive.init('.');

  final cacher = await Cacher.getInstance('some');
  for (final i in List.generate(10000, (i) => i)) {
    await cacher.write(i, 'value-$i');
  }
  print(cacher.read(99));
  print(cacher.read(9999));
  cacher.dispose();
}

int foo(dynamic message) {
  sleep(Duration(seconds: 4));
  print(message);
  return 42;
}

class Stock extends HiveObject {
  final int? value;

  Stock({this.value});

  @override
  String toString() {
    return 'Stock: $value';
  }
}

class StockAdapter extends TypeAdapter<Stock> {
  @override
  int get typeId => 0;

  @override
  Stock read(BinaryReader reader) => Stock(
        value: reader.read(),
      );

  @override
  void write(BinaryWriter writer, Stock obj) => writer..write(obj.value);
}
