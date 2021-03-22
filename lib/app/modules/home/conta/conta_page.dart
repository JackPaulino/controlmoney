import 'package:controlmoney/app/shared/models/conta_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.conta.name ?? 'Cadastrar Novo Conta'),
          brightness: Brightness.dark),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
