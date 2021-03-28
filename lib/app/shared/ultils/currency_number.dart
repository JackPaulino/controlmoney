import 'package:flutter/services.dart';

import 'custom_format.dart';

class CurrencyNumber extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    Appformat.quantity.minimumFractionDigits = 2;

    String newText = Appformat.quantity.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
