import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class AlertBar {
  static Flushbar<dynamic> dialog(context, text, Color color,
      {Widget icon, duration = 5, bool showProgressIndicator = false}) {
    return Flushbar(
      isDismissible: false,
      message: text,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      icon: icon,
      duration: duration == null ? null : Duration(seconds: duration),
      leftBarIndicatorColor: color,
      showProgressIndicator: showProgressIndicator,
    )..show(context);
  }
}
