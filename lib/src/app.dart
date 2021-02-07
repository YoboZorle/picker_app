import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickrr_app/src/helpers/routes.dart';
import 'package:pickrr_app/src/helpers/utility.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  cprint("wdup onBackgroundMessage __________________________________________");
  cprint(message);
  cprint("Eended here#######################################");
}


class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    _firebaseMessaging.configure(
      onMessage: (message) async{
        cprint("onMessage: $message");
        cprint("wdup onMessage __________________________________________");
        cprint(message);
        cprint("Eended here#######################################");
      },
        onBackgroundMessage: myBackgroundMessageHandler,
        onLaunch: (Map<String, dynamic> message) async {
          cprint("onLaunch: $message");
          cprint("wdup onMessage __________________________________________");
          cprint(message);
          cprint("Eended here #######################################");
        },
      onResume: (message) async{
        cprint("onResume: $message");
        cprint("wdup onResume __________________________________________");
        // cprint(message);
        cprint("Eended here #######################################");
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: Routes.route(),
        onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
        onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
        initialRoute: "/");
  }
}
