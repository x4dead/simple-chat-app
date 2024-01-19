import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color colorBlack = Color(0xff2B333E);
  static const Color color000000 = Color(0xff000000);
  static const Color colorStroke = Color(0xffEDF2F6);
  static const Color colorGray = Color(0xff9DB7CB);
    static const Color colorDarkGray = Color(0xff5E7A90);

  
  static const Color colorWhite = Color(0xffFFFFFF);
  static const Color color00521C = Color(0xff00521C);
  static const Color color3CED78 = Color(0xff3CED78);

  //
  static const LinearGradient colorGreenGradien = LinearGradient(
    colors: [
      Color(0xff1FDB5F),
      Color(0xff31C764),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient colorOrangeGradien = LinearGradient(
    colors: [
      Color(0xffF66700),
      Color(0xffED3900),

// background: linear-gradient(180deg, #F66700 0%, #ED3900 100%);
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient colorBlueGradien = LinearGradient(
    colors: [
      Color(0xff00ACF6),
      Color(0xff006DED),

// background: linear-gradient(180deg, #00ACF6 0%, #006DED 100%);
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const Color colorTransparent = Colors.transparent;
  // static const Color colorGreenAccent = Colors.greenAccent;
  // static const Color colorFFFF = Color.fromARGB(255, 207, 207, 207);
}
