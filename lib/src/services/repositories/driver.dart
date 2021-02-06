import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:pickrr_app/src/helpers/db/business.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/business.dart';
import 'package:pickrr_app/src/services/exceptions.dart';
import 'package:pickrr_app/src/services/http_client.dart';
import 'package:pickrr_app/src/helpers/db/driver.dart';
import 'package:pickrr_app/src/models/driver.dart';
import 'package:pickrr_app/src/services/repositories/user.dart';

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

  Future getDriverDetailsFromStorage() async {
    Map tokenPayload = await UserRepository().getTokenPayload();
    DriverProvider helper = DriverProvider.instance;
    Driver driver = await helper.getDriver(tokenPayload['userId']);
    if(driver.businessId != null){
      BusinessProvider businessDBHelper = BusinessProvider.instance;
      Business business = await businessDBHelper.getBusiness(driver.businessId);
      driver.setCompany = business;
    }
    return driver;
  }

  Future<void> updateStatus({String status}) async {
    final String url = '/user';
    response = await dio.patch(url, data: {
      'status': status
    });
    final responseBody = response.data;
    await _persistDriverDetails(responseBody);
  }

  Future<void> _persistDriverDetails(rawData) async {
    DriverProvider helper = DriverProvider.instance;
    rawData['id'] = rawData['user']['id'];
    Driver driver = Driver.fromMap(Driver().formatToMap(rawData));
    if(driver.businessId != null){
      Business business = Business.fromMap(driver.company.toMap());
      BusinessProvider businessDBHelper = BusinessProvider.instance;
      await businessDBHelper.updateOrInsert(business);
    }
    await helper.updateOrInsert(driver);
  }

  Future<void> persistDriverDetails(rawData) async {
    await _persistDriverDetails(rawData);
  }

  Future loadDriverDetailsToStorage(userId) async {
    var driverResponse = await getDriverDetails();
    await _persistDriverDetails(driverResponse);
  }

  Future getDriverWalletDetails() async {
    try {
      final String url = '/wallet';
      response = await dio.get(url);
      final responseBody = response.data;
      return responseBody;
    }catch (e) {
      throw ServiceError('Request failed please try again.');
    }
  }

  Future<dynamic> getDriverWalletHistory({@required int page}) async {
    final String url = '/history?page=$page';
    try {
      Response response = await dio.get(url);
      final responseBody = response.data;
      return responseBody;
    } catch (e) {
      throw ServiceError('Request failed please try again.');
    }
  }
}
