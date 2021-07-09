void main(List<String> arguments) {
  var bike = Bicycle(2, 1);

  bike
    ..speedUp(30)
    ..applyBreak(10)
    ..applyBreak(20);

  print(bike);
}

class Bicycle {
  int cadence;
  int _speed = 0;
  int get speed => _speed;
  int gear;

  Bicycle(this.cadence, this.gear);

  void applyBreak(int decrement) => _speed -= decrement;

  void speedUp(int increment) => _speed += increment;

  @override
  String toString() => 'Bicycle: $speed mph';
}
