import 'package:dio/dio.dart' hide Headers;
import 'package:do_core/interceptors/http_error_interceptors.dart';
import 'package:do_core/interceptors/http_oauth_interceptors.dart';
import 'package:do_core/interceptors/http_signature_interceptors.dart';
import 'package:do_core/services/auth_service.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:retrofit/http.dart';

part 'profile_api.g.dart';

@RestApi()
abstract class ProfileAPI {
  factory ProfileAPI(Dio dio, AuthService authService) {
    final String baseUrl =
        GlobalConfiguration().getValue('hosts')['profile']['host'];
    assert(baseUrl != null);
    dio.options.receiveTimeout = 30000;
    dio.options.connectTimeout = 15000;
    dio.interceptors.add(HttpOAuthInterceptors());
    dio.interceptors.add(HttpSignatureInterceptors());
    dio.interceptors.add(HttpErrorInterceptors(dio, authService));
    return _ProfileAPI(dio, baseUrl: baseUrl);
  }

  @Headers({'content-type': 'application/json'})
  @GET('/do/api/profile/vw/get/profile/v.1')
  Future getProfile();
}
