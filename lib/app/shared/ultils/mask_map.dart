import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

Map<String, MaskTextInputFormatter> masks = {
  "number": new MaskTextInputFormatter(
      mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')}),
  "monthyear": new MaskTextInputFormatter(
      mask: '##/##', filter: {"#": RegExp(r'[0-9]')}),
  "money": new MaskTextInputFormatter(
      mask: '###.###,###', filter: {"#": RegExp(r'[0-9]')}),
};
