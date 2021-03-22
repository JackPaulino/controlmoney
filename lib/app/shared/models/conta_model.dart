class ContaModel {
  int id;
  String name;
  String tipo;
  double saldo;
  String status;

  ContaModel({this.id, this.name, this.tipo, this.saldo, this.status});

  ContaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tipo = json['tipo'];
    saldo = json['saldo'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tipo'] = this.tipo;
    data['saldo'] = this.saldo;
    data['status'] = this.status;
    return data;
  }
}
