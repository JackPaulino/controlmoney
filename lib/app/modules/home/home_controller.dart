import 'package:controlmoney/app/shared/helper/helper.dart';
import 'package:controlmoney/app/shared/models/card_model.dart';
import 'package:controlmoney/app/shared/models/conta_model.dart';
import 'package:controlmoney/app/shared/models/flag_model.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  DataBaseHelper helper = DataBaseHelper();

  @observable
  ObservableList<CardModel> cards = <CardModel>[].asObservable();

  @observable
  ObservableList<ContaModel> contas = <ContaModel>[].asObservable();

  @observable
  ObservableList<FlagModel> flags = <FlagModel>[].asObservable();

  //Lista oc Cartões
  Future<void> getAllCard() async {
    Database dbControlMoney = await helper.db;

    cards = <CardModel>[].asObservable();

    List listMap = await dbControlMoney
        .rawQuery("SELECT * FROM $cardModel ORDER BY $maturity");

    for (var m in listMap) {
      CardModel card = CardModel.fromJson(m);
      card.flag = flags.firstWhere((e) => e.id == card.flagId);
      print(card.toJson());
      cards.add(card);
    }
  }

  //Get Conta
  Future<void> getAllConta() async {
    Database dbControlMoney = await helper.db;

    contas = <ContaModel>[].asObservable();

    List listMap = await dbControlMoney
        .rawQuery("SELECT * FROM $contaModel ORDER BY  $nameConta");

    for (Map m in listMap) {
      contas.add(ContaModel.fromJson(m));
    }
  }

  //Get Conta
  Future<void> getAllFlag() async {
    Database dbControlMoney = await helper.db;

    List listMap = await dbControlMoney
        .rawQuery("SELECT * FROM $flagModel ORDER BY  $nameFlag");

    for (Map m in listMap) {
      print(m);
      flags.add(FlagModel.fromJson(m));
    }
  }
}

/* helper.getAllCard().then((lista) {
      lista.forEach((element) {
        print(element.toJson());
      });
    });

    var card1 = CardModel(
        name: 'CredCard',
        number: '2535263559685624',
        valid: '12-2021',
        cvc: 564,
        limite: 3600.00,
        closure: '26',
        maturity: '10',
        status: 'A');
    helper.insertCardModel(card1);

    var card2 = CardModel(
        name: 'Nubank',
        number: '5869659852345625',
        valid: '12-2021',
        cvc: 564,
        limite: 2700.00,
        closure: '26',
        maturity: '10',
        status: 'A');
    helper.insertCardModel(card2); */
