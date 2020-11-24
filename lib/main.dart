import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:pickrr_app/src/blocs/observer.dart';
import 'package:pickrr_app/src/screens/onboard.dart';

void main() {
  Bloc.observer = CustomBlocObserver();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Onboard(),
    );
  }
}