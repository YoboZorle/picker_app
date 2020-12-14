import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/services/exceptions.dart';
import 'package:pickrr_app/src/services/http_client.dart';

class RideRepository extends APIClient {
  Response response;

  RideRepository() {
    interceptor('ride');
  }

  processRideOrder(FormData details) async {
    final String url = '/order';
    try {
      Response response = await dio.post(url, data: details);
      return response.data;
    } catch (e) {
      cprint(e.response, errorIn: 'processRideOrder');
      if (e.response.data != null &&
          e.response.data['non_field_errors'] != null) {
        throw ServiceError(e.response.data['non_field_errors'].first);
      }
      throw ServiceError('Request failed please try again.');
    }
  }

  submitRideLocation(FormData details) async {
    final String url = '/ride-location';
    try {
      Response response = await dio.post(url, data: details);
      return response.data;
    } catch (e) {
      cprint(e.response, errorIn: 'submitRideLocation');
      if (e.response.data != null &&
          e.response.data['non_field_errors'] != null) {
        throw ServiceError(e.response.data['non_field_errors'].first);
      }
      throw ServiceError('Request failed please try again.');
    }
  }

  cancelRide(rideId) async {
    final String url = '/order?ride_id=$rideId';
    try {
      await dio.delete(url);
    } catch (e) {
      cprint(e.response, errorIn: 'cancelRide');
      if (e.response.data != null &&
          e.response.data['non_field_errors'] != null) {
        throw ServiceError(e.response.data['non_field_errors'].first);
      }
      throw ServiceError('Request failed please try again.');
    }
  }

  Future<dynamic> getOrders({@required int page}) async {
    final String url = '/orders?page=$page';
    try {
      Response response = await dio.get(url);
      final responseBody = response.data;
      return responseBody;
    } catch (e) {
      throw ServiceError('Request failed please try again.');
    }
  }
}
