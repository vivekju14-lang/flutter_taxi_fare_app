import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/taxi_illustration.dart';
import 'taxi_fare_ui.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});
  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute<void>(builder: (_) => const TaxiFareUI()));
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
        const TaxiIllustration(size: 220),
        const SizedBox(height: 26),
        const Text('Taxi Fare Calculator',
            style: TextStyle(fontSize: 25, color: Colors.lightBlue)),
        const SizedBox(height: 8),
        const Text('คำนวณค่าโดยสารแท็กซี่',
            style: TextStyle(fontSize: 17, color: Colors.lightBlue)),
        const SizedBox(height: 35),
        const CircularProgressIndicator(
            color: Color(0xFFFFC107), strokeWidth: 3)
      ])));
}
