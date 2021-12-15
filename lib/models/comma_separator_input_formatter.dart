import 'package:flutter/services.dart';
import 'package:number_display/number_display.dart';

class CommaSeparatorInputFormatter extends TextInputFormatter {
  final display = createDisplay();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: display(int.parse(newValue.text)),
    );
  }
}
