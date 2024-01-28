import 'package:flutter/material.dart';

class ScreenUtil {
  static double sh = 0;
  static double sw = 0;

  ScreenUtil(BuildContext context) {
    sh = MediaQuery.of(context).size.height;
    sw = MediaQuery.of(context).size.width;
  }
}
