import 'package:flutter/material.dart';
import '../models/taxi_fare.dart';
import '../widgets/taxi_illustration.dart';

class TaxiFareUI extends StatefulWidget {
  const TaxiFareUI({super.key});
  @override
  State<TaxiFareUI> createState() => _TaxiFareUIState();
}

class _TaxiFareUIState extends State<TaxiFareUI> {
  final distance = TextEditingController(), minutes = TextEditingController();
  double? fare;
  @override
  void dispose() {
    distance.dispose();
    minutes.dispose();
    super.dispose();
  }

  void calculate() {
    final km = double.tryParse(distance.text.trim()),
        time = double.tryParse(minutes.text.trim());
    if (km == null ||
        time == null ||
        !km.isFinite ||
        !time.isFinite ||
        km <= 0 ||
        time < 0) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Row(children: [
            Icon(Icons.warning_amber, color: Colors.amber),
            SizedBox(width: 10),
            Expanded(
                child: Text(
                    'กรุณากรอกระยะทางมากกว่า 0 และเวลารถติดตั้งแต่ 0 นาที'))
          ])));
      return;
    }
    try {
      final value = TaxiFare.calculate(distanceKm: km, waitingMinutes: time);
      FocusScope.of(context).unfocus();
      setState(() => fare = value);
    } on ArgumentError {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('ข้อมูลเกินช่วงที่รองรับ กรุณาตรวจสอบข้อมูล')));
    }
  }

  Widget input(String label, String hint, TextEditingController controller) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 6),
          Icon(label.startsWith('ระยะทาง') ? Icons.route : Icons.timer_outlined,
              size: 17,
              color: label.startsWith('ระยะทาง') ? Colors.green : Colors.red),
        ]),
        const SizedBox(height: 8),
        TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                border:
                    const OutlineInputBorder(borderRadius: BorderRadius.zero),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14))),
        const SizedBox(height: 20)
      ]);
  Widget button(String label, VoidCallback action, Color color) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9))),
              onPressed: action,
              child: Text(label, style: const TextStyle(fontSize: 18)))));
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          title: const Text('Taxi Fare',
              style: TextStyle(color: Colors.white, fontSize: 22)),
          centerTitle: true,
          backgroundColor: const Color(0xFFFFC107)),
      body: SafeArea(
          child: Center(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(36, 28, 36, 24),
                          child: Column(children: [
                            const TaxiIllustration(size: 230),
                            const SizedBox(height: 20),
                            const Text('คำนวณค่าโดยสารแท็กซี่',
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 24),
                            input('ระยะทาง (กิโลเมตร)', 'กรุณากรอกระยะทาง',
                                distance),
                            input('เวลารถติด (นาที)', 'กรุณากรอกเวลารถติด',
                                minutes),
                            button('คำนวณค่าโดยสาร', calculate,
                                const Color(0xFFFFC107)),
                            button('ยกเลิก', () {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              distance.clear();
                              minutes.clear();
                              FocusScope.of(context).unfocus();
                              setState(() => fare = null);
                            }, Colors.grey),
                            Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFFFEDB0),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(children: [
                                  const Text('ค่าโดยสารแท็กซี่',
                                      style: TextStyle(fontSize: 18)),
                                  Text((fare ?? 0).toStringAsFixed(2),
                                      style: const TextStyle(
                                          fontSize: 36,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold)),
                                  const Text('บาท',
                                      style: TextStyle(fontSize: 18))
                                ])),
                          ])))))));
}
