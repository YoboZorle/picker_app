import 'package:dio/dio.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
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
    return driver;
  }

  Future loadDriverDetailsToStorage(userId) async {
    var driverResponse = await getDriverDetails();
    DriverProvider helper = DriverProvider.instance;
    Map<String, dynamic> driverDetails = {
      'id': userId,
      'plateNumber': driverResponse['plate_number'],
      'ticketNumber': driverResponse['ticket_number'],
      'companyName': driverResponse['company_name'],
      'status': driverResponse['status'],
      'blocked': driverResponse['blocked'],
      'createdAt': driverResponse['created_at'],
    };
    Driver driver = Driver.fromMap(driverDetails);
    await helper.updateOrInsert(driver);
  }
}
