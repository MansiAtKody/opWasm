import 'package:dio/dio.dart';
import 'package:kody_operator/framework/utility/session.dart';
export 'package:kody_operator/framework/dependency_injection/inject.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio);

  /*
  * ----GET Request
  * */
  Future<dynamic> getRequest(String endPoint) async {
    try {
      ///Basic Headers
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'contentType': 'application/json',
        'Accept-Language': Session.getAppLanguage(),
      };

      ///Authorization Header
      String token = Session.getUserAccessToken();
      if (token.isNotEmpty) {
        headers.addAll(
            {'Authorization': 'Bearer ${Session.getUserAccessToken()}'});
      }

      _dio.options.headers = headers;
      return await _dio.get(endPoint);
    } catch (e) {
      rethrow;
    }
  }

  /*
  * ----POST Request
  * */
  Future<dynamic> postRequest(String endPoint, String request, {bool noAuth = false}) async {
    try {
      ///Basic Headers

      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'contentType': 'application/json',
      };

      ///Authorization Header
      String token = Session.getUserAccessToken();
      if (token.isNotEmpty && !noAuth) {
        headers.addAll(
            {'Authorization': 'Bearer ${Session.getUserAccessToken()}'});
      }

      _dio.options.headers = headers;

      return await _dio.post(endPoint, data: request);
    } catch (e) {
      rethrow;
    }
  }

  /*
  * ----POST Request FormData
  * */
  Future<dynamic> postRequestFormData(
      String endPoint, FormData requestBody) async {
    try {
      ///Basic Headers
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'contentType': 'application/json',
        'Accept-Language': Session.getAppLanguage(),
      };

      ///Authorization Header
      String token = Session.getUserAccessToken();
      if (token.isNotEmpty) {
        headers.addAll(
            {'Authorization': 'Bearer ${Session.getUserAccessToken()}'});
      }
      _dio.options.headers = headers;

      return await _dio.post(endPoint, data: requestBody);
    } catch (e) {
      rethrow;
    }
  }

  /*
  * ----PUT Request
  * */
  Future<dynamic> putRequest(String endPoint, String request) async {
    try {
      ///Basic Headers
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'contentType': 'application/json',
        'Accept-Language': Session.getAppLanguage(),
      };

      ///Authorization Header
      String token = Session.getUserAccessToken();
      if (token.isNotEmpty) {
        headers.addAll(
            {'Authorization': 'Bearer ${Session.getUserAccessToken()}'});
      }

      _dio.options.headers = headers;
      return await _dio.put(endPoint, data: request);
    } catch (e) {
      rethrow;
    }
  }

  /*
  * ----PUT Request FormData
  * */
  Future<dynamic> putRequestFormData(
      String endPoint, FormData requestBody) async {
    try {
      ///Basic Headers
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'contentType': 'application/json',
        'Accept-Language': Session.getAppLanguage(),
      };

      ///Authorization Header
      String token = Session.getUserAccessToken();
      if (token.isNotEmpty) {
        headers.addAll(
            {'Authorization': 'Bearer ${Session.getUserAccessToken()}'});
      }

      _dio.options.headers = headers;
      return await _dio.put(endPoint, data: requestBody);
    } catch (e) {
      rethrow;
    }
  }

  /*
  * ----DELETE Request
  * */
  Future<dynamic> deleteRequest(
      String endPoint, String requestBody) async {
    try {
      ///Basic Headers
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'contentType': 'application/json',
        'Accept-Language': Session.getAppLanguage(),
      };

      ///Authorization Header
      String token = Session.getUserAccessToken();
      if (token.isNotEmpty) {
        headers.addAll(
            {'Authorization': 'Bearer ${Session.getUserAccessToken()}'});
      }

      _dio.options.headers = headers;
      return await _dio.delete(endPoint, data: requestBody);
    } catch (e) {
      rethrow;
    }
  }

  /*
  * ----PUT Request SDK APIs
  * */
  Future<dynamic> putRequestSDKApis(String endPoint, String request) async {
    try {
      ///Basic Headers
      Map<String, dynamic> headers = {
        'Accept': 'application/vnd.bsh.sdk.v1+json',
        'contentType': 'application/vnd.bsh.sdk.v1+json',
        'Accept-Language': Session.getAppLanguage(),
      };

      ///Authorization Header
      String token = Session.getCoffeeAccessToken();
      if (token.isNotEmpty) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }

      _dio.options.headers = headers;
      return await _dio.put(endPoint, data: request);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> roboticArmApi(String endPoint) async {
    try {
      // _dio.options.headers = headers;
      return await _dio.get(
        'http://192.168.1.17:5000/$endPoint',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> refreshToken() async {
    try {
      ///Basic Headers
      Map<String, dynamic> headers = {
        'Accept': '*/*',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept-Language': Session.getAppLanguage(),
      };

      ///Authorization Header
      String token =
          'Basic MzM4QjFFNzlFNzczQTg2RjVBOTUyQUM5QTE5NEQ0RUE1MkMwNkRFMzE3QkY0MTBFNTRGMzgxRENBQUMzN0I0QjpGNUEwOTg5RTFDRjNFMzlBNDJENzJDOTRDNkU2QjNGNUUzOTkxNDZCMTNGNDFGMUVCMUMyRkVEMzNEOERDRTZB';
      if (token.isNotEmpty) {
        headers.addAll({'Authorization': token});
      }

      Map<String, String> request = ({
        'grant_type': 'refresh_token',
        'refresh_token':
            'eyJ4LXJlZyI6IkVVIiwieC1lbnYiOiJQUkQiLCJjcmVmIjoiMzM4QjFFNzkiLCJ0b2tlbiI6ImRmYzM2ZjJkLWFjMmQtNDRjNy04N2NkLTExMDAzNWNkZTFjOCIsImNsdHkiOiJwcml2YXRlIn0=',
        'scope': 'IdentifyAppliance CoffeeMaker',
      });

      _dio.options.headers = headers;
      print('....Request.....$request');
      return await _dio.post(
          'https://api.home-connect.com/security/oauth/token',
          data: request);
    } catch (e) {
      rethrow;
    }
  }
}
