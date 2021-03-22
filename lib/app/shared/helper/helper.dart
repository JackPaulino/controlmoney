import 'package:controlmoney/app/shared/models/card_model.dart';
import 'package:controlmoney/app/shared/models/conta_model.dart';
import 'package:controlmoney/app/shared/models/flag_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Classe CardModel
final String cardModel = 'cardTABLE';
final String idCard = 'id';
final String nameCard = 'name';
final String titular = 'titular';
final String number = 'number';
final String valid = 'valid';
final String cvc = 'cvc';
final String limite = 'limite';
final String closure = 'closure';
final String maturity = 'maturity';
final String cor = 'cor';
final String saldo = 'saldo';
final String statusCard = 'status';
final String flagId = 'flag_id';

//bandeira
final String flagModel = 'flagTABLE';
final String idflag = 'id';
final String nameFlag = 'name';
final String img = 'img';

// Classe ContaModel
final String contaModel = 'contaTABLE';
final String idConta = 'id';
final String nameConta = 'name';
final String tipo = 'tipo';
final String saldoConta = 'saldo';
final String statusConta = 'status';

class DataBaseHelper {
  static final DataBaseHelper _instance = DataBaseHelper.internal();

  factory DataBaseHelper() => _instance;

  DataBaseHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'controlmoney.db');

    var controlmoney =
        await openDatabase(path, version: 2, onCreate: _createDB);

    return controlmoney;
  }

  void _createDB(Database db, int newerVersion) async {
    await db.execute("CREATE TABLE $flagModel(" +
        "$idflag INTEGER PRIMARY KEY AUTOINCREMENT," +
        "$nameFlag TEXT," +
        "$img TEXT)");

    await db.execute("CREATE TABLE $cardModel(" +
        "$idCard INTEGER PRIMARY KEY AUTOINCREMENT," +
        "$nameCard TEXT," +
        "$titular TEXT," +
        "$number TEXT," +
        "$valid TEXT," +
        "$cvc TEXT," +
        "$limite FLOAT," +
        "$closure TEXT," +
        "$maturity TEXT," +
        "$cor TEXT," +
        "$saldo FLOAT," +
        "$statusCard TEXT," +
        "$flagId, FOREIGN KEY ($flagId) REFERENCES $flagModel ($idflag))");

    await db.execute("CREATE TABLE $contaModel(" +
        "$idConta INTEGER PRIMARY KEY AUTOINCREMENT," +
        "$nameConta TEXT," +
        "$saldoConta FLOAT," +
        "$tipo TEXT," +
        "$statusConta TEXT)");
  }

  //Inserir CardModel
  Future<CardModel> insertCardModel(CardModel card) async {
    Database dbControlMoney = await db;
    card.id = await dbControlMoney.insert(cardModel, card.toJson());
    return card;
  }

  //Inserir ContaModel
  Future<ContaModel> insertContaModel(ContaModel conta) async {
    Database dbControlMoney = await db;
    conta.id = await dbControlMoney.insert(contaModel, conta.toJson());
    return conta;
  }

  //Inserir ContaModel
  Future<FlagModel> insertFlagModel(FlagModel flag) async {
    Database dbControlMoney = await db;
    flag.id = await dbControlMoney.insert(flagModel, flag.toJson());
    return flag;
  }

  //Get Card
  Future<List<CardModel>> getAllCard() async {
    Database dbControlMoney = await db;
    List listMap = await dbControlMoney
        .rawQuery("SELECT * FROM $cardModel ORDER BY $maturity");

    List<CardModel> listCard = [];

    for (Map m in listMap) {
      listCard.add(CardModel.fromJson(m));
    }
    return listCard;
  }

  //Get Conta
  Future<List<ContaModel>> getAllConta() async {
    Database dbControlMoney = await db;
    List listMap = await dbControlMoney.rawQuery("SELECT * FROM $contaModel");

    List<ContaModel> listCard = [];

    for (Map m in listMap) {
      listCard.add(ContaModel.fromJson(m));
    }
    return listCard;
  }

  Future<CardModel> getCard(int id) async {
    Database dbControlMoney = await db;
    List<Map> maps = await dbControlMoney.query(cardModel,
        columns: [
          idCard,
          nameCard,
          number,
          valid,
          cvc,
          limite,
          closure,
          maturity,
          statusCard
        ],
        where: "$idCard =?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return CardModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteCard(CardModel card) async {
    Database dbControlMoney = await db;
    return await dbControlMoney
        .delete(cardModel, where: "$idCard =?", whereArgs: [card.id]);
  }

  Future<int> updateCard(CardModel card) async {
    Database dbControlMoney = await db;
    return await dbControlMoney.update(cardModel, card.toJson(),
        where: "$idCard =?", whereArgs: [card.id]);
  }

  Future<List> getAllCardOrder(String data) async {
    Database dbControlMoney = await db;
    List listMap = await dbControlMoney.rawQuery(
        "SELECT * FROM $cardModel WHERE $closure LIKE '%$data%' ORDER BY dataColumn");
    List<CardModel> listCard = [];

    for (Map m in listMap) {
      listCard.add(CardModel.fromJson(m));
    }
    return listCard;
  }

  Future<int> getNumber() async {
    Database dbControlMoney = await db;
    return Sqflite.firstIntValue(
        await dbControlMoney.rawQuery("SELECT COUNT(*) FROM $cardModel"));
  }

  Future close() async {
    Database dbControlMoney = await db;
    dbControlMoney.close();
  }
}
