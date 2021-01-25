import 'package:firebase_messaging/firebase_messaging.dart';

class FCM {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static Function messageHandler;

  Future initFCM(Function handler) {
    messageHandler = handler;
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {});

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {},
      onLaunch: (Map<String, dynamic> message) async {
        messageHandler(message);
      },
      onResume: (Map<String, dynamic> message) async {
        messageHandler(message);
      },
    );
  }
}
