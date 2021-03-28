import 'package:controlmoney/app/shared/models/conta_model.dart';
import 'package:controlmoney/app/shared/theme/app_colors.dart';
import 'package:controlmoney/app/shared/ultils/currency_number.dart';
import 'package:controlmoney/app/shared/ultils/custom_format.dart';
import 'package:controlmoney/app/shared/widget/custom_auto_text.dart';
import 'package:controlmoney/app/shared/widget/custom_icon_button.dart';
import 'package:controlmoney/app/shared/widget/custom_load_button.dart';
import 'package:controlmoney/app/shared/widget/separator_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../home_controller.dart';
import 'conta_controller.dart';

class ContaPage extends StatefulWidget {
  final bool neww;
  final ContaModel conta;
  final String title;
  const ContaPage({Key key, this.title = "Conta", this.neww, this.conta})
      : super(key: key);

  @override
  _ContaPageState createState() => _ContaPageState();
}

class _ContaPageState extends ModularState<ContaPage, ContaController> {
  //use 'controller' variable to access controller
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  HomeController homeController = Modular.get<HomeController>();

  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_statements
    widget.neww ? null : controller.preencheCard(widget.conta);
    controller.listTipoConta();
  }

  _showScaffold(String text) {
    // ignore: deprecated_member_use
    return _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text('$text'),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    homeController.getAllConta();
  }

  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(widget.conta.name ?? 'Cadastrar Novo Conta')),
      body: SingleChildScrollView(
        child: Observer(
          builder: (_) {
            return Column(
              children: <Widget>[
                Card(
                  elevation: 10,
                  margin: EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  child: Container(
                    width: width,
                    padding: EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: CustomText(
                                    title: 'Name',
                                    test: '${controller.nameController.text}',
                                    fontSize: 'cen',
                                    corl: 'bck')),
                            Expanded(
                                child: CustomText(
                                    title: 'Saldo',
                                    test:
                                        'R\$ ${controller.saldoController.text}',
                                    fontSize: 'cen',
                                    align: 'end',
                                    corl: 'bck')),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: CustomText(
                                    title: 'Status',
                                    test:
                                        '${controller.statusdesc[controller.status]}',
                                    fontSize: 'cen',
                                    corl: 'bck')),
                            Expanded(
                                flex: 2,
                                child: CustomText(
                                    title: 'Tipo',
                                    test:
                                        '${controller.tiposigla[controller.tipo]}',
                                    fontSize: 'cen',
                                    align: 'end',
                                    corl: 'bck')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                widget.neww
                    ? Container()
                    : Container(
                        width: width,
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomIconButton(
                              text: 'Editar',
                              icon: Icon(Icons.edit_outlined,
                                  color: Colors.white),
                              ativeButton: true,
                              onPressed: () {
                                setState(() {
                                  controller.edite = !controller.edite;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                controller.edite || widget.neww
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        width: width,
                        child: Form(
                          key: controller.contaForm,
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              TextFormField(
                                controller: controller.nameController,
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                    hintText: 'Nome do Cartão',
                                    labelText: 'Nome do Cartão',
                                    labelStyle: TextFormat.textField),
                                // ignore: missing_return
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return _showScaffold(
                                        'Informe o Nome do Cartão!');
                                  }
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(18)
                                ],
                                onChanged: (_) {
                                  setState(() {
                                    controller.nameController;
                                  });
                                },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: controller.saldoController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'Saldo',
                                    labelText: 'Saldo',
                                    labelStyle: TextFormat.textField),
                                // ignore: missing_return
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return _showScaffold(
                                        'Informe o Informe o Saldo do Cartão!');
                                  }
                                },
                                onChanged: (_) {
                                  setState(() {
                                    // ignore: unnecessary_statements
                                    controller.saldoController;
                                  });
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(8),
                                  // ignore: deprecated_member_use
                                  WhitelistingTextInputFormatter
                                      // ignore: deprecated_member_use
                                      .digitsOnly,
                                  new CurrencyNumber()
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 62,
                                      alignment: Alignment.center,
                                      padding:
                                          EdgeInsets.only(left: 12, right: 6),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.primary),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: DropdownButton(
                                        elevation: 6,
                                        hint: Text("Tipo"),
                                        iconEnabledColor: Colors.black,
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        style: TextStyle(fontSize: 18),
                                        items: controller.listConta.map((flag) {
                                          return DropdownMenuItem<String>(
                                            value: flag,
                                            onTap: () {
                                              controller.tipo =
                                                  controller.tipodesc[flag];
                                            },
                                            child: Text(flag,
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          );
                                        }).toList(),
                                        value: controller.descTipo,
                                        onChanged: (value) {
                                          setState(() {
                                            controller.descTipo = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    flex: 1,
                                    child: Column(children: [
                                      Checkbox(
                                          value: controller.status,
                                          activeColor: AppColors.primary,
                                          onChanged: (v) {
                                            setState(() {
                                              controller.status = v;
                                            });
                                          }),
                                      Text('Ativo',
                                          style: TextFormat.textField),
                                    ]),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              CustomLoadButton(
                                  txt: widget.neww ? 'Salvar' : 'Atualizar',
                                  loading: controller.loading,
                                  onPressed: () {
                                    if (controller.contaForm.currentState
                                        .validate()) {
                                      widget.neww
                                          ? controller.insertConta()
                                          : controller.updateConta();
                                      Modular.to.pop();
                                    }
                                  })
                            ],
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 18, right: 18, top: 8),
                  width: width,
                  child: Column(
                    children: [
                      SeparatorBar(
                          title: 'Histórico de Compras',
                          fontSize: 20,
                          fontweight: FontWeight.w900),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
