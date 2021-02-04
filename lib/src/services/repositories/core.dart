import 'package:dio/dio.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/services/exceptions.dart';
import 'package:pickrr_app/src/services/http_client.dart';

class CoreRepository extends APIClient {
  Response response;

  CoreRepository() {
    interceptor('core');
  }

  getRidePrice(FormData details) async {
    final String url = '/calculate-rideprice';
    try {
      Response response = await dio.post(url, data: details);
      return response.data;
    } catch (e) {
      cprint(e.response, errorIn: 'getRidePrice');
      if (e.response.data != null &&
          e.response.data['non_field_errors'] != null) {
        throw ServiceError(e.response.data['non_field_errors'].first);
      }
      throw ServiceError('Request failed please try again.');
    }
  }
}
