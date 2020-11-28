import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:do_core/models.dart';
import 'package:do_dart/configs/security_config.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'auth_api_test.dart';

final logger = Logger();
OAuthResult oAuthResult;

class HttpBasicInterceptorsTest extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    final String clientId =
        SecurityConfig().securityResourceModel['client_id'].toString();
    final String clientSecret =
        SecurityConfig().securityResourceModel['client_secret'].toString();
    final String authorization =
        base64Encode(utf8.encode('$clientId:$clientSecret'));
    assert(clientId != null);
    assert(clientSecret != null);
    options.headers['authorization'] = 'Basic $authorization';
    return options;
  }
}

class HttpOAuthInterceptorsTest extends Interceptor {
  HttpOAuthInterceptorsTest(OAuthResult _oAuthResult) {
    oAuthResult = _oAuthResult;
  }

  @override
  Future onRequest(RequestOptions options) async {
    String authorization = oAuthResult.accessToken;
    assert(authorization != null);
    options.headers['authorization'] = 'Bearer $authorization';
    return options;
  }
}

class HttpSignatureInterceptorsTest extends Interceptor {
  HttpSignatureInterceptorsTest(OAuthResult _oAuthResult) {
    oAuthResult = _oAuthResult;
  }

  @override
  Future onRequest(RequestOptions options) async {
    final String key = getKey();
    final int timestamp = getTimestamp();
    final String path = options.path;
    final String token = getToken();
    String signature = getSignature('$key:$timestamp:$path:$token');
    options.headers['X-DONGKAP-Key'] = key;
    options.headers['X-DONGKAP-Timestamp'] = timestamp;
    options.headers['X-DONGKAP-Signature'] = signature;
    return options;
  }

  String getKey() {
    return oAuthResult.publicKey;
  }

  String getToken() {
    return oAuthResult.accessToken;
  }

  String getDate() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  int getTimestamp() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  String getSignature(String plain) {
    var key = utf8.encode(
        SecurityConfig().securityResourceModel['private_key'].toString());
    var bytes = utf8.encode(plain);
    Hmac hmacSha256 = Hmac(sha256, key);
    Digest digest = hmacSha256.convert(bytes);
    return base64.encode(digest.bytes);
  }
}

class HttpLanguageInterceptorsTest extends InterceptorsWrapper {
  HttpLanguageInterceptorsTest(OAuthResult _oAuthResult) {
    oAuthResult = _oAuthResult;
  }

  @override
  Future onRequest(RequestOptions options) async {
    options.headers['accept-language'] = oAuthResult.locale;
    return options;
  }
}

class HttpErrorInterceptorsTest extends Interceptor {
  HttpErrorInterceptorsTest(this.dio, OAuthResult _oAuthResult) {
    oAuthResult ??= _oAuthResult;
  }
  final Dio dio;
  final AuthAPITest _authAPI = AuthAPITest(Dio());
  bool hasRefreshToken = false;
  int timeouts = 0;

  @override
  Future onResponse(Response response) async {
    hasRefreshToken = false;
  }

  @override
  Future onError(DioError err) async {
    final int statusCode = err.response.statusCode;
    final ErrorResponse response = ErrorResponse.fromJson(err.response.data);
    logger.i(err.response.data);
    switch (statusCode) {
      case 401:
        try {
          final String msg =
              response.respStatusMessage['invalid_token'].toString();
          if (msg != null) {
            if (msg.contains('expired')) {
              if (!hasRefreshToken) {
                dio.interceptors.requestLock.lock();
                dio.interceptors.responseLock.lock();
                await doRefreshToken(oAuthResult.refreshToken)
                    .catchError((onError) {});
                /*
                logger.w('Waiting 15 seconds for the access_token to expired');
                await new Future.delayed(const Duration(seconds: 15));
                */
                RequestOptions options = err.response.request;
                dio.interceptors.requestLock.unlock();
                dio.interceptors.responseLock.unlock();
                return dio.request(options.path, options: options);
              } else {
                clearSharedPreferences();
                logger.e('LOGOUT');
              }
            } else {
              clearSharedPreferences();
              logger.e('LOGOUT');
            }
          }
        } catch (e) {}
        break;
      default:
        await super.onError(err);
        break;
    }
  }

  Future<void> doRefreshToken(String refreshToken) async {
    final String clientId =
        SecurityConfig().securityResourceModel['client_id'].toString();
    Map<String, dynamic> body = {
      'grant_type': 'refresh_token',
      'client_id': clientId,
      'refresh_token': refreshToken,
    };
    await putSharedPreferences(await _authAPI.token(body));
  }

  Future<void> putSharedPreferences(OAuthResult value) async {
    oAuthResult = value;
    hasRefreshToken = !hasRefreshToken;
  }

  void clearSharedPreferences() {
    hasRefreshToken = false;
  }
}
