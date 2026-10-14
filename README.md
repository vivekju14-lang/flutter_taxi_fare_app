# flutter_taxi_fare_app

Rajesh Kumar Upadhayay · Student ID 6819110001

Assignment 05: Taxi Fare Calculator. SplashScreenUI opens TaxiFareUI after two seconds.
Distance and waiting time support decimal input. Invalid input shows a message; Cancel clears both fields and the result.

## Run
```sh
flutter pub get
flutter run -d chrome
```

## Course fare table
The app uses the instructor's assignment table, not a claim about current real-world taxi tariffs.
The first kilometre is 35 baht. Distance above it is charged cumulatively:
1–10 km: 6.50/km; 10–20: 7.00/km; 20–40: 8.00/km; 40–60: 8.50/km;
60–80: 9.00/km; above 80: 10.50/km. Waiting adds 3.00 baht per minute.
Fractional kilometres and minutes are prorated; no unspecified meter rounding is applied.
25 km plus 7 minutes = 224.50 baht, calculated from the cumulative fare table.

## Assets and verification
The taxi illustration is an original Flutter CustomPainter vector; no Flaticon artwork is redistributed.
Kanit fonts are bundled locally under their SIL Open Font License.
Tests cover rate boundaries, decimal inputs, validation, calculation, and reset.
`flutter analyze`, `flutter test`, `flutter build web`.
