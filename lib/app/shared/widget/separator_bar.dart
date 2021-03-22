import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SeparatorBar extends StatelessWidget {
  final String title;
  final double height;
  final double fontSize;
  final FontWeight fontweight;
  final Color color;
  final Alignment alignment;
  SeparatorBar(
      {this.title,
      this.height,
      this.fontSize,
      this.color,
      this.alignment,
      this.fontweight});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      height: height,
      color: color == null ? Colors.grey[200] : color,
      alignment: alignment == null ? Alignment.topLeft : alignment,
      child: title != null
          ? AutoSizeText(
              '$title',
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'Open-sans',
                color: Colors.black,
                fontWeight: font['top'],
                fontSize: fontSize,
              ),
            )
          : Container(),
    );
  }
}

Map<String, FontWeight> font = {
  'top': FontWeight.w400,
  'cen': FontWeight.w400,
  'bot': FontWeight.w400,
};

/* 
Map<String, FontWeight> font = {
  'top': FontWeight.w400,
  'cen': FontWeight.w400,
  'bot': FontWeight.w400,
};
 */
