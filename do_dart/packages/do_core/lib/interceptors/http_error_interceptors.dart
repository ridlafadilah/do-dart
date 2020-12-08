import 'package:dio/dio.dart';
import 'package:do_core/api/auth/auth_api.dart';
import 'package:do_core/models/base_response.dart';
import 'package:do_core/services/auth_service.dart';
import 'package:do_core/services/core_locator.dart';
import 'package:do_core/services/shared_preferences_service.dart';
import 'package:global_configuration/global_configuration.dart';

class HttpErrorInterceptors extends Interceptor {
  HttpErrorInterceptors(this._dio, this._authService);
  final Dio _dio;
  final AuthService _authService;
  final AuthAPI _authAPI = AuthAPI(Dio());
  final SharedPreferencesService _sharedPreferences =
      coreLocator<SharedPreferencesService>();
  bool hasRefreshToken = false;

  @override
  Future onResponse(Response response) async {
    hasRefreshToken = false;
  }

  @override
  Future onError(DioError err) async {
    final int statusCode = err.response.statusCode;
    final BaseResponse response = BaseResponse.fromJson(err.response.data);
    switch (statusCode) {
      case 401:
        try {
          final String msg = response.respStatusMessage['invalid_token'];
          if (msg != null) {
            if (msg.contains('expired')) {
              if (!hasRefreshToken) {
                _dio.interceptors.requestLock.lock();
                _dio.interceptors.responseLock.lock();
                await doRefreshToken().catchError((onError) {});
                RequestOptions options = err.response.request;
                _dio.interceptors.requestLock.unlock();
                _dio.interceptors.responseLock.unlock();
                return _dio.request(options.path, options: options);
              } else {
                await doLogOut();
              }
            } else {
              await doLogOut();
            }
          }
        } catch (e) {}
        break;
      default:
        await super.onError(err);
        break;
    }
  }

  Future<void> doRefreshToken() async {
    final String clientId =
        GlobalConfiguration().get('security_resource')['client_id'];
    final String refreshToken = _sharedPreferences.getString('refresh_token');
    Map<String, dynamic> body = {
      'grant_type': 'refresh_token',
      'client_id': clientId,
      'refresh_token': refreshToken,
    };
    await _authService.putSharedPreferences(await _authAPI.token(body));
    hasRefreshToken = !hasRefreshToken;
  }

  Future<void> doLogOut() async {
    await _authService.logOut();
    hasRefreshToken = false;
  }
}
