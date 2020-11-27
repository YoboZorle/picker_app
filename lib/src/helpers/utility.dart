import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:pickrr_app/src/helpers/db/user.dart';
import 'dart:developer' as developer;

import 'package:pickrr_app/src/models/user.dart';

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
    if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
      debugLog('Internet available');
      return true;
    }
    debugLog('no internet connection');
    return false;
  } on SocketException catch(_) {
    debugLog('no internet connection');
    return false;
  }
}

/// Persist user details in Sqflite for easy accessibility
Future<void> persistUserDetails(User user) async {
  UserProvider helper = UserProvider.instance;
  await helper.updateOrInsert(user);
}
