import 'package:controlmoney/app/shared/helper/helper.dart';
import 'package:controlmoney/app/shared/models/conta_model.dart';
import 'package:controlmoney/app/shared/ultils/custom_method.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';

part 'conta_controller.g.dart';

@Injectable()
class ContaController = _ContaControllerBase with _$ContaController;

abstract class _ContaControllerBase with Store {
  @observable
  DataBaseHelper helper = DataBaseHelper();

  @observable
  bool edite = false;

  @observable
  bool loading = false;

  @observable
  int idConta = 0;

  @observable
  String tipo = 'C';

  @observable
  String descTipo = 'Conta Corrente';

  @observable
  Map<String, String> tiposigla = {
    'C': 'Conta Corrente',
    'R': 'Conta com Rendimento',
    'I': 'Conta de Investimento'
  };

  @observable
  Map<String, String> tipodesc = {
    'Conta Corrente': 'C',
    'Conta com Rendimento': 'R',
    'Conta de Investimento': 'I'
  };

  List<String> listConta = [];

  @observable
  bool status = true;

  @observable
  Map<String, bool> statusbool = {'A': true, 'I': false};

  @observable
  Map<bool, String> statusstr = {true: 'A', false: 'I'};

  @observable
  Map<bool, String> statusdesc = {true: 'Ativo', false: 'Inativo'};

  @observable
  TextEditingController nameController = new TextEditingController();
  @observable
  TextEditingController tipoController = new TextEditingController();
  @observable
  TextEditingController saldoController = new TextEditingController();

  @observable
  GlobalKey<FormState> contaForm = GlobalKey<FormState>();

  @action
  void preencheCard(ContaModel conta) {
    print(conta.toJson());
    idConta = conta.id;
    nameController.text = conta.name;
    saldoController.text = convertReal(conta.saldo);
    tipo = conta.tipo;
    status = statusbool[conta.status];
    descTipo = tiposigla[conta.tipo];
  }

  Future<void> listTipoConta() async {
    listConta.add(tiposigla['C']);
    listConta.add(tiposigla['R']);
    listConta.add(tiposigla['I']);
  }

  //Inserir CardModel
  Future<ContaModel> insertConta() async {
    var conta = ContaModel(
        name: nameController.text,
        saldo: double.parse(replaceAll(saldoController.text)),
        tipo: tipo,
        status: statusstr[status]);

    Database dbControlMoney = await helper.db;
    conta.id = await dbControlMoney.insert(contaModel, conta.toJson());
    return conta;
  }

  Future<int> updateConta() async {
    var conta = {
      'name': nameController.text,
      'saldo': replaceAll(saldoController.text),
      'tipo': tipo,
      'status': statusstr[status]
    };

    Database dbControlMoney = await helper.db;
    return await dbControlMoney
        .update(contaModel, conta, where: "id =?", whereArgs: [idConta]);
  }
}
