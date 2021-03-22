import 'package:controlmoney/app/shared/models/card_model.dart';
import 'package:controlmoney/app/shared/models/conta_model.dart';
import 'package:controlmoney/app/shared/theme/app_colors.dart';
import 'package:controlmoney/app/shared/widget/custom_app_bar.dart';
import 'package:controlmoney/app/shared/widget/custom_card.dart';
import 'package:controlmoney/app/shared/widget/custom_conta.dart';
import 'package:controlmoney/app/shared/widget/separator_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    /* var flag =
        FlagModel(id: 1, name: 'CrediShop', img: 'assets/images/credishop.png');
    controller.helper.insertFlagModel(flag);

    var flag2 =
        FlagModel(id: 2, name: 'HiperCard', img: 'assets/images/hipercard.png');
    controller.helper.insertFlagModel(flag2);

    var flag3 =
        FlagModel(id: 3, name: 'Maestro', img: 'assets/images/maestro.png');
    controller.helper.insertFlagModel(flag3);

    var flag4 = FlagModel(
        id: 4, name: 'MasterCard', img: 'assets/images/mastercard.png');
    controller.helper.insertFlagModel(flag4);

    var flag5 = FlagModel(id: 5, name: 'Visa', img: 'assets/images/visa.png');
    controller.helper.insertFlagModel(flag5);

    var flag6 = FlagModel(
        id: 6, name: 'Visa Electron', img: 'assets/images/visaelectron.png');
    controller.helper.insertFlagModel(flag6);

    var card1 = CardModel(
        name: 'Nubank',
        titular: 'Jakson Henrique de Almeida Paulino',
        number: '5162926165942698',
        valid: '01/29',
        cvc: 825,
        limite: 2700.00,
        closure: '03',
        maturity: '10',
        cor: '612F74',
        saldo: 1458.80,
        status: 'A',
        flagId: 4);
    controller.helper.insertCardModel(card1);

    var card2 = CardModel(
        name: 'PAN',
        titular: 'Jakson Henrique de Almeida Paulino',
        number: '5534500624714013',
        valid: '12/27',
        cvc: 742,
        limite: 500.0,
        closure: '26',
        maturity: '12',
        cor: '44474C',
        saldo: 500.0,
        status: 'A',
        flagId: 4);
    controller.helper.insertCardModel(card2);

    var conta1 =
        ContaModel(name: 'PICPAY', saldo: 2452.27, tipo: 'C', status: 'A');
    controller.helper.insertContaModel(conta1); */

    /* {id: 1, name: Nubank, titular: Jakson Henrique de Almeida Paulino, number: 5162926165942698, valid: 01/29,
     cvc: 825, limite: 2700.0, closure: 03, maturity: 10, cor: FF5115, saldo: null, status: A}

    {id: 2, name: PAN, titular: Jakson Henrique De Almeida Paulino, number: 5534500624714013, 
     valid: 12/27, cvc: 742, limite: 500.0, closure: 26, maturity: 12, cor: 44474C, saldo: null, status: A} */
    controller.getAllFlag();
    controller.getAllCard();
    controller.getAllConta();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
            expandedHeight: height * .27,
            backgroundColor: Colors.transparent,
            brightness: Brightness.dark,
            floating: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(background: CustomAppBar())),
        SliverList(
            delegate: SliverChildListDelegate(<Widget>[
          Observer(builder: (_) {
            return Column(
              children: [
                SeparatorBar(
                    title: 'Contas', fontSize: 20, fontweight: FontWeight.w900),
                Column(
                    children: controller.contas.map<Widget>((conta) {
                  return GestureDetector(
                      child: CustomConta(conta: conta),
                      onTap: () {
                        Modular.to
                            .pushNamed('/conta', arguments: [false, conta]);
                      });
                }).toList()),
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.transparent,
                  elevation: 0,
                  onPressed: () {
                    Modular.to
                        .pushNamed('/conta', arguments: [true, ContaModel()]);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    width: width * .5,
                    child: Row(
                      children: [
                        Icon(Icons.add_circle_outline,
                            color: AppColors.primary),
                        SizedBox(width: 5),
                        Text('Adicionar Nova Conta'),
                      ],
                    ),
                  ),
                ),
                SeparatorBar(
                    title: 'Cartões',
                    fontSize: 20,
                    fontweight: FontWeight.w900),
                Column(
                    children: controller.cards.map<Widget>((card) {
                  return GestureDetector(
                      child: CustomCard(card: card),
                      onTap: () {
                        Modular.to.pushNamed('/card', arguments: [false, card]);
                      });
                }).toList()),
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.transparent,
                  elevation: 0,
                  onPressed: () {
                    Modular.to
                        .pushNamed('/card', arguments: [true, CardModel()]);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    width: width * .5,
                    child: Row(
                      children: [
                        Icon(Icons.add_circle_outline,
                            color: AppColors.primary),
                        SizedBox(width: 5),
                        Text('Adicionar Novo Cartão'),
                      ],
                    ),
                  ),
                ),
              ],
            );
          })
        ]))
      ]),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add), tooltip: 'Create', onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: AppColors.primary,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Container(
            height: 50,
            child: Row(
              children: <Widget>[
                IconButton(
                    tooltip: 'Open navigation menu',
                    icon: const Icon(Icons.menu),
                    onPressed: () {}),
                IconButton(
                    tooltip: 'Open navigation menu',
                    icon: const Icon(Icons.credit_card_outlined),
                    onPressed: () {}),
                const Spacer(),
                IconButton(
                    tooltip: 'Favorite',
                    icon: const Icon(Icons.favorite),
                    onPressed: () {}),
                IconButton(
                    tooltip: 'Open navigation menu',
                    icon: const Icon(Icons.menu),
                    onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
