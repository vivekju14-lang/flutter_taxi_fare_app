import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_taxi_fare_app/views/splash_screen_ui.dart';
import 'package:flutter_taxi_fare_app/views/taxi_fare_ui.dart';

void main() {
  setUpAll(() async {
    await (FontLoader('Kanit')
          ..addFont(rootBundle.load('assets/fonts/Kanit-Regular.ttf'))
          ..addFont(rootBundle.load('assets/fonts/Kanit-Bold.ttf')))
        .load();
    await (FontLoader('MaterialIcons')
          ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf')))
        .load();
  });
  testWidgets('splash opens calculator and fare/reset/validation work',
      (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final theme = ThemeData(
        fontFamily: 'Kanit',
        scaffoldBackgroundColor: const Color(0xFFFFF7FF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFC107)));
    await tester.pumpWidget(MaterialApp(
        theme: theme,
        home: const RepaintBoundary(
            key: ValueKey('splash'), child: SplashScreenUI())));
    await tester.pump(const Duration(milliseconds: 100));
    await expectLater(find.byKey(const ValueKey('splash')),
        matchesGoldenFile('previews/splash.png'));
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.byType(TaxiFareUI), findsOneWidget);
    await tester.pumpWidget(MaterialApp(
        key: const ValueKey('fresh-calculator-root'),
        theme: theme,
        home: const RepaintBoundary(
            key: ValueKey('calculator'), child: TaxiFareUI())));
    await tester.pumpAndSettle();
    await expectLater(find.byKey(const ValueKey('calculator')),
        matchesGoldenFile('previews/empty.png'));
    await tester.tap(find.text('คำนวณค่าโดยสาร'));
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
    await tester.enterText(find.byType(TextField).at(0), '25');
    await tester.enterText(find.byType(TextField).at(1), '7');
    await tester.tap(find.text('คำนวณค่าโดยสาร'));
    await tester.pumpAndSettle();
    // Wait for the previous validation snackbar to dismiss before capturing.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('224.50'), findsOneWidget);
    await expectLater(find.byKey(const ValueKey('calculator')),
        matchesGoldenFile('previews/calculated.png'));
    await tester.tap(find.text('ยกเลิก'));
    await tester.pumpAndSettle();
    expect(find.text('0.00'), findsOneWidget);
    expect(
        tester.widget<TextField>(find.byType(TextField).at(0)).controller!.text,
        isEmpty);
    expect(tester.takeException(), isNull);
  });
}
