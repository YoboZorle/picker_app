import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:pickrr_app/src/helpers/constants.dart';

class APIClient {
  final _storage = new FlutterSecureStorage();
  final Dio dio = Dio();

  Future<Dio> interceptor(String baseUrl) async {
    dio.interceptors.clear();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      String jwtToken = await _storage.read(key: 'accessToken') ?? '';
      if (jwtToken.isNotEmpty) {
        options.headers["Authorization"] = "Bearer " + jwtToken;
      }
      return options;
    }, onResponse: (Response response) async {
      return response;
    }, onError: (DioError e) async {
      if (e.response.statusCode == 401) {
        await signOutFromDevice();
      }
      return e;
    }));
    dio.options.baseUrl = '${APIConstants.apiUrl}$baseUrl';
    return dio;
  }

  /// This methods first checks for the user token is it exists, then if it does
  /// - it deletes the tokens from local storage
  Future<void> signOutFromDevice() async {
    String value = await _storage.read(key: 'accessToken');
    if (value != null && value.isNotEmpty) {
      await _storage.delete(key: 'accessToken');
    }
  }
}