import 'package:dio/dio.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/services/exceptions.dart';
import 'package:pickrr_app/src/services/http_client.dart';

class BusinessRepository extends APIClient {
  Response response;

  BusinessRepository() {
    interceptor('drivers');
  }

  applicationRequest(FormData details) async {
    final String url = '/business/application';

    try {
      await dio.post(url, data: details);
    } catch (e) {
      cprint(e.response, errorIn: 'applicationRequest');
      if (e.response.data != null &&
          e.response.data['non_field_errors'] != null) {
        throw ServiceError(e.response.data['non_field_errors'].first);
      }
      throw ServiceError('Request failed please try again.');
    }
  }

  createPin(FormData details) async {
    final String url = '/business/details';

    try {
      await dio.patch(url, data: details);
    } catch (err) {
      cprint(err.response, errorIn: 'createPin');
      if (err.response.data != null &&
          err.response.data['non_field_errors'] != null) {
        throw ServiceError(err.response.data['non_field_errors'].first);
      }
      throw ServiceError('Request failed, please try again.');
    }
  }

  verifyPin(FormData details) async {
    final String url = '/business/verify-pin';

    try {
      response = await dio.post(url, data: details);
      final responseBody = response.data;
      return responseBody;
    } catch (err) {
      cprint(err.response, errorIn: 'verifyPin');
      if (err.response.data != null &&
          err.response.data['non_field_errors'] != null) {
        throw ServiceError(err.response.data['non_field_errors'].first);
      }
      throw ServiceError('Request failed, please try again.');
    }
  }

  forgotPin() async {
    final String url = '/business/forgot-pin';

    try {
      response = await dio.post(url);
      final responseBody = response.data;
      return responseBody;
    } catch (err) {
      cprint(err.response, errorIn: 'verifyPin');
      if (err.response.data != null &&
          err.response.data['non_field_errors'] != null) {
        throw ServiceError(err.response.data['non_field_errors'].first);
      }
      throw ServiceError('Request failed, please try again.');
    }
  }
}
