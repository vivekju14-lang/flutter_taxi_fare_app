import 'package:flutter/material.dart';
import 'views/splash_screen_ui.dart';

const taxiYellow = Color(0xFFFFC107);
const taxiBackground = Color(0xFFFFF7FF);
void main() => runApp(const TaxiApp());

class TaxiApp extends StatelessWidget {
  const TaxiApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Taxi Fare Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Kanit',
          scaffoldBackgroundColor: taxiBackground,
          colorScheme: ColorScheme.fromSeed(seedColor: taxiYellow)),
      home: const SplashScreenUI());
}
