import 'dart:convert';

import 'package:dio/dio.dart' hide Headers;
import 'package:do_api/models/oauth_result.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:retrofit/http.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthAPI {
  factory AuthAPI(Dio dio) {
    final String clientId =
        GlobalConfiguration().get("security_resource")["client_id"].toString();
    final String clientSecret = GlobalConfiguration()
        .get("security_resource")["client_secret"]
        .toString();
    final String baseUrl =
        GlobalConfiguration().getValue("hosts")["auth"]["host"].toString();
    final String authorization =
        base64Encode(utf8.encode('$clientId:$clientSecret'));
    assert(clientId != null);
    assert(clientSecret != null);
    assert(baseUrl != null);
    dio.options = BaseOptions(receiveTimeout: 30000, connectTimeout: 30000);
    dio.options.headers['authorization'] = 'Basic $authorization';
    return _AuthAPI(dio, baseUrl: baseUrl);
  }

  @Headers({'content-type': 'application/x-www-form-urlencoded'})
  @POST("/do/oauth/token")
  Future<OAuthResult> token(@Body() Map<String, dynamic> body);
}
