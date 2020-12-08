import 'package:dio/dio.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
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
      if (e.response.data != null &&
          e.response.data['non_field_errors'] != null) {
        throw ServiceError(e.response.data['non_field_errors'].first);
      }
      throw ServiceError('Request failed please try again.');
    }
  }

  Future getDriverDetails() async {
    final String url = '/user';
    response = await dio.get(url);
    final responseBody = response.data;
    return responseBody;
  }
}
