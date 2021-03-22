import 'package:auto_size_text/auto_size_text.dart';
import 'package:controlmoney/app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomLoadButton extends StatefulWidget {
  final bool loading;
  final Function onPressed;
  final String txt;
  final double width;

  const CustomLoadButton(
      {Key key, this.loading, this.onPressed, this.txt, this.width})
      : super(key: key);
  @override
  _CustomLoadButtonState createState() => _CustomLoadButtonState();
}

class _CustomLoadButtonState extends State<CustomLoadButton> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: widget.width != null ? widget.width : width,
      height: widget.width != null ? width * .13 : width * .14,
      // ignore: deprecated_member_use
      child: RaisedButton(
          elevation: 5,
          onPressed: widget.loading
              ? () {}
              : () {
                  setState(() {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    currentFocus.unfocus();
                    widget.onPressed();
                  });
                },
          child: widget.loading
              ? CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white))
              : AutoSizeText(widget.txt,
                  presetFontSizes: [18, 16, 14, 9],
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
          color: AppColors.primary),
    );
  }
}
