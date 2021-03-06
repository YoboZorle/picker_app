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
        throw ServiceError(e.response.data['non_field_errors']);
      }
      throw ServiceError('Request failed please try again.');
    }
  }

  Future<dynamic> getOrders({@required int page, isUser=1}) async {
    final String url = '/orders?page=$page&is_user=$isUser';
    try {
      Response response = await dio.get(url);
      final responseBody = response.data;
      return responseBody;
    } catch (e) {
      throw ServiceError('Request failed please try again.');
    }
  }

  Future<dynamic> getOrdersForBusiness({@required int page}) async {
    final String url = '/business/orders?page=$page';
    try {
      Response response = await dio.get(url);
      final responseBody = response.data;
      return responseBody;
    } catch (e) {
      throw ServiceError('Request failed please try again.');
    }
  }

  Future<dynamic> getRiderOrders({@required int page}) async {
    final String url = '/rider-history?page=$page';
    try {
      Response response = await dio.get(url);
      final responseBody = response.data;
      return responseBody;
    } catch (e) {
      throw ServiceError('Request failed please try again.');
    }
  }

  processAcceptRide(int rideId) async {
    final String url = '/order/${rideId.toString()}/accept';
    try {
      Response response = await dio.post(url);
      final responseBody = response.data;
      return responseBody;
    } catch (e) {
      cprint(e.response, errorIn: 'processAcceptRide');
      if (e.response.data != null &&
          e.response.data['non_field_errors'] != null) {
        throw ServiceError(e.response.data['non_field_errors']);
      }
      throw ServiceError('Request failed please try again.');
    }
  }

  processPackagePicked(int rideId) async {
    final String url = '/order/$rideId/package-pickedup';
    try {
      Response response = await dio.post(url);
      final responseBody = response.data;
      return responseBody;
    } catch (e) {
      cprint(e.response, errorIn: 'processPackagePicked');
      if (e.response.data != null &&
          e.response.data['non_field_errors'] != null) {
        throw ServiceError(e.response.data['non_field_errors']);
      }
      throw ServiceError('Request failed please try again.');
    }
  }

  processPackageDelivered(int rideId) async {
    final String url = '/order/$rideId/package-delivered';
    try {
      Response response = await dio.post(url);
      print(response);
      final responseBody = response.data;
      return responseBody;
    } catch (e) {
      cprint(e.response, errorIn: 'processPackageDelivered');
      if (e.response.data != null &&
          e.response.data['non_field_errors'] != null) {
        throw ServiceError(e.response.data['non_field_errors']);
      }
      throw ServiceError('Request failed please try again.');
    }
  }

  processPackagePickedForRider(int rideId) async {
    final String url = '/order/business/$rideId/package-pickedup';
    try {
      Response response = await dio.post(url);
      final responseBody = response.data;
      return responseBody;
    } catch (e) {
      cprint(e.response, errorIn: 'processPackagePickedForRider');
      if (e.response.data != null &&
          e.response.data['non_field_errors'] != null) {
        throw ServiceError(e.response.data['non_field_errors']);
      }
      throw ServiceError('Request failed please try again.');
    }
  }

  processPackageDeliveredForRider(int rideId) async {
    final String url = '/order/business/$rideId/package-delivered';
    try {
      Response response = await dio.post(url);
      print(response);
      final responseBody = response.data;
      return responseBody;
    } catch (e) {
      cprint(e.response, errorIn: 'processPackageDeliveredForRider');
      if (e.response.data != null &&
          e.response.data['non_field_errors'] != null) {
        throw ServiceError(e.response.data['non_field_errors']);
      }
      throw ServiceError('Request failed please try again.');
    }
  }

  getRideDetails(int rideId) async {
    final String url = '/$rideId/ride-details';
    try {
      Response response = await dio.get(url);
      final responseBody = response.data;
      return responseBody;
    } catch (e) {
      cprint(e.response, errorIn: 'getRideDetails');
      if (e.response.data != null &&
          e.response.data['non_field_errors'] != null) {
        throw ServiceError(e.response.data['non_field_errors']);
      }
      throw ServiceError('Request failed please try again.');
    }
  }

  trackRide(String rideId) async {
    final String url = '/track/$rideId';
    try {
      Response response = await dio.get(url);
      final responseBody = response.data;
      return responseBody;
    } catch (e) {
      cprint(e.response, errorIn: 'trackRide');
      if(e.response.statusCode == 404){
        throw NotFoundError();
      }
      if (e.response.data != null &&
          e.response.data['non_field_errors'] != null) {
        throw ServiceError(e.response.data['non_field_errors']);
      }
      throw ServiceError('Request failed please try again.');
    }
  }

  getActiveRide() async {
    final String url = '/active-ride';
    try {
      Response response = await dio.get(url);
      final responseBody = response.data;
      return responseBody;
    } catch (e) {
      throw ServiceError('Request failed please try again.');
    }
  }

  submitRideRating(FormData details, int rideId) async {
    final String url = '/$rideId/rating';
    try {
      Response response = await dio.post(url, data: details);
      return response.data;
    } catch (e) {
      cprint(e.response, errorIn: 'submitRideRating');
      if (e.response.data != null &&
          e.response.data['non_field_errors'] != null) {
        throw ServiceError(e.response.data['non_field_errors'].first);
      }
      throw ServiceError('Request failed please try again.');
    }
  }
}
