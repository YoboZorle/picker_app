import 'package:flutter/material.dart';

class Borders {
  static final BorderSide primaryBorder = BorderSide(
    color: Color.fromARGB(255, 112, 112, 112),
    width: 1,
    style: BorderStyle.solid,
  );

  static final BorderSide globalSearchBorder = BorderSide(
    color: Color.fromARGB(70, 0, 141, 210),
    width: 0.4,
    style: BorderStyle.solid,
  );
}

class AppColor {
  static final Color primaryBackground = Color.fromARGB(255, 255, 255, 255);
  static final Color secondaryBackground = Color.fromARGB(255, 0, 141, 210);
  static final Color primaryElement = Color.fromARGB(255, 255, 255, 255);
  static final Color primaryText = Color.fromARGB(255, 0, 141, 210);
  static final grey = Color(0xFF959595);
}

class Radii {
  static final BorderRadiusGeometry k15pxRadius =
      BorderRadius.all(Radius.circular(15));
  static final BorderRadiusGeometry k35pxRadius = BorderRadius.only(
      topRight: Radius.circular(40), topLeft: Radius.circular(40));

  static final BorderRadiusGeometry k25pxRadius = BorderRadius.only(
      topRight: Radius.circular(25),
      topLeft: Radius.circular(25),
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(5));

  static final BorderRadiusGeometry k25pxAll = BorderRadius.only(
      topRight: Radius.circular(25),
      topLeft: Radius.circular(25),
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25));

  static final BorderRadiusGeometry kRoundpxRadius = BorderRadius.only(
      topRight: Radius.circular(25),
      topLeft: Radius.circular(25),
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25));

  static final BorderRadiusGeometry kRoundpxRadius8 = BorderRadius.only(
      topRight: Radius.circular(0),
      topLeft: Radius.circular(0),
      bottomLeft: Radius.circular(0),
      bottomRight: Radius.circular(0));
}

class Shadows {
  static final BoxShadow primaryShadow = BoxShadow(
    color: Color.fromARGB(40, 0, 0, 0),
    offset: Offset(0, 4),
    blurRadius: 25,
  );

  static final BoxShadow primaryShadowTwo = BoxShadow(
    color: Color.fromARGB(46, 0, 0, 0),
    offset: Offset(0, -3),
    blurRadius: 40,
  );

  static final BoxShadow secondaryShadow = BoxShadow(
    color: Colors.grey,
    offset: Offset(-5, 7),
    blurRadius: 8,
  );

  static final BoxShadow secondaryShadow8 = BoxShadow(
    color:  Color.fromARGB(8, 0, 0, 0),
    offset: Offset(-8, 8),
    blurRadius: 8,
  );

  static final BoxShadow globalShadowSearch = BoxShadow(
    color: Color.fromARGB(65, 134, 134, 134),
    offset: Offset(6, 6),
    blurRadius: 10,
  );
}

class APIConstants {
  static final String httpUrl = 'http://192.168.21.114:8000';
  static final String wsUrl = 'ws://192.168.21.114:8000';
  static final String assetsUrl = 'https://yarner-storage.s3.amazonaws.com/yarn-a9e77482c84e16/';
  static final String apiUrl = '$httpUrl/api/';
}

class AppData {
  static final String messageFrom = 'Yarner';
  static final String mapAPIKey = 'AIzaSyAPV3djPp_HceZIbgK4M4jRadHA-d08ECg';
  static final String placeholderImageUrl = '';
}

