// ignore_for_file: invalid_required_named_param

import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Color color;
  // ignore: use_key_in_widget_constructors
  const TitleWidget(
      {@required this.title = "", @required this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return _title(title, color);
  }

  Widget _title(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
