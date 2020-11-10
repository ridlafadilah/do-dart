import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:do_dart/configs/security_config.dart';
import 'package:do_dart/environments/environment.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:test/test.dart';

final dio = Dio();
final logger = Logger();
Map<String, dynamic> oAuthResult;

void main() {
  setUp(() async {
    dio.options = BaseOptions(receiveTimeout: 30000, connectTimeout: 15000);
    dio.options.baseUrl = Environment().hosts['hosts']['auth']['host'];
  });

  group('API', () {
    test("Login", () async {
      dio.interceptors.add(HttpBasicInterceptors());
      Response response;
      dio.options.headers['content-type'] = 'application/x-www-form-urlencoded';
      final String clientId =
          SecurityConfig().securityResourceModel['client_id'];
      Map<String, dynamic> body = {
        'grant_type': 'password',
        'client_id': clientId,
        'username': 'admin',
        'password': 'admin123'
      };
      response = await dio.post('/do/oauth/token', data: body);
      oAuthResult = response.data;
      logger.i(response.data);
    });

    test("Get Profile", () async {
      dio.interceptors.add(HttpOAuthInterceptors(oAuthResult));
      dio.interceptors.add(HttpSignatureInterceptors(oAuthResult));
      Response response;
      dio.options.headers['content-type'] = 'application/json';
      response = await dio.get('/do/api/profile/vw/get/profile/v.1');
      logger.i(response.data);
    });
  });
}

class HttpBasicInterceptors extends Interceptor {
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

class HttpOAuthInterceptors extends Interceptor {
  final Map<String, dynamic> oAuthResult;
  HttpOAuthInterceptors(this.oAuthResult);

  @override
  Future onRequest(RequestOptions options) async {
    String authorization = oAuthResult['access_token'];
    assert(authorization != null);
    options.headers['authorization'] = 'Bearer $authorization';
    return options;
  }
}

class HttpSignatureInterceptors extends Interceptor {
  final Map<String, dynamic> oauthResult;
  HttpSignatureInterceptors(this.oauthResult);

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
    return this.oauthResult['xrkey'];
  }

  String getToken() {
    return this.oauthResult['access_token'];
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
