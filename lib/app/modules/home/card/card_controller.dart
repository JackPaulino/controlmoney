import 'package:controlmoney/app/shared/helper/helper.dart';
import 'package:controlmoney/app/shared/models/card_model.dart';
import 'package:controlmoney/app/shared/models/flag_model.dart';
import 'package:controlmoney/app/shared/ultils/custom_method.dart';
import 'package:controlmoney/app/shared/ultils/mask_map.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';

part 'card_controller.g.dart';

@Injectable()
class CardController = _CardControllerBase with _$CardController;

abstract class _CardControllerBase with Store {
  @observable
  bool loading = false;

  @observable
  String dtaValid = '';

  @observable
  bool status = true;

  @observable
  bool edite = false;

  @observable
  int idCard = 0;

  @observable
  FlagModel flagSelect =
      FlagModel(id: 1, name: 'CrediShop', img: 'assets/images/credishop.png');

  @observable
  String descFlag = 'CrediShop';

  @observable
  DataBaseHelper helper = DataBaseHelper();

  @observable
  TextEditingController nameController = new TextEditingController();
  @observable
  TextEditingController titularController = new TextEditingController();
  @observable
  TextEditingController numberController = new TextEditingController();
  @observable
  TextEditingController validController = new TextEditingController();
  @observable
  TextEditingController cvcController = new TextEditingController();
  @observable
  TextEditingController limiteController = new TextEditingController(text: '0');
  @observable
  TextEditingController closureController = new TextEditingController();
  @observable
  TextEditingController maturityController = new TextEditingController();
  @observable
  TextEditingController saldoController = new TextEditingController(text: '0');
  @observable
  TextEditingController corController =
      new TextEditingController(text: '1f0182');

  @observable
  GlobalKey<FormState> cardForm = GlobalKey<FormState>();

  Map<bool, String> statusMap = {true: 'Ativo', false: 'Inativo'};

  Map<bool, String> statusBool = {true: 'A', false: 'I'};

  Map<String, bool> statusStr = {'A': true, 'I': false};

  @action
  void preencheCard(CardModel card) {
    idCard = card.id;
    nameController.text = card.name;
    numberController.text = masks['number'].maskText(card.number);
    titularController.text = card.titular;
    validController.text = card.valid;
    cvcController.text = card.cvc.toString();
    closureController.text = card.closure;
    maturityController.text = card.maturity;
    limiteController.text = convertReal(card.limite);
    corController.text = card.cor;
    saldoController.text = convertReal(card.saldo);
    status = statusStr[card.status];
    // ignore: unnecessary_statements
    flagSelect = card.flag;
    descFlag = flagSelect.name;
  }

  //Inserir CardModel
  Future<CardModel> insertCardModel() async {
    var card = CardModel(
        name: nameController.text,
        number: masks['number'].unmaskText(numberController.text),
        titular: titularController.text,
        valid: validController.text,
        cvc: int.parse(cvcController.text),
        closure: closureController.text,
        maturity: maturityController.text,
        limite: double.parse(replaceAll(limiteController.text)),
        saldo: double.parse(replaceAll(saldoController.text)),
        cor: corController.text,
        status: statusBool[status],
        flagId: flagSelect.id);

    Database dbControlMoney = await helper.db;
    card.id = await dbControlMoney.insert(cardModel, card.toJson());
    return card;
  }

  Future<int> updateCard() async {
    var card = {
      'name': nameController.text,
      'number': masks['number'].unmaskText(numberController.text),
      'titular': titularController.text,
      'valid': validController.text,
      'cvc': int.parse(cvcController.text),
      'closure': closureController.text,
      'maturity': maturityController.text,
      'limite': replaceAll(limiteController.text),
      'cor': corController.text,
      'saldo': replaceAll(saldoController.text),
      'status': statusBool[status],
      'flag_id': flagSelect.id
    };
    print(card);
    Database dbControlMoney = await helper.db;
    return await dbControlMoney
        .update(cardModel, card, where: "id =?", whereArgs: [idCard]);
  }
}
