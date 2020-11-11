import 'package:dio/dio.dart' hide Headers;
import 'package:do_api/interceptors/http_basic_interceptors.dart';
import 'package:do_api/models/oauth_result.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:retrofit/http.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthAPI {
  factory AuthAPI(Dio dio) {
    final String baseUrl =
        GlobalConfiguration().getValue('hosts')['auth']['host'];
    assert(baseUrl != null);
    dio.options.receiveTimeout = 30000;
    dio.options.connectTimeout = 15000;
    dio.interceptors.add(HttpBasicInterceptors());
    return _AuthAPI(dio, baseUrl: baseUrl);
  }

  @Headers({'content-type': 'application/x-www-form-urlencoded'})
  @POST('/do/oauth/token')
  Future<OAuthResult> token(@Body() Map<String, dynamic> body);
}
