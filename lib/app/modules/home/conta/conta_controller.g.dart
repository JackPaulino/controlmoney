// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conta_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ContaController on _ContaControllerBase, Store {
  final _$helperAtom = Atom(name: '_ContaControllerBase.helper');

  @override
  DataBaseHelper get helper {
    _$helperAtom.reportRead();
    return super.helper;
  }

  @override
  set helper(DataBaseHelper value) {
    _$helperAtom.reportWrite(value, super.helper, () {
      super.helper = value;
    });
  }

  final _$editeAtom = Atom(name: '_ContaControllerBase.edite');

  @override
  bool get edite {
    _$editeAtom.reportRead();
    return super.edite;
  }

  @override
  set edite(bool value) {
    _$editeAtom.reportWrite(value, super.edite, () {
      super.edite = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ContaControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$idContaAtom = Atom(name: '_ContaControllerBase.idConta');

  @override
  int get idConta {
    _$idContaAtom.reportRead();
    return super.idConta;
  }

  @override
  set idConta(int value) {
    _$idContaAtom.reportWrite(value, super.idConta, () {
      super.idConta = value;
    });
  }

  final _$tipoAtom = Atom(name: '_ContaControllerBase.tipo');

  @override
  String get tipo {
    _$tipoAtom.reportRead();
    return super.tipo;
  }

  @override
  set tipo(String value) {
    _$tipoAtom.reportWrite(value, super.tipo, () {
      super.tipo = value;
    });
  }

  final _$tiposiglaAtom = Atom(name: '_ContaControllerBase.tiposigla');

  @override
  Map<String, String> get tiposigla {
    _$tiposiglaAtom.reportRead();
    return super.tiposigla;
  }

  @override
  set tiposigla(Map<String, String> value) {
    _$tiposiglaAtom.reportWrite(value, super.tiposigla, () {
      super.tiposigla = value;
    });
  }

  final _$tipodescAtom = Atom(name: '_ContaControllerBase.tipodesc');

  @override
  Map<String, String> get tipodesc {
    _$tipodescAtom.reportRead();
    return super.tipodesc;
  }

  @override
  set tipodesc(Map<String, String> value) {
    _$tipodescAtom.reportWrite(value, super.tipodesc, () {
      super.tipodesc = value;
    });
  }

  final _$statusAtom = Atom(name: '_ContaControllerBase.status');

  @override
  bool get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(bool value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$statusboolAtom = Atom(name: '_ContaControllerBase.statusbool');

  @override
  Map<String, bool> get statusbool {
    _$statusboolAtom.reportRead();
    return super.statusbool;
  }

  @override
  set statusbool(Map<String, bool> value) {
    _$statusboolAtom.reportWrite(value, super.statusbool, () {
      super.statusbool = value;
    });
  }

  final _$statusstrAtom = Atom(name: '_ContaControllerBase.statusstr');

  @override
  Map<bool, String> get statusstr {
    _$statusstrAtom.reportRead();
    return super.statusstr;
  }

  @override
  set statusstr(Map<bool, String> value) {
    _$statusstrAtom.reportWrite(value, super.statusstr, () {
      super.statusstr = value;
    });
  }

  final _$statusdescAtom = Atom(name: '_ContaControllerBase.statusdesc');

  @override
  Map<bool, String> get statusdesc {
    _$statusdescAtom.reportRead();
    return super.statusdesc;
  }

  @override
  set statusdesc(Map<bool, String> value) {
    _$statusdescAtom.reportWrite(value, super.statusdesc, () {
      super.statusdesc = value;
    });
  }

  final _$nameControllerAtom =
      Atom(name: '_ContaControllerBase.nameController');

  @override
  TextEditingController get nameController {
    _$nameControllerAtom.reportRead();
    return super.nameController;
  }

  @override
  set nameController(TextEditingController value) {
    _$nameControllerAtom.reportWrite(value, super.nameController, () {
      super.nameController = value;
    });
  }

  final _$tipoControllerAtom =
      Atom(name: '_ContaControllerBase.tipoController');

  @override
  TextEditingController get tipoController {
    _$tipoControllerAtom.reportRead();
    return super.tipoController;
  }

  @override
  set tipoController(TextEditingController value) {
    _$tipoControllerAtom.reportWrite(value, super.tipoController, () {
      super.tipoController = value;
    });
  }

  final _$saldoControllerAtom =
      Atom(name: '_ContaControllerBase.saldoController');

  @override
  TextEditingController get saldoController {
    _$saldoControllerAtom.reportRead();
    return super.saldoController;
  }

  @override
  set saldoController(TextEditingController value) {
    _$saldoControllerAtom.reportWrite(value, super.saldoController, () {
      super.saldoController = value;
    });
  }

  final _$contaFormAtom = Atom(name: '_ContaControllerBase.contaForm');

  @override
  GlobalKey<FormState> get contaForm {
    _$contaFormAtom.reportRead();
    return super.contaForm;
  }

  @override
  set contaForm(GlobalKey<FormState> value) {
    _$contaFormAtom.reportWrite(value, super.contaForm, () {
      super.contaForm = value;
    });
  }

  final _$_ContaControllerBaseActionController =
      ActionController(name: '_ContaControllerBase');

  @override
  void preencheCard(ContaModel conta) {
    final _$actionInfo = _$_ContaControllerBaseActionController.startAction(
        name: '_ContaControllerBase.preencheCard');
    try {
      return super.preencheCard(conta);
    } finally {
      _$_ContaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
helper: ${helper},
edite: ${edite},
loading: ${loading},
idConta: ${idConta},
tipo: ${tipo},
tiposigla: ${tiposigla},
tipodesc: ${tipodesc},
status: ${status},
statusbool: ${statusbool},
statusstr: ${statusstr},
statusdesc: ${statusdesc},
nameController: ${nameController},
tipoController: ${tipoController},
saldoController: ${saldoController},
contaForm: ${contaForm}
    ''';
  }
}
