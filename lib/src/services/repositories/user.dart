import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

// import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/db/user.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/services/exceptions.dart';
import 'package:pickrr_app/src/services/http_client.dart';

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
    // final String url = '/$userId';

    try {
      return new Future.delayed(new Duration(seconds: 5), () {
        return {
          'userId': 2,
          'fullname': 'John',
          'phone': '0903383383',
          'callingCode': '234'
        };
      });
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
    // var formData = {'phone': phone, 'calling_code': callingCode};
    // final String url = '${APIConstants.apiUrl}users/obtain-otp';

    try {
      // return await dio.post(url, data: formData);
      return new Future.delayed(new Duration(seconds: 5), () {
        debugLog('Requesting OTP');
      });
    } catch (e) {
      throw ServiceError(e);
    }
  }

  otpVerification(
      {@required otp,
      @required phone,
      @required String callingCode,
      @required String deviceToken}) async {
    // var formData = {
    //   'otp': otp,
    //   'phone': phone,
    //   'calling_code': callingCode,
    //   'device_token': deviceToken
    // };
    // final String url = '${APIConstants.apiUrl}users/obtain-jwt';

    try {
      // response = await dio.post(url, data: formData);
      // final responseBody = response.data;
      // await this.persistToken(responseBody['token']);
      var jwtToken =
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MTk0Njc2MDgsInVzZXJJZCI6MiwicGhvbmUiOiIwOTA5NDczODM4MyIsImZ1bGxuYW1lIjoiSmFjayBNYSIsInByb2ZpbGVJbWFnZVVybCI6Imh0dHBzOi8vaW1hZ2VzLnVuc3BsYXNoLmNvbS9waG90by0xNTYzMTIyODcwLTZiMGI0OGEwYWYwOT9peGxpYj1yYi0xLjIuMSZpeGlkPWV5SmhjSEJmYVdRaU9qRXlNRGQ5JmF1dG89Zm9ybWF0JmZpdD1jcm9wJnc9MTAwMCZxPTgwIn0.ydIU_gJJIa5BOAdipafAzi3-D8sDPoEWbxGi1d9RD5s';
      await this.persistToken(jwtToken);
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
    // final String url = '/';

    try {
      // response = await dio.patch(url, data: details);
      // return response.data;
      return new Future.delayed(new Duration(seconds: 5), () {
        debugLog('Updating profile details...');
        var profileDetails = {
          'userId': 2,
          'fullname': 'James Tom',
          'email': 'jt@gmail.com',
          'phone': '09038373923'
        };
        User user = User.fromMap(profileDetails);
        persistUserDetails(user);
        return profileDetails;
      });
    } catch (e) {
      cprint(e, errorIn: 'updateProfileDetails');
      throw ServiceError(e);
    }
  }
}
