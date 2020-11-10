import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:do_storage/storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:logger/logger.dart';

class HttpSignatureInterceptors extends InterceptorsWrapper {
  final SharedPreferencesService _sharedPreferences =
      storageLocator<SharedPreferencesService>();
  final logger = Logger();

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
    return this._sharedPreferences.getString('xrkey');
  }

  String getToken() {
    return this._sharedPreferences.getString('access_token');
  }

  int getTimestamp() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  String getSignature(String plain) {
    var key = utf8
        .encode(GlobalConfiguration().get('security_resource')['private_key']);
    var bytes = utf8.encode(plain);
    Hmac hmacSha256 = new Hmac(sha256, key);
    Digest digest = hmacSha256.convert(bytes);
    return base64.encode(digest.bytes);
  }
}
