import 'package:controlmoney/app/shared/helper/helper.dart';
import 'package:controlmoney/app/shared/ultils/currency_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;

final formatterDate = new intl.DateFormat('dd/MM/yyyy');
final formatMoeda = new intl.NumberFormat("####,##", "pt-br");

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  int _groupValueRadio = 1;
  Color _colorContainer = Colors.green[400];
  Color _colorTextButtom = Colors.green;
  TextEditingController _controllerValor = TextEditingController();
  TextEditingController _controllerDesc = TextEditingController();
  TextEditingController _controllerDat = TextEditingController();

  DataBaseHelper helper = DataBaseHelper();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    MaterialLocalizations.of(context);

    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * 0.050)),
        title: Text(
          "Adicionar Valores",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: _colorContainer,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "R\$ ",
                    style:
                        TextStyle(color: Colors.white, fontSize: width * 0.06),
                  ),
                  Flexible(
                    child: TextField(
                        controller: _controllerValor,
                        autofocus: true,
                        maxLength: 8,
                        style: TextStyle(fontSize: width * 0.05),
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        //textAlign: TextAlign.right,
                        //textDirection: TextDirection.rtl,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(8),
                          // ignore: deprecated_member_use
                          WhitelistingTextInputFormatter.digitsOnly,
                          //BlacklistingTextInputFormatter.singleLineFormatter,
                          new CurrencyInputFormatter()
                        ],
                        decoration: new InputDecoration(
                          hintText: "0.00",
                          hintStyle: TextStyle(color: Colors.white54),
                          contentPadding: EdgeInsets.only(
                              left: width * 0.04,
                              top: width * 0.041,
                              bottom: width * 0.041,
                              right: width * 0.04), //15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        )),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    activeColor: Colors.green[900],
                    value: 1,
                    groupValue: _groupValueRadio,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _groupValueRadio = value;
                        _colorContainer = Colors.green[400];
                        _colorTextButtom = Colors.green;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.01),
                    child: Text("receita"),
                  ),
                  Radio(
                    activeColor: Colors.red[900],
                    value: 2,
                    groupValue: _groupValueRadio,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _groupValueRadio = value;
                        _colorContainer = Colors.red[300];
                        _colorTextButtom = Colors.red[300];
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.01),
                    child: Text("despesa"),
                  )
                ],
              ),
              TextField(
                  controller: _controllerDesc,
                  maxLength: 20,
                  style: TextStyle(fontSize: width * 0.05),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: new InputDecoration(
                    hintText: "Descrição",
                    labelText: "Descrição",
                    labelStyle: TextStyle(color: Colors.white54),
                    //hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding: EdgeInsets.only(
                        left: width * 0.04,
                        top: width * 0.041,
                        bottom: width * 0.041,
                        right: width * 0.04),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.04),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.04),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  )),
              Padding(
                padding:
                    EdgeInsets.only(bottom: width * 0.09, top: width * 0.02),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                          controller: _controllerDat,
                          style: TextStyle(fontSize: width * 0.05),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          decoration: new InputDecoration(
                            hintText: formatterDate.format(DateTime.now()),
                            hintStyle: TextStyle(color: Colors.white54),
                            contentPadding: EdgeInsets.only(
                                left: width * 0.04,
                                top: width * 0.041,
                                bottom: width * 0.041,
                                right: width * 0.04), //15),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width * 0.04),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width * 0.04),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                          )),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showDatePicker(
                            locale: const Locale('pt'),
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                          ).then((date) {
                            if (date != null) {
                              setState(() {
                                _controllerDat.text =
                                    formatterDate.format(date);
                              });
                            }
                          });
                        })
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: width * 0.09),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        /*  if (_controllerValor.text.isNotEmpty &&
                            _controllerDesc.text.isNotEmpty &&
                            _controllerDat.text.isNotEmpty) {
                          // Movimentacoes mov = Movimentacoes();
                          String valor;
                          if (_controllerValor.text.contains(",")) {
                            valor = _controllerValor.text
                                .replaceAll(RegExp(","), ".");
                            print(_controllerValor.text);
                          } else {
                            valor = _controllerValor.text;
                          }
                          print(valor);
                          if (_controllerValor.text.substring(1, 2) == '.') {
                            valor = _controllerValor.text.substring(0, 1) +
                                _controllerValor.text.substring(2, 3) +
                                _controllerValor.text.substring(3, 4) +
                                _controllerValor.text.substring(4, 5) +
                                '.' +
                                _controllerValor.text.substring(6, 7) +
                                _controllerValor.text.substring(7, 8);
                          }

                          mov.data = _controllerDat.text;
                          mov.descricao = _controllerDesc.text;

                          if (_groupValueRadio == 1) {
                            mov.valor = double.parse(valor);
                            mov.tipo = "r";
                            helper.saveMovimentacao(mov);
                          }
                          if (_groupValueRadio == 2) {
                            mov.valor = double.parse("-" + valor);
                            mov.tipo = "d";
                            helper.saveMovimentacao(mov);
                          }
                          Navigator.pop(context);
                          //initState();
                        } */
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: width * 0.02,
                            bottom: width * 0.02,
                            left: width * 0.03,
                            right: width * 0.03),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            "Confirmar",
                            style: TextStyle(
                                color: _colorTextButtom,
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.05),
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
  }
}
