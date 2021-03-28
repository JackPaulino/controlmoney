import 'package:controlmoney/app/shared/models/card_model.dart';
import 'package:controlmoney/app/shared/models/conta_model.dart';

class DespesaModel {
  int id; //           update pagamento
  String name; //                        required
  double valor; //                       required
  String dataMov; //                     required
  String dataFat; //                              opcional p/ Cartão
  int cartaoId; //                                opcional p/ Cartão
  CardModel card; //                              opcional p/ Cartão
  String dataPag; //   update pagamento
  int contaId; //      update pagamento
  ContaModel conta; // update pagamento
  String pg;

  DespesaModel(
      {this.id,
      this.name,
      this.valor,
      this.dataMov,
      this.dataFat,
      this.cartaoId,
      this.card,
      this.dataPag,
      this.contaId,
      this.conta,
      this.pg});

  DespesaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    valor = json['valor'];
    dataMov = json['data_mov'];
    dataFat = json['data_fat'];
    cartaoId = json['cartao_id'];
    card = json['cartao'] != null ? json['cartao'] : null;
    dataPag = json['data_pag'];
    contaId = json['conta_id'];
    conta = json['conta'] != null ? json['conta'] : null;
    pg = json['pg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['valor'] = this.valor;
    data['data_mov'] = this.dataMov;
    data['data_fat'] = this.dataFat;
    data['cartao_id'] = this.cartaoId;
    if (this.card != null) {
      data['cartao'] = this.card.toJson();
    }
    data['data_pag'] = this.dataPag;
    data['conta_id'] = this.contaId;
    if (this.conta != null) {
      data['conta'] = this.conta.toJson();
    }
    data['pg'] = this.pg;
    return data;
  }
}
