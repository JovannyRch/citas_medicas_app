import 'package:citas_medicas_app/const/const.dart';

import 'package:flutter/material.dart';

Widget AppTitle(text) {
  return Text(
    text,
    style: TextStyle(
      color: kMainColor,
      fontWeight: FontWeight.w700,
      fontSize: 24.0,
    ),
  );
}

Widget AppSubtitle(text) {
  return Text(
    text,
    style: TextStyle(
      color: kMainColor,
      fontWeight: FontWeight.w600,
      fontSize: 19.0,
    ),
  );
}

Widget AppCaption(String text) {
  return Text(
    text,
    style: TextStyle(
      color: kMainColor,
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
    ),
  );
}

Widget AppCaptionValue(String text) {
  return Text(
    text,
    style: TextStyle(
      color: kMainColor,
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
    ),
  );
}

Widget AppButton(
  String text,
  Function f, {
  bool disable = false,
}) {
  return ElevatedButton(
    onPressed: disable
        ? null
        : () {
            f();
          },
    child: disable ? const CircularProgressIndicator() : Text(text),
    style: ElevatedButton.styleFrom(
      shape: StadiumBorder(),
      primary: kSecondaryColor,
    ),
  );
}

Widget InputApp(String text, IconData icon,
    {bool isPassword = false,
    bool isNumber = false,
    required TextEditingController controller}) {
  return Container(
    margin: EdgeInsets.only(bottom: 14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: kMainColor,
        ),
        labelText: text,
        labelStyle: TextStyle(
          color: kMainColor,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kMainColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kMainColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: kMainColor),
        ),
      ),
    ),
  );
}
