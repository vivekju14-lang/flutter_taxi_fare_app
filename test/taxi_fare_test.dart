import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_taxi_fare_app/models/taxi_fare.dart';

void main() {
  test('all distance boundaries charge only their progressive bands', () {
    for (final entry in [
      (0.5, 35.0),
      (1.0, 35.0),
      (10.0, 93.5),
      (20.0, 163.5),
      (40.0, 323.5),
      (60.0, 493.5),
      (80.0, 673.5),
      (81.0, 684.0)
    ]) {
      expect(TaxiFare.calculate(distanceKm: entry.$1, waitingMinutes: 0),
          closeTo(entry.$2, 0.00001));
    }
  });
  test('fractional distances and waiting minutes are prorated', () {
    expect(TaxiFare.calculate(distanceKm: 1.5, waitingMinutes: 0.5),
        closeTo(39.75, 0.00001));
    expect(TaxiFare.calculate(distanceKm: 25, waitingMinutes: 7),
        closeTo(224.5, 0.00001));
  });
  test('invalid and non-finite input is rejected', () {
    expect(() => TaxiFare.calculate(distanceKm: 0, waitingMinutes: 0),
        throwsArgumentError);
    expect(() => TaxiFare.calculate(distanceKm: 5, waitingMinutes: -1),
        throwsArgumentError);
    expect(() => TaxiFare.calculate(distanceKm: double.nan, waitingMinutes: 0),
        throwsArgumentError);
    expect(
        () =>
            TaxiFare.calculate(distanceKm: 5, waitingMinutes: double.infinity),
        throwsArgumentError);
  });
}
