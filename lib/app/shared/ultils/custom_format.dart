import 'package:controlmoney/app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

class TextFormat {
  static var cabecalho = new TextStyle(fontSize: 30, color: Colors.white);
  static var number = new TextStyle(fontSize: 25, color: Colors.white);
  static var dados = new TextStyle(fontSize: 16, color: Colors.white);
  static var dadoblack = new TextStyle(fontSize: 16, color: Colors.black);
  static var textField = new TextStyle(fontSize: 16, color: AppColors.primary);
}

class Appformat {
  static var moneyR$ =
      new NumberFormat.currency(locale: 'pt', decimalDigits: 2, symbol: 'R\$');
  static var money =
      new NumberFormat.compactSimpleCurrency(locale: 'pt', decimalDigits: 2);
  static var quantity = new NumberFormat("###,###.###", "pt-br");
  static var quant = new NumberFormat("#.###", "en_US");
  static var date = new DateFormat('dd/MM/yyyy');
  static var day = new DateFormat.EEEE('pt_BR');
  static var dateHifen = new DateFormat('yyyy-MM-dd');
  static var dayMonth = new DateFormat('dd/MM');
  static var monthYear = new DateFormat('MM/yy');
  static var hourDot = new DateFormat('Hm');
  static var hour = new DateFormat('HH:mm');
  static var hourComp = new DateFormat('HH:mm:ss');
  static var hourHms = new DateFormat("Hms");
}
