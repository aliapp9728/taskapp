import 'package:flutter/cupertino.dart';

class MyMediaQuery {
  static double getScreenHieght(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
