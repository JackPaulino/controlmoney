import 'custom_format.dart';

replaceAll(String element) {
  String retur = element.replaceAll('.', '').replaceAll(',', '.');
  return retur;
}

formatMoney(String element) {
  return Appformat.moneyR$.format(double.parse(replaceAll(element)));
}

/* convertReal(element) {
  String retur = element.toString().replaceAll('.', ',');
  return retur;
} */

convertReal(element) {
  String retur = Appformat.quantity.format(element);
  Appformat.quantity.minimumFractionDigits = 2;
  return retur;
}
