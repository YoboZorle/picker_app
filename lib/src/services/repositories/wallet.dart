import 'package:dio/dio.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/services/exceptions.dart';
import 'package:pickrr_app/src/services/http_client.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';

class WalletRepository extends APIClient {
  Response response;

  WalletRepository() {
    interceptor('wallet');
  }

  Future<dynamic> getBanks() async {
    final String url = '/banks';
    try {
      Response response = await dio.get(url);
      final responseBody = response.data;
      return responseBody;
    } catch (e) {
      throw ServiceError('Request failed please try again.');
    }
  }

  Future<dynamic> withdrawFromBank(FormData details) async {
    final String url = '/withdrawal/business';

    try {
      response = await dio.post(url, data: details);
      final responseBody = response.data;
      await BusinessRepository().persistBusinessDetails(responseBody);
      return responseBody;
    } catch (err) {
      cprint(err.response, errorIn: 'withdrawFromBank');
      if (err.response.data != null &&
          err.response.data['non_field_errors'] != null) {
        throw ServiceError(err.response.data['non_field_errors'].first);
      }
      throw ServiceError('Request failed, please try again.');
    }
  }

  Future<dynamic> withdrawFromDriver(FormData details) async {
    final String url = '/withdrawal/driver';

    try {
      response = await dio.post(url, data: details);
      final responseBody = response.data;
      return responseBody;
    } catch (err) {
      cprint(err.response, errorIn: 'withdrawFromDriver');
      if (err.response.data != null &&
          err.response.data['non_field_errors'] != null) {
        throw ServiceError(err.response.data['non_field_errors'].first);
      }
      throw ServiceError('Request failed, please try again.');
    }
  }

  Future<dynamic> initiateTransaction(FormData details) async {
    final String url = '/initiate-transaction';

    try {
      response = await dio.post(url, data: details);
      final responseBody = response.data;
      return responseBody;
    } catch (err) {
      cprint(err.response, errorIn: 'initiateTransaction');
      if (err.response.data != null &&
          err.response.data['non_field_errors'] != null) {
        throw ServiceError(err.response.data['non_field_errors'].first);
      }
      throw ServiceError('Request failed, please try again.');
    }
  }

  Future<void> settleBusinessDebt(FormData details) async {
    final String url = '/settle-business-debt';

    try {
      response = await dio.post(url, data: details);
      final responseBody = response.data;
      await BusinessRepository().persistBusinessDetails(responseBody);
    } catch (err) {
      cprint(err.response, errorIn: 'settleBusinessDebt');
      if (err.response.data != null &&
          err.response.data['non_field_errors'] != null) {
        throw ServiceError(err.response.data['non_field_errors'].first);
      }
      throw ServiceError('Request failed, please try again.');
    }
  }

  Future<void> settleDriverDebt(FormData details) async {
    final String url = '/settle-driver-debt';

    try {
      response = await dio.post(url, data: details);
      final responseBody = response.data;
      return responseBody;
    } catch (err) {
      cprint(err.response, errorIn: 'settleDriverDebt');
      if (err.response.data != null &&
          err.response.data['non_field_errors'] != null) {
        throw ServiceError(err.response.data['non_field_errors'].first);
      }
      throw ServiceError('Request failed, please try again.');
    }
  }
}
