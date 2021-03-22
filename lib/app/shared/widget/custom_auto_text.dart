import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CustomText extends StatelessWidget {
  final String title;
  final String test;
  final String fontSize;
  final String align;
  final String corl;

  const CustomText(
      {Key key, this.title, this.test, this.fontSize, this.align, this.corl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText.rich(
      TextSpan(
          text: title != null ? '$title: ' : '',
          style: TextStyle(fontWeight: FontWeight.bold, color: cor[corl]),
          children: [
            TextSpan(
                text: '$test', style: TextStyle(fontWeight: FontWeight.normal)),
          ]),
      maxLines: 2,
      presetFontSizes: presetFontSizes[fontSize],
      textAlign: textAlign[align],
    );
  }
}

Map<String, List<double>> presetFontSizes = {
  'top': [19, 16, 12],
  'cen': [16, 12, 10],
  'bot': [14, 12, 10],
};

Map<String, TextAlign> textAlign = {
  'str': TextAlign.start,
  'cen': TextAlign.center,
  'end': TextAlign.end,
};

Map<String, Color> cor = {
  'bck': Colors.black,
  'wht': Colors.white,
};
