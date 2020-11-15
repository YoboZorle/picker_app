/*
*  shadows.dart
*  Pickrr
*
*  Created by Yobo Zorle.
*  Copyright © 2020 Klynox. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class Shadows {
  static const BoxShadow primaryShadow = BoxShadow(
    color: Color.fromARGB(41, 0, 0, 0),
    offset: Offset(0, 8),
    blurRadius: 12,
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
    color:  Color.fromARGB(30, 0, 0, 0),
    offset: Offset(-8, 20),
    blurRadius: 15,
  );
}