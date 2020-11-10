import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:logger/logger.dart';

class HttpBasicInterceptors extends InterceptorsWrapper {
  final logger = Logger();

  @override
  Future onRequest(RequestOptions options) async {
    final String clientId =
        GlobalConfiguration().get('security_resource')['client_id'];
    final String clientSecret =
        GlobalConfiguration().get('security_resource')['client_secret'];
    final String authorization =
        base64Encode(utf8.encode('$clientId:$clientSecret'));
    assert(clientId != null);
    assert(clientSecret != null);
    options.headers['authorization'] = 'Basic $authorization';
    return options;
  }
}
