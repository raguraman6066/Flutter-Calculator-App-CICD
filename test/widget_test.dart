import 'package:expense_tracker/features/calculator/presentation/screens/calculator_light.dart';
import 'package:expense_tracker/features/calculator/presentation/screens/calculator_tablet.dart';
import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('uses the tablet screen at 768 and the phone screen below it', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(768, 1024));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const CalculatorApp());
    expect(find.byType(CalculatorTablet), findsOneWidget);

    await tester.binding.setSurfaceSize(const Size(375, 812));
    await tester.pumpWidget(const CalculatorApp());
    expect(find.byType(CalculatorLight), findsOneWidget);
  });

  testWidgets('evaluates the sample division from the design', (tester) async {
    await tester.binding.setSurfaceSize(const Size(375, 812));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const CalculatorApp());

    for (final key in ['6', '2', '9', '1', '÷', '5']) {
      await tester.tap(find.text(key));
      await tester.pump();
    }

    expect(find.text('6,291÷5'), findsOneWidget);
    expect(find.text('1,258.2'), findsOneWidget);
  });
}
