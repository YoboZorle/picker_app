import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/db/user.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/services/exceptions.dart';
import 'package:pickrr_app/src/services/http_client.dart';

class DriverRepository extends APIClient {
  Response response;

  DriverRepository() {
    interceptor('drivers');
  }

  driverRequest(FormData details) async {
    final String url = '/application';

    try {
      await dio.post(url, data: details);
    } catch (e) {
      cprint(e.response, errorIn: 'driverRequest');
      throw ServiceError(e);
    }
  }
}
