import 'package:flutter/material.dart';

Future<void> customDialog(context,
    {Widget content,
    List<Widget> buttons,
    bool barrierDismissible = true}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(child: content),
        actions: buttons,
      );
    },
  );
}
