class TaxiFare {
  static double calculate(
      {required double distanceKm, required double waitingMinutes}) {
    if (!distanceKm.isFinite || distanceKm <= 0) {
      throw ArgumentError.value(
          distanceKm, 'distanceKm', 'Distance must be positive');
    }
    if (!waitingMinutes.isFinite || waitingMinutes < 0) {
      throw ArgumentError.value(waitingMinutes, 'waitingMinutes',
          'Waiting time must be non-negative');
    }
    var fare = 35.0;
    var previous = 1.0;
    for (final tier in [
      (10.0, 6.5),
      (20.0, 7.0),
      (40.0, 8.0),
      (60.0, 8.5),
      (80.0, 9.0),
      (double.infinity, 10.5)
    ]) {
      if (distanceKm <= previous) break;
      final end = distanceKm < tier.$1 ? distanceKm : tier.$1;
      fare += (end - previous) * tier.$2;
      previous = end;
    }
    final result = fare + waitingMinutes * 3.0;
    if (!result.isFinite) throw ArgumentError('Values exceed supported range');
    return result;
  }
}
