/*
*  radii.dart
*  Pickrr
*
*  Created by Yobo Zorle.
*  Copyright © 2020 Klynox. All rights reserved.
    */

import 'package:flutter/rendering.dart';

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
