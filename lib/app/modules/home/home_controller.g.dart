// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$helperAtom = Atom(name: '_HomeControllerBase.helper');

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

  final _$cardsAtom = Atom(name: '_HomeControllerBase.cards');

  @override
  ObservableList<CardModel> get cards {
    _$cardsAtom.reportRead();
    return super.cards;
  }

  @override
  set cards(ObservableList<CardModel> value) {
    _$cardsAtom.reportWrite(value, super.cards, () {
      super.cards = value;
    });
  }

  final _$contasAtom = Atom(name: '_HomeControllerBase.contas');

  @override
  ObservableList<ContaModel> get contas {
    _$contasAtom.reportRead();
    return super.contas;
  }

  @override
  set contas(ObservableList<ContaModel> value) {
    _$contasAtom.reportWrite(value, super.contas, () {
      super.contas = value;
    });
  }

  @override
  String toString() {
    return '''
helper: ${helper},
cards: ${cards},
contas: ${contas}
    ''';
  }
}
