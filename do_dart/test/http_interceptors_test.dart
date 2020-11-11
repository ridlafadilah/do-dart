import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:do_api/api.dart';
import 'package:do_dart/configs/security_config.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'auth_api_test.dart';

final logger = Logger();
OAuthResult oAuthResult;

class HttpBasicInterceptorsTest extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    final String clientId = SecurityConfig().securityResourceModel['client_id'];
    final String clientSecret =
        SecurityConfig().securityResourceModel['client_secret'];
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
    final String key = this.getKey();
    final int timestamp = this.getTimestamp();
    final String path = options.path;
    final String token = this.getToken();
    String signature = this.getSignature('$key:$timestamp:$path:$token');
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
    var key =
        utf8.encode(SecurityConfig().securityResourceModel['private_key']);
    var bytes = utf8.encode(plain);
    Hmac hmacSha256 = new Hmac(sha256, key);
    Digest digest = hmacSha256.convert(bytes);
    return base64.encode(digest.bytes);
  }
}

class HttpErrorInterceptorsTest extends Interceptor {
  Dio dio;
  final AuthAPITest _authAPI = AuthAPITest(Dio());
  HttpErrorInterceptorsTest(Dio _dio, OAuthResult _oAuthResult) {
    this.dio = _dio;
    oAuthResult = _oAuthResult;
  }

  @override
  Future onError(DioError err) async {
    final int statusCode = err.response.statusCode;
    switch (statusCode) {
      case 401:
        try {
          final ErrorResponse response =
              ErrorResponse.fromJson(err.response.data);
          final String msg = response.respStatusMessage['invalid_token'];
          if (msg.contains('expired')) {
            this.dio.interceptors.requestLock.lock();
            this.dio.interceptors.responseLock.lock();
            await this.doRefreshToken(oAuthResult.refreshToken);
            RequestOptions options = err.response.request;
            dio.interceptors.requestLock.unlock();
            dio.interceptors.responseLock.unlock();
            return dio.request(options.path, options: options);
          }
        } catch (e) {}
        break;
      default:
        super.onError(err);
    }
  }

  Future<void> doRefreshToken(String refreshToken) async {
    final String clientId = SecurityConfig().securityResourceModel['client_id'];
    Map<String, dynamic> body = {
      'grant_type': 'refresh_token',
      'client_id': clientId,
      'refresh_token': refreshToken,
    };
    await this.putSharedPreferences(await _authAPI.token(body));
  }

  Future<void> putSharedPreferences(OAuthResult value) async {
    oAuthResult = value;
  }
}
