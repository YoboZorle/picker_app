import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/db/user.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/services/exceptions.dart';
import 'package:pickrr_app/src/services/http_client.dart';
import 'package:pickrr_app/src/services/repositories/driver.dart';

class UserRepository extends APIClient {
  final _storage = new FlutterSecureStorage();
  Response response;

  UserRepository() {
    interceptor('users');
  }

  Future<bool> isSignedIn() async {
    try {
      Map tokenPayload = await getTokenPayload();
      var tokenExp =
          new DateTime.fromMillisecondsSinceEpoch(tokenPayload['exp'] * 1000);
      var currentTime = new DateTime.now();

      if (tokenExp.compareTo(currentTime) == 1) {
        return true;
      } else {
        await signOutFromDevice();
        return false;
      }
    } on InvalidAuthentication {
      return false;
    }
  }

  getTokenPayload() async {
    final String accessToken = await _storage.read(key: 'accessToken') ?? '';
    if (accessToken.isEmpty) throw InvalidAuthentication();
    try {
      var tokenData = Token().parseJwt(accessToken);
      return tokenData;
    } catch (err) {
      cprint(err, errorIn: 'getTokenPayload');
      throw InvalidAuthentication();
    }
  }

  Future<void> persistToken(String accessToken) async {
    if (accessToken != null && accessToken.isNotEmpty) {
      await signOutFromDevice();
      await _storage.write(key: 'accessToken', value: accessToken);
      User user = User.fromMap(await getTokenPayload());
      await persistUserDetails(user);
    }
  }

  getUserDetails(userId) async {
    final String url = '/$userId';

    try {
      response = await dio.get(url);
      final responseBody = response.data;
      if (responseBody['is_driver']) {
        await DriverRepository().loadDriverDetailsToStorage(userId);
      }
      return responseBody;
    } catch (e) {
      throw ServiceError(e);
    }
  }

  Future<User> getUser() async {
    Map tokenPayload = await getTokenPayload();
    UserProvider helper = UserProvider.instance;
    User user = await helper.getUser(tokenPayload['userId']);
    return user != null ? user : User.fromMap(tokenPayload['userId']);
  }

  Future<void> requestOTP(
      {@required phone, @required String callingCode}) async {
    var formData = {'phone': phone, 'calling_code': callingCode};
    final String url = '${APIConstants.apiUrl}users/obtain-otp';

    try {
      response = await dio.post(url, data: formData);
      final responseBody = response.data;
      await this.persistToken(responseBody['access']);
    } catch (e) {
      print(e);
      throw ServiceError(e);
    }
  }

  otpVerification(
      {@required otp, @required phone, @required String callingCode}) async {
    var formData = {'otp': otp, 'phone': phone, 'calling_code': callingCode};
    final String url = '${APIConstants.apiUrl}users/token/obtain';

    try {
      response = await dio.post(url, data: formData);
      final responseBody = response.data;
      await this.persistToken(responseBody['access']);
    } catch (e) {
      cprint(e, errorIn: 'otpVerification');
      if (e.response != null) {
        if (e.response.data != null &&
            e.response.data['non_field_errors'] != null) {
          throw ServiceError(e.response.data['non_field_errors'].first);
        }
      }
      throw ServiceError('Request failed please try again.');
    }
  }

  updateProfileDetails(FormData details) async {
    Map tokenPayload = await getTokenPayload();
    final String url = '/${tokenPayload['userId']}';

    try {
      response = await dio.patch(url, data: details);
      User user = User.fromMap(response.data);
      persistUserDetails(user);
    } catch (e) {
      print(e);
      cprint(e, errorIn: 'updateProfileDetails');
      throw ServiceError(e);
    }
  }
}
