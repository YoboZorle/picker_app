import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:pickrr_app/src/app.dart';
import 'package:pickrr_app/src/blocs/observer.dart';
import 'package:pickrr_app/src/helpers/fcm.dart';
import 'package:pickrr_app/src/helpers/utility.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}
