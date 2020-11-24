import 'package:flutter/material.dart';

class Borders {
  static const BorderSide primaryBorder = BorderSide(
    color: Color.fromARGB(255, 112, 112, 112),
    width: 1,
    style: BorderStyle.solid,
  );
}

class AppColors {
  static const Color primaryBackground = Color.fromARGB(255, 255, 255, 255);
  static const Color secondaryBackground = Color.fromARGB(255, 0, 141, 210);
  static const Color primaryElement = Color.fromARGB(255, 255, 255, 255);
  static const Color primaryText = Color.fromARGB(255, 0, 141, 210);
}

class Radii {
  static const BorderRadiusGeometry k15pxRadius =
      BorderRadius.all(Radius.circular(15));
  static const BorderRadiusGeometry k35pxRadius = BorderRadius.only(
      topRight: Radius.circular(40), topLeft: Radius.circular(40));

  static const BorderRadiusGeometry k25pxRadius = BorderRadius.only(
      topRight: Radius.circular(25),
      topLeft: Radius.circular(25),
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(5));

  static const BorderRadiusGeometry kRoundpxRadius = BorderRadius.only(
      topRight: Radius.circular(25),
      topLeft: Radius.circular(25),
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25));

  static const BorderRadiusGeometry kRoundpxRadius8 = BorderRadius.only(
      topRight: Radius.circular(0),
      topLeft: Radius.circular(0),
      bottomLeft: Radius.circular(0),
      bottomRight: Radius.circular(0));
}

class Shadows {
  static const BoxShadow primaryShadow = BoxShadow(
    color: Color.fromARGB(40, 0, 0, 0),
    offset: Offset(0, 4),
    blurRadius: 25,
  );

  static const BoxShadow primaryShadowTwo = BoxShadow(
    color: Color.fromARGB(46, 0, 0, 0),
    offset: Offset(0, -3),
    blurRadius: 40,
  );

  static const BoxShadow secondaryShadow = BoxShadow(
    color: Colors.grey,
    offset: Offset(-5, 7),
    blurRadius: 8,
  );

  static const BoxShadow secondaryShadow8 = BoxShadow(
    color: Color.fromARGB(8, 0, 0, 0),
    offset: Offset(-8, 8),
    blurRadius: 8,
  );
}

class APIConstants {
  static final String httpUrl = 'http://54.221.222.32';
  static final String wsUrl = 'ws://54.221.222.32';
  static final String assetsUrl = 'https://yarner-storage.s3.amazonaws.com/yarn-a9e77482c84e16/';
  static final String apiUrl = '$httpUrl/api/';
}
