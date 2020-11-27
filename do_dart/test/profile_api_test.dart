import 'package:dio/dio.dart' hide Headers;
import 'package:do_core/core.dart';
import 'package:do_core/models/profile_dto.dart';
import 'package:do_dart/environments/environment.dart';
import 'package:retrofit/http.dart';

import 'http_interceptors_test.dart';

part 'profile_api_test.g.dart';

@RestApi()
abstract class ProfileAPITest {
  factory ProfileAPITest(Dio dio, OAuthResult oAuthResult) {
    final String baseUrl =
        Environment().hosts['hosts']['profile']['host'].toString();
    assert(baseUrl != null);
    dio.options.receiveTimeout = 30000;
    dio.options.connectTimeout = 15000;
    dio.interceptors.add(HttpOAuthInterceptorsTest(oAuthResult));
    dio.interceptors.add(HttpSignatureInterceptorsTest(oAuthResult));
    dio.interceptors.add(HttpErrorInterceptorsTest(dio, oAuthResult));
    return _ProfileAPITest(dio, baseUrl: baseUrl);
  }

  @Headers({'content-type': 'application/json'})
  @GET('/do/api/profile/vw/get/profile/v.1')
  Future<ProfileDto> getProfile();
}
