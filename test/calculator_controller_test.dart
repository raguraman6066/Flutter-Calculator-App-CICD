import 'package:expense_tracker/features/calculator/logic/calculator_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('6291 divided by 5 matches the design sample', () {
    final calculator = CalculatorController();
    for (final key in ['6', '2', '9', '1', '÷', '5', '=']) {
      calculator.press(key);
    }
    expect(calculator.expression, '6,291÷5');
    expect(calculator.result, '1,258.2');
  });

  test('clear resets the display', () {
    final calculator = CalculatorController();
    calculator.press('8');
    calculator.press('C');
    expect(calculator.expression, isEmpty);
    expect(calculator.result, '0');
  });
}
