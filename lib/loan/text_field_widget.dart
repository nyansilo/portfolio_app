//main imports
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoanTextField extends StatelessWidget {

  final TextEditingController controller;
  final Color cursorColor;
  final TextInputType keyboardType;
  final InputDecoration decoration;
  final TextStyle textStyle;
  final String hintText;


  const LoanTextField(
      {
        Key key,
        @required this.controller,
        this.cursorColor,
        this.keyboardType,
        this.decoration,
        this.textStyle,
        @required this.hintText, TextStyle style,
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  TextField(
      style: textStyle,
      controller: controller,
      cursorColor: cursorColor,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.account_circle,
          color: Colors.grey,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
            color: Color(0xFF9b9b9b),
            fontSize: 15,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
