/*
*  main.dart
*  Pickrr
*
*  Created by Yobo Zorle.
*  Copyright © 2020 Klynox. All rights reserved.
    */

import 'package:flutter/material.dart';

import 'src/home.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Home(),
    );
  }
}