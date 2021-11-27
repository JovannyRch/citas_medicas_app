import 'package:citas_medicas_app/const/const.dart';
import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  static Size _size = const Size(0, 0);

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(kMainColor),
      ),
    );
  }

  static Widget expanded(Size size) {
    return SizedBox(
      height: _size.height * 0.9,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kMainColor),
        ),
      ),
    );
  }
}
