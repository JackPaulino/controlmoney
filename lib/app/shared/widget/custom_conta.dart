import 'package:controlmoney/app/shared/models/conta_model.dart';
import 'package:controlmoney/app/shared/ultils/custom_format.dart';
import 'package:flutter/material.dart';

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
                Icon(Icons.exposure_rounded, size: 35, color: Colors.black),
                SizedBox(width: 5),
                CustomText(test: '${conta.name}', fontSize: 'top', corl: 'bck'),
              ],
            )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      title: 'Saldo',
                      test: '${Appformat.moneyR$.format(conta.saldo)}',
                      fontSize: 'bot',
                      corl: 'bck'),
                  SizedBox(height: 7),
                  CustomText(
                      title: 'Status',
                      test: '${statusMap[conta.tipo]}',
                      fontSize: 'bot',
                      corl: 'bck'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Map<String, String> statusMap = {'C': 'Conta', 'I': 'Inativo'};
