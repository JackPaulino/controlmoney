import 'package:controlmoney/app/shared/models/conta_model.dart';
import 'package:controlmoney/app/shared/ultils/custom_format.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'custom_auto_text.dart';

class CustomConta extends StatelessWidget {
  final ContaModel conta;

  const CustomConta({Key key, this.conta}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[50],
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
                child: Row(
              children: [
                Icon(
                    conta.status == 'A'
                        ? MdiIcons.briefcase
                        : MdiIcons.briefcaseOff,
                    size: 35,
                    color: Colors.black),
                SizedBox(width: 5),
                CustomText(test: '${conta.name}', fontSize: 'top', corl: 'bck'),
              ],
            )),
            Expanded(
              child: CustomText(
                  title: 'Saldo',
                  test: '${Appformat.moneyR$.format(conta.saldo)}',
                  fontSize: 'cen',
                  corl: 'bck'),
            ),
          ],
        ),
      ),
    );
  }
}

Map<String, String> tipoMap = {'C': 'Conta', 'I': 'Inativo'};
Map<String, bool> statusMap = {'A': true, 'I': false};
