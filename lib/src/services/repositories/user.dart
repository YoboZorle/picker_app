import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  Future<void> persistToken(String accessToken, String refreshToken) async {
    if (accessToken != null && accessToken.isNotEmpty) {
      await signOutFromDevice();
      await _storage.write(key: 'accessToken', value: accessToken);
    }
  }

  getUserDetails(userId) async {
    final String url = '/$userId';

    try {
      return new Future.delayed(new Duration(seconds: 5), () {
        return {
          'firstname': 'John',
          'lastname': 'Nathaniel',
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
    return await helper.getUser(tokenPayload['userId']);
  }
}
