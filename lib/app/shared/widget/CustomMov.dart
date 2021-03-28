import 'package:controlmoney/app/modules/home/home_controller.dart';
import 'package:controlmoney/app/shared/helper/helper.dart';
import 'package:controlmoney/app/shared/ultils/currency_number.dart';
import 'package:controlmoney/app/shared/ultils/custom_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart' as intl;

final formatterDate = new intl.DateFormat('dd/MM/yyyy');
final formatMoeda = new intl.NumberFormat("####,##", "pt-br");

class CustomMov extends StatefulWidget {
  @override
  _CustomMovState createState() => _CustomMovState();
}

class _CustomMovState extends State<CustomMov> {
  HomeController homeController = Modular.get<HomeController>();
  TextEditingController valorController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController datController = TextEditingController();
  TextEditingController parcelaController = TextEditingController();
  int radioGroupMov = 2;
  int radioGroupTipo = 1;
  Color colorContainer = Colors.red[400];
  Color colorTextButtom = Colors.red[400];
  String descMov = 'Receita';
  String descCard = '';
  String descConta = '';
  bool parcelar = false;

  DataBaseHelper helper = DataBaseHelper();

  Map<String, dynamic> mov = {
    'id': null,
    'name': null,
    'valor': null,
    'dataMov': null,
    'dataFat': null,
    'cartaoId': null,
    'card': null,
    'dataPag': null,
    'contaId': null,
    'conta': null,
    'pg': null
  };

  @override
  void initState() {
    super.initState();
    descCard = homeController.cards[0].name;
    descConta = homeController.contas[0].name;
  }

  submitDespesa() {
    mov['name'] = descController.text;
    mov['valor'] = double.parse(valorController.text);
  }

  Future<void> _showDatePicker(cxt) async {
    final picked = await showDatePicker(
      context: cxt,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: colorContainer, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: colorContainer, // button text color
              ),
            ),
          ),
          child: child,
        );
      },
    );
    setState(() {
      datController.text = Appformat.date.format(picked);
      mov['dataMov'] = Appformat.dateHifen.format(picked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(constraints.maxWidth * 0.050)),
          backgroundColor: colorContainer,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text("Adicionar $descMov",
                    textAlign: TextAlign.center, style: TextFormat.movTopWhite),
                SizedBox(height: 5),
                Row(children: <Widget>[
                  Radio(
                      activeColor: Colors.white,
                      value: 1,
                      fillColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                      groupValue: radioGroupMov,
                      onChanged: (value) {
                        setState(() {
                          radioGroupMov = value;
                          colorContainer = Colors.green[400];
                          colorTextButtom = Colors.green;
                          descMov = 'Receita';
                        });
                      }),
                  Text("receita", style: TextFormat.movWhite),
                  Radio(
                      activeColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                      value: 2,
                      groupValue: radioGroupMov,
                      onChanged: (value) {
                        setState(() {
                          radioGroupMov = value;
                          colorContainer = Colors.red[400];
                          colorTextButtom = Colors.red[400];
                          descMov = 'Despesa';
                        });
                      }),
                  Text("despesa", style: TextFormat.movWhite)
                ]),
                SizedBox(height: 5),
                Row(children: <Widget>[
                  Flexible(
                      child: TextField(
                          controller: valorController,
                          autofocus: true,
                          style: TextFormat.movWhite,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(8),
                            // ignore: deprecated_member_use
                            WhitelistingTextInputFormatter.digitsOnly,
                            //BlacklistingTextInputFormatter.singleLineFormatter,
                            new CurrencyNumber()
                          ],
                          decoration: new InputDecoration(
                            prefixText: "R\$ ",
                            prefixStyle: TextFormat.movWhite,
                            hintText: "0.00",
                            hintStyle: TextStyle(color: Colors.white54),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    constraints.maxWidth * 0.04),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 2.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    constraints.maxWidth * 0.04),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 2.0)),
                          )))
                ]),
                SizedBox(height: 15),
                TextField(
                    controller: descController,
                    style: TextFormat.movWhite,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    textCapitalization: TextCapitalization.sentences,
                    inputFormatters: [LengthLimitingTextInputFormatter(30)],
                    decoration: new InputDecoration(
                        hintText: "Descrição",
                        hintStyle: TextStyle(color: Colors.white54),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                constraints.maxWidth * 0.04),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                constraints.maxWidth * 0.04),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0)))),
                SizedBox(height: 15),
                Row(children: <Widget>[
                  Flexible(
                      child: TextField(
                          controller: datController,
                          style: TextFormat.movWhite,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _showDatePicker(context);
                          },
                          decoration: new InputDecoration(
                              suffixIcon: Icon(Icons.calendar_today,
                                  color: Colors.white),
                              hintText: formatterDate.format(DateTime.now()),
                              hintStyle: TextStyle(color: Colors.white54),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      constraints.maxWidth * 0.04),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      constraints.maxWidth * 0.04),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0))))),
                ]),
                Row(children: <Widget>[
                  Radio(
                      activeColor: Colors.white,
                      value: 1,
                      fillColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                      groupValue: radioGroupTipo,
                      onChanged: (value) {
                        setState(() {
                          radioGroupTipo = value;
                        });
                      }),
                  Text("Crédito", style: TextFormat.movWhite),
                  Radio(
                      activeColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                      value: 2,
                      groupValue: radioGroupTipo,
                      onChanged: (value) {
                        setState(() {
                          radioGroupTipo = value;
                        });
                      }),
                  Text("Débito", style: TextFormat.movWhite)
                ]),
                SizedBox(height: 5),
                radioGroupTipo == 1
                    ? Container(
                        height: 60,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 12, right: 6),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(
                                constraints.maxWidth * 0.04)),
                        child: DropdownButton(
                          elevation: 6,
                          iconEnabledColor: Colors.white,
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextFormat.movWhite,
                          dropdownColor: Colors.white,
                          selectedItemBuilder: (BuildContext context) {
                            return homeController.cards.map((card) {
                              return Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(descCard,
                                      style: TextFormat.movWhite));
                            }).toList();
                          },
                          items: homeController.cards.map((card) {
                            return DropdownMenuItem<String>(
                                value: card.name,
                                onTap: () {
                                  mov['cartaoId'] = card.id;
                                  mov['card'] = card;
                                  mov['contaId'] = null;
                                  mov['conta'] = null;
                                },
                                child: Text(card.name,
                                    style: TextFormat.movBlack));
                          }).toList(),
                          value: descCard,
                          onChanged: (value) {
                            setState(() {
                              descCard = value;
                            });
                          },
                        ),
                      )
                    : Container(
                        height: 60,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 12, right: 6),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(
                                constraints.maxWidth * 0.04)),
                        child: DropdownButton(
                          elevation: 6,
                          iconEnabledColor: Colors.white,
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextFormat.movWhite,
                          dropdownColor: Colors.white,
                          selectedItemBuilder: (BuildContext context) {
                            return homeController.contas.map((cont) {
                              return Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(descConta,
                                      style: TextFormat.movWhite));
                            }).toList();
                          },
                          items: homeController.contas.map((cont) {
                            return DropdownMenuItem<String>(
                                value: cont.name,
                                onTap: () {
                                  mov['contaId'] = cont.id;
                                  mov['conta'] = cont;
                                  mov['cartaoId'] = null;
                                  mov['card'] = null;
                                },
                                child: Text(cont.name,
                                    style: TextFormat.movBlack));
                          }).toList(),
                          value: descConta,
                          onChanged: (value) {
                            setState(() {
                              descConta = value;
                            });
                          },
                        ),
                      ),
                SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(width: 5),
                    Expanded(
                        child: Column(children: [
                      Checkbox(
                          value: parcelar,
                          activeColor: Colors.white,
                          checkColor: colorTextButtom,
                          fillColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.white),
                          onChanged: (v) {
                            setState(() {
                              parcelar = v;
                            });
                          }),
                      Text('Parcelado', style: TextFormat.movWhite),
                    ])),
                    SizedBox(width: 5),
                    Expanded(
                      child: TextField(
                          controller: descController,
                          style: TextFormat.movWhite,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          textCapitalization: TextCapitalization.sentences,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30)
                          ],
                          decoration: new InputDecoration(
                              hintText: "00",
                              hintStyle: TextStyle(color: Colors.white54),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      constraints.maxWidth * 0.04),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      constraints.maxWidth * 0.04),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)))),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: constraints.maxWidth * 0.09),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancelar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22))),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(
                              top: constraints.maxWidth * 0.02,
                              bottom: constraints.maxWidth * 0.02,
                              left: constraints.maxWidth * 0.03,
                              right: constraints.maxWidth * 0.03),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white),
                          child: Center(
                            child: Text(
                              "Confirmar",
                              style: TextStyle(
                                  color: colorTextButtom,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ));
    });
  }
}
