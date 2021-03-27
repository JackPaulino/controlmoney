import 'package:flutter/material.dart';

Future<void> customDialog(context,
    {Widget title,
    Widget content,
    Color color = Colors.white,
    List<Widget> buttons,
    bool barrierDismissible = true}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title,
        backgroundColor: color,
        content: SingleChildScrollView(child: content),
        actions: buttons,
      );
    },
  );
}
