import 'package:controlmoney/app/shared/models/card_model.dart';
import 'package:controlmoney/app/shared/theme/app_colors.dart';
import 'package:controlmoney/app/shared/ultils/currency_input_formatter.dart';
import 'package:controlmoney/app/shared/ultils/custom_format.dart';
import 'package:controlmoney/app/shared/ultils/mask_map.dart';
import 'package:controlmoney/app/shared/ultils/month_picker.dart';
import 'package:controlmoney/app/shared/widget/custom_auto_text.dart';
import 'package:controlmoney/app/shared/widget/custom_dialog.dart';
import 'package:controlmoney/app/shared/widget/custom_icon_button.dart';
import 'package:controlmoney/app/shared/widget/custom_load_button.dart';
import 'package:controlmoney/app/shared/widget/separator_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../home_controller.dart';
import 'card_controller.dart';

class CardPage extends StatefulWidget {
  final String title;
  final CardModel card;
  final bool neww;
  const CardPage({Key key, this.title = "Card", this.card, this.neww})
      : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends ModularState<CardPage, CardController> {
  //use 'controller' variable to access controller
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  HomeController homeController = Modular.get<HomeController>();

  Color _currentColor = Colors.blue;

  bool validCor = false;

  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_statements
    widget.neww
        ? widget.card.cor = '1f0182'
        : controller.preencheCard(widget.card);
  }

  _copiaDados(String texto) {
    return {
      Clipboard.setData(new ClipboardData(text: texto)),
      Clipboard.getData('text/plain')
          .then((value) => _showScaffold('${value.text} - copia feita!'))
    };
  }

  _showScaffold(String text) {
    // ignore: deprecated_member_use
    return _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text('$text'),
    ));
  }

  _showMonthPicket() {
    return showMonthPicker(
            context: context,
            firstDate: DateTime(1900, 1),
            lastDate: DateTime(2100),
            initialDate: DateTime.now())
        .then((date) => setState(() {
              controller.dtaValid = Appformat.monthYear.format(date);
              controller.validController.text =
                  Appformat.monthYear.format(date);
            }));
  }

  _showCorDialog(context) {
    return customDialog(context,
        barrierDismissible: false,
        content: Center(
          child: CircleColorPicker(
              size: Size(250, 250),
              initialColor: _currentColor,
              onChanged: _onColorChanged),
        ),
        buttons: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .062,
            // ignore: deprecated_member_use
            child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  setState(() {
                    controller.corController.text = _currentColor.value
                        .toRadixString(16)
                        .substring(2)
                        .toUpperCase();
                    validCor = !validCor;
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
                color: AppColors.primary),
          )
        ]);
  }

  /* Future<void> _showDatePicker(cxt) async {
    final picked = await showDatePicker(
      context: cxt,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.primary, // button text color
              ),
            ),
          ),
          child: child,
        );
      },
    );
    setState(() {
      controller.dtaValid = Appformat.monthYear.format(picked);
      controller.validController.text = Appformat.monthYear.format(picked);
    });
  }
 */
  void _onColorChanged(Color color) {
    setState(() {
      _currentColor = color;
      controller.corController.text =
          _currentColor.value.toRadixString(16).substring(2).toUpperCase();
    });
  }

  @override
  void dispose() {
    super.dispose();
    homeController.getAllCard();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(widget.card.name ?? 'Cadastrar Novo Cartão')),
      body: SingleChildScrollView(
        child: Observer(
          builder: (_) {
            return Column(
              children: <Widget>[
                Card(
                  elevation: 10,
                  color:
                      Color(int.parse('0xff${controller.corController.text}')),
                  margin: EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  child: Container(
                    width: width,
                    height: 215,
                    padding: EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${controller.nameController.text}',
                                    style: TextFormat.cabecalho),
                                SizedBox(height: 10),
                                GestureDetector(
                                  child: Text(
                                      '${masks['number'].maskText(controller.numberController.text)}',
                                      style: TextFormat.number),
                                  onTap: () {
                                    _copiaDados(widget.card.number);
                                  },
                                ),
                              ],
                            ),
                            Image.asset(controller.flagSelect.img,
                                width: controller.flagSelect.id == 1
                                    ? width * .22
                                    : width * .20,
                                fit: BoxFit.cover),
                          ],
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          child: Text(controller.titularController.text ?? '',
                              style: TextFormat.dados),
                          onTap: () {
                            _copiaDados(widget.card.titular);
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: CustomText(
                                  title: 'Valid.',
                                  test: '${controller.validController.text}',
                                  fontSize: 'bot',
                                  corl: 'wht'),
                              onTap: () {
                                _copiaDados(Appformat.monthYear
                                    .format(DateTime.parse(widget.card.valid)));
                              },
                            ),
                            GestureDetector(
                              child: CustomText(
                                  title: 'CVC',
                                  test: '${controller.cvcController.text}',
                                  fontSize: 'bot',
                                  corl: 'wht'),
                              onTap: () {
                                _copiaDados(widget.card.cvc.toString());
                              },
                            ),
                            CustomText(
                                title: 'Fech.',
                                test: '${controller.closureController.text}',
                                fontSize: 'bot',
                                corl: 'wht'),
                            CustomText(
                                title: 'Venc.',
                                test: '${controller.maturityController.text}',
                                fontSize: 'bot',
                                corl: 'wht'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    title: 'Limite de Credito',
                                    test:
                                        'R\$ ${controller.limiteController.text}',
                                    fontSize: 'bot',
                                    corl: 'wht'),
                                SizedBox(height: 5),
                                GestureDetector(
                                  child: CustomText(
                                      title: 'Saldo Disponível',
                                      test:
                                          'R\$ ${controller.saldoController.text}',
                                      fontSize: 'bot',
                                      corl: 'wht'),
                                  onTap: () {
                                    _copiaDados(widget.card.saldo.toString());
                                  },
                                ),
                              ],
                            ),
                            CustomText(
                                title: 'Status',
                                test:
                                    '${controller.statusMap[controller.status]}',
                                fontSize: 'bot',
                                corl: 'wht'),
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
                          key: controller.cardForm,
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller.nameController,
                                      keyboardType: TextInputType.name,
                                      textCapitalization:
                                          TextCapitalization.words,
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
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
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
                                        hint: Text("Bandeira"),
                                        iconEnabledColor: Colors.black,
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        style: TextStyle(fontSize: 18),
                                        items: homeController.flags.map((flag) {
                                          return DropdownMenuItem<String>(
                                            value: flag.name,
                                            onTap: () {
                                              controller.flagSelect = flag;
                                            },
                                            child: Text(flag.name,
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          );
                                        }).toList(),
                                        value: controller.descFlag,
                                        onChanged: (value) {
                                          setState(() {
                                            controller.descFlag = value;
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: controller.numberController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'Numero',
                                    labelText: 'Numero',
                                    labelStyle: TextFormat.textField),
                                // ignore: missing_return
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return _showScaffold(
                                        'Informe o Numero do Cartão!');
                                  }
                                },
                                inputFormatters: [masks['number']],
                                onChanged: (_) {
                                  setState(() {
                                    controller.numberController;
                                  });
                                },
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: controller.titularController,
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                    hintText: 'Titular',
                                    labelText: 'Titular',
                                    labelStyle: TextFormat.textField),
                                // ignore: missing_return
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return _showScaffold(
                                        'Informe o Titular do Cartão!');
                                  }
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(40)
                                ],
                                onChanged: (_) {
                                  setState(() {
                                    // ignore: unnecessary_statements
                                    controller.titularController;
                                  });
                                },
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller.validController,
                                      keyboardType: TextInputType.datetime,
                                      decoration: InputDecoration(
                                          labelText: 'Data de Validade',
                                          hintText: 'Data de Validade',
                                          labelStyle: TextFormat.textField,
                                          suffixIcon: Icon(Icons.calendar_today,
                                              color: AppColors.primary)),
                                      onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        _showMonthPicket();
                                      },
                                      inputFormatters: [masks['monthyear']],
                                      onChanged: (_) {
                                        setState(() {
                                          // ignore: unnecessary_statements
                                          controller.validController;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller.cvcController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: 'CVC',
                                          labelText: 'CVC',
                                          labelStyle: TextFormat.textField),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(3)
                                      ],
                                      // ignore: missing_return
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return _showScaffold(
                                              'Informe o CVC!');
                                        }
                                      },
                                      onChanged: (_) {
                                        setState(() {
                                          // ignore: unnecessary_statements
                                          controller.cvcController;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller.closureController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: 'Fech. Fatura',
                                          labelText: 'Fech. Fatura',
                                          labelStyle: TextFormat.textField),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(2)
                                      ],
                                      // ignore: missing_return
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return _showScaffold(
                                              'Informe Dia de Vencimento!');
                                        }
                                      },
                                      onChanged: (_) {
                                        setState(() {
                                          // ignore: unnecessary_statements
                                          controller.closureController;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller.maturityController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: 'Venc',
                                          labelText: 'Venc',
                                          labelStyle: TextFormat.textField),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(2)
                                      ],
                                      // ignore: missing_return
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return _showScaffold(
                                              'Informe a Data de Vencimento!');
                                        }
                                      },
                                      onChanged: (_) {
                                        setState(() {
                                          // ignore: unnecessary_statements
                                          controller.maturityController;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller.limiteController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: 'Limite',
                                          labelText: 'Limite',
                                          labelStyle: TextFormat.textField),
                                      // ignore: missing_return
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return _showScaffold(
                                              'Informe o Limite do Cartão!');
                                        }
                                      },
                                      onChanged: (_) {
                                        setState(() {
                                          // ignore: unnecessary_statements
                                          controller.limiteController;
                                        });
                                      },
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(8),
                                        // ignore: deprecated_member_use
                                        WhitelistingTextInputFormatter
                                            // ignore: deprecated_member_use
                                            .digitsOnly,
                                        new CurrencyInputFormatter()
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: TextFormField(
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
                                          controller.limiteController;
                                        });
                                      },
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(8),
                                        // ignore: deprecated_member_use
                                        WhitelistingTextInputFormatter
                                            // ignore: deprecated_member_use
                                            .digitsOnly,
                                        new CurrencyInputFormatter()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      controller: controller.corController,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      decoration: InputDecoration(
                                          labelText: 'Cor do Cartão',
                                          hintText: 'Cor do Cartão',
                                          labelStyle: TextFormat.textField,
                                          suffixIcon: Icon(
                                            Icons.color_lens_outlined,
                                            color: AppColors.primary,
                                          )),
                                      // ignore: missing_return
                                      validator: (value) {
                                        if (value.length != 6) {
                                          controller.corController.text =
                                              '1f0182';
                                          return _showScaffold(
                                              'Informe a Cor de Cartão!');
                                        }
                                      },
                                      onFieldSubmitted: (value) =>
                                          validCor = !validCor,
                                      onTap: validCor
                                          ? () {}
                                          : () {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());
                                              _showCorDialog(context);
                                            },
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(6)
                                      ],
                                      onChanged: (_) {
                                        setState(() {
                                          // ignore: unnecessary_statements
                                          controller.corController;
                                        });
                                      },
                                    ),
                                  ),
                                  /* IconButton(
                                    icon: Icon(
                                      Icons.color_lens_outlined,
                                      color: AppColors.primary,
                                    ),
                                    onPressed: () {
                                      customDialog(context,
                                          barrierDismissible: false,
                                          content: Center(
                                            child: CircleColorPicker(
                                                size: Size(250, 250),
                                                initialColor: _currentColor,
                                                onChanged: _onColorChanged),
                                          ),
                                          buttons: [
                                            Container(
                                              width: width,
                                              height: height * .062,
                                              // ignore: deprecated_member_use
                                              child: RaisedButton(
                                                  elevation: 5,
                                                  onPressed: () {
                                                    setState(() {
                                                      controller.corController
                                                              .text =
                                                          _currentColor.value
                                                              .toRadixString(16)
                                                              .substring(2)
                                                              .toUpperCase();
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Ok'),
                                                  color: AppColors.primary),
                                            )
                                          ]);
                                    },
                                  ), */
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
                                      ])),
                                ],
                              ),
                              SizedBox(height: 10),
                              CustomLoadButton(
                                  txt: widget.neww ? 'Salvar' : 'Atualizar',
                                  loading: controller.loading,
                                  onPressed: () {
                                    if (controller.cardForm.currentState
                                        .validate()) {
                                      widget.neww
                                          ? controller.insertCardModel()
                                          : controller.updateCard();
                                      Modular.to.pop();
                                    }
                                  })
                            ],
                          ),
                        ),
                      )
                    : Container(
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
