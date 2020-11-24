import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:pickrr_app/src/app.dart';
import 'package:pickrr_app/src/blocs/observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  runApp(App());
}
