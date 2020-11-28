import 'package:dio/dio.dart' hide Headers;
import 'package:do_core/models.dart';
import 'package:do_dart/environments/environment.dart';
import 'package:retrofit/http.dart';

import 'http_interceptors_test.dart';

part 'auth_api_test.g.dart';

@RestApi()
abstract class AuthAPITest {
  factory AuthAPITest(Dio dio) {
    final String baseUrl =
        Environment().hosts['hosts']['auth']['host'].toString();
    assert(baseUrl != null);
    dio.options.receiveTimeout = 30000;
    dio.options.connectTimeout = 15000;
    dio.interceptors.add(HttpBasicInterceptorsTest());
    return _AuthAPITest(dio, baseUrl: baseUrl);
  }

  @Headers({'content-type': 'application/x-www-form-urlencoded'})
  @POST('/do/oauth/token')
  Future<OAuthResult> token(@Body() Map<String, dynamic> body);
}
