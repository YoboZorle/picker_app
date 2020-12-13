import 'dart:convert';
import 'dart:io';
import 'dart:math' show cos, sqrt, asin;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/db/user.dart';
import 'dart:developer' as developer;

import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/services/repositories/ride.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';

void debugLog(dynamic log, {dynamic param = ""}) {
  final String time = DateFormat("mm:ss:mmm").format(DateTime.now());
  print("[$time][Log]: $log, $param");
}

void cprint(dynamic data, {String errorIn}) {
  if (errorIn != null) {
    print(
        '****************************** error ******************************');
    developer.log('[Error]',
        time: DateTime.now(), error: data.toString(), name: errorIn);
    print(
        '****************************** error ******************************');
  } else if (data != null) {
    developer.log(
      data,
      time: DateTime.now(),
    );
  }
}

class Token {
  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}

/// Checks for internet connection by pinging `google.com`
Future<bool> isInternetConnected() async {
  debugLog('Checking internet connectivity...');
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      debugLog('Internet available');
      return true;
    }
    debugLog('no internet connection');
    return false;
  } on SocketException catch (_) {
    debugLog('no internet connection');
    return false;
  }
}

/// Persist user details in Sqflite for easy accessibility
Future<void> persistUserDetails(User user) async {
  UserProvider helper = UserProvider.instance;
  await helper.updateOrInsert(user);
}

String getdob(String date) {
  if (date == null || date.isEmpty) {
    return '';
  }
  var dt = DateTime.parse(date).toLocal();
  var dat = DateFormat.yMMMd().format(dt);
  return dat;
}

double priceCalculator(double distance) {
  int distanceCovered = distance < 1 ? 1 : distance.round();
  final double flatRate = 300;
  final double perKmCharge = 70;
  double price = 0;

  price = flatRate;
  if (distanceCovered > 4) price += (perKmCharge * (distanceCovered - 4));
  return price;
}

Widget flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}

double coordinateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

void cancelRide(BuildContext context, rideId) async {
  AlertBar.dialog(context, 'Requesting...', AppColor.primaryText,
      showProgressIndicator: true, duration: null);
  try {
    await RideRepository().cancelRide(rideId);
    Navigator.pushNamedAndRemoveUntil(context, '/HomePage', (route) => false);
  } catch (err) {
    Navigator.pop(context);
    debugLog(err);
  }
}
