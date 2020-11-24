import 'package:intl/intl.dart';
import 'dart:developer' as developer;

void debugLog(dynamic log, {dynamic param = ""}) {
  final String time = DateFormat("mm:ss:mmm").format(DateTime.now());
  print("[$time][Log]: $log, $param");
}

void cprint(dynamic data, {String errorIn}) {
  if (errorIn != null) {
    print(
        '****************************** error ******************************');
    developer.log('[Error]', time: DateTime.now(), error: data.toString(), name: errorIn);
    print(
        '****************************** error ******************************');
  } else if (data != null) {
    developer.log(
      data,
      time: DateTime.now(),
    );
  }
}