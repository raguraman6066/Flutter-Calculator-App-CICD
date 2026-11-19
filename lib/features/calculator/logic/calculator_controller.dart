import 'package:flutter/foundation.dart';

class CalculatorController extends ChangeNotifier {
  String expression = '';
  String result = '0';

  double? _lhs;
  String? _operator;
  String _rhs = '0';
  bool _editing = false;
  bool _hasRhs = false;

  void press(String key) {
    switch (key) {
      case 'C':
        _clear();
      case '⌫':
        _delete();
      case '±':
        _toggleSign();
      case '%':
        _percent();
      case '=':
        _equals();
      case '+':
      case '−':
      case '×':
      case '÷':
        _setOperator(key);
      case '.':
        _decimal();
      default:
        _digit(key);
    }
    notifyListeners();
  }

  void _digit(String digit) {
    if (!_editing) {
      _rhs = digit;
      _editing = true;
      _hasRhs = true;
    } else if (_rhs == '0') {
      _rhs = digit;
    } else if (_rhs == '-0') {
      _rhs = '-$digit';
    } else {
      _rhs += digit;
    }
    _sync();
  }

  void _decimal() {
    if (!_editing) {
      _rhs = '0.';
      _editing = true;
      _hasRhs = true;
    } else if (!_rhs.contains('.')) {
      _rhs += '.';
    }
    _sync();
  }

  void _setOperator(String operator) {
    final current = _parse(_rhs);
    if (_lhs != null && _operator != null && _editing) {
      final next = _apply(_lhs!, _operator!, current);
      if (next == null) {
        _clear();
        return;
      }
      _lhs = next;
    } else {
      _lhs = current;
    }
    _operator = operator;
    _rhs = _plain(_lhs!);
    _editing = false;
    _hasRhs = false;
    expression = '${formatCalculatorNumber(_lhs!)}$operator';
    result = formatCalculatorNumber(_lhs!);
  }

  void _equals() {
    if (_lhs == null || _operator == null || !_hasRhs) {
      expression = formatCalculatorEntry(_rhs);
      result = formatCalculatorEntry(_rhs);
      _lhs = null;
      _operator = null;
      _editing = false;
      return;
    }
    final value = _apply(_lhs!, _operator!, _parse(_rhs));
    if (value == null) {
      _clear();
      return;
    }
    expression =
        '${formatCalculatorNumber(_lhs!)}$_operator${formatCalculatorEntry(_rhs)}';
    result = formatCalculatorNumber(value);
    _lhs = null;
    _operator = null;
    _rhs = _plain(value);
    _editing = false;
    _hasRhs = false;
  }

  void _percent() {
    _rhs = _plain(_parse(_rhs) / 100);
    _editing = false;
    _hasRhs = true;
    _sync();
  }

  void _toggleSign() {
    if (_rhs.startsWith('-')) {
      _rhs = _rhs.substring(1);
    } else if (_parse(_rhs) != 0) {
      _rhs = '-$_rhs';
    }
    _editing = true;
    _hasRhs = true;
    _sync();
  }

  void _delete() {
    if (!_editing) {
      return;
    }
    if (_rhs.length <= 1 || (_rhs.startsWith('-') && _rhs.length == 2)) {
      _rhs = '0';
    } else {
      _rhs = _rhs.substring(0, _rhs.length - 1);
    }
    _sync();
  }

  void _clear() {
    _lhs = null;
    _operator = null;
    _rhs = '0';
    _editing = false;
    _hasRhs = false;
    expression = '';
    result = '0';
  }

  void _sync() {
    if (_lhs != null && _operator != null && _editing) {
      expression =
          '${formatCalculatorNumber(_lhs!)}$_operator${formatCalculatorEntry(_rhs)}';
      final value = _apply(_lhs!, _operator!, _parse(_rhs));
      result = value == null ? '0' : formatCalculatorNumber(value);
      return;
    }
    if (_lhs != null && _operator != null) {
      expression = '${formatCalculatorNumber(_lhs!)}$_operator';
      result = formatCalculatorNumber(_lhs!);
      return;
    }
    expression = '';
    result = formatCalculatorEntry(_rhs);
  }

  double _parse(String raw) => double.tryParse(raw) ?? 0;

  double? _apply(double left, String operator, double right) {
    switch (operator) {
      case '+':
        return left + right;
      case '−':
        return left - right;
      case '×':
        return left * right;
      case '÷':
        if (right == 0) {
          return null;
        }
        return left / right;
    }
    return null;
  }

  String _plain(double value) {
    if (value.isNaN || value.isInfinite) {
      return '0';
    }
    var text = value.toStringAsFixed(10);
    if (text.contains('.')) {
      text = text
          .replaceFirst(RegExp(r'0+$'), '')
          .replaceFirst(RegExp(r'\.$'), '');
    }
    if (text == '-0') {
      return '0';
    }
    return text;
  }
}

String formatCalculatorNumber(double value) {
  if (value.isNaN || value.isInfinite) {
    return '0';
  }
  var text = value.toStringAsFixed(10);
  if (text.contains('.')) {
    text = text
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }
  if (text == '-0') {
    return '0';
  }
  return formatCalculatorEntry(text);
}

String formatCalculatorEntry(String entry) {
  if (entry.isEmpty || entry == '-') {
    return '0';
  }
  final negative = entry.startsWith('-');
  var body = negative ? entry.substring(1) : entry;
  final trailingDot = body.endsWith('.');
  if (trailingDot) {
    body = body.substring(0, body.length - 1);
  }
  final parts = body.split('.');
  final whole = parts.first.isEmpty ? '0' : parts.first;
  final grouped = StringBuffer();
  for (var i = 0; i < whole.length; i++) {
    if (i > 0 && (whole.length - i) % 3 == 0) {
      grouped.write(',');
    }
    grouped.write(whole[i]);
  }
  if (parts.length > 1 && parts[1].isNotEmpty) {
    grouped.write('.');
    grouped.write(parts[1]);
  } else if (trailingDot) {
    grouped.write('.');
  }
  final formatted = grouped.toString();
  return negative ? '-$formatted' : formatted;
}
