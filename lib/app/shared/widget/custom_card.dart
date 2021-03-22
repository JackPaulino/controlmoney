import 'package:controlmoney/app/shared/models/card_model.dart';
import 'package:controlmoney/app/shared/ultils/custom_format.dart';
import 'package:flutter/material.dart';

import 'custom_auto_text.dart';

class CustomCard extends StatelessWidget {
  final CardModel card;

  const CustomCard({Key key, this.card}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[50],
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Icon(Icons.credit_card_outlined,
                          size: 35, color: Color(int.parse('0xff${card.cor}'))),
                      SizedBox(width: 5),
                      CustomText(
                          test: '${card.name}', fontSize: 'top', corl: 'bck'),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          title: 'Dt. Fech',
                          test: 'Dia ${card.closure}',
                          fontSize: 'bot',
                          corl: 'bck'),
                      SizedBox(height: 7),
                      CustomText(
                          title: 'Dt. Venc',
                          test: 'Dia ${card.maturity}',
                          fontSize: 'bot',
                          corl: 'bck'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 7),
            Row(
              children: [
                Expanded(
                  child: CustomText(
                      title: 'Limite',
                      test: Appformat.moneyR$.format(card.limite),
                      fontSize: 'cen',
                      align: 'str',
                      corl: 'bck'),
                ),
                Expanded(
                  child: CustomText(
                      title: 'Saldo',
                      test: Appformat.moneyR$.format(card.saldo ?? 0.0),
                      fontSize: 'cen',
                      align: 'str',
                      corl: 'bck'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
