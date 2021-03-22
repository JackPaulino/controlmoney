import 'package:controlmoney/app/shared/models/flag_model.dart';

class CardModel {
  int id;
  String name;
  String titular;
  String number;
  String valid;
  int cvc;
  double limite;
  String closure;
  String maturity;
  String cor;
  double saldo;
  String status;
  int flagId;
  FlagModel flag;

  CardModel(
      {this.id,
      this.name,
      this.titular,
      this.number,
      this.valid,
      this.cvc,
      this.limite,
      this.closure,
      this.maturity,
      this.cor,
      this.saldo,
      this.status,
      this.flagId,
      this.flag});

  CardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    titular = json['titular'];
    number = json['number'];
    valid = json['valid'];
    cvc = int.parse(json['cvc']);
    limite = json['limite'];
    closure = json['closure'];
    maturity = json['maturity'];
    cor = json['cor'];
    saldo = json['saldo'];
    status = json['status'];
    flagId = json['flag_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['titular'] = this.titular;
    data['number'] = this.number;
    data['valid'] = this.valid;
    data['cvc'] = this.cvc;
    data['limite'] = this.limite;
    data['closure'] = this.closure;
    data['maturity'] = this.maturity;
    data['cor'] = this.cor;
    data['saldo'] = this.saldo;
    data['status'] = this.status;
    data['flag_id'] = this.flagId;
    /*if (this.flag != null) {
      data['flag'] = this.flag.toJson();
    } */
    return data;
  }
}
