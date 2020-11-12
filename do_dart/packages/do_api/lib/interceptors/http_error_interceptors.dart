import 'package:dio/dio.dart';
import 'package:do_api/api.dart';
import 'package:do_storage/storage.dart';
import 'package:global_configuration/global_configuration.dart';

class HttpErrorInterceptors extends Interceptor {
  HttpErrorInterceptors(this._dio);
  final Dio _dio;
  final AuthAPI _authAPI = AuthAPI(Dio());
  final SharedPreferencesService _sharedPreferences =
      storageLocator<SharedPreferencesService>();
  bool hasRefreshToken = false;

  @override
  Future onError(DioError err) async {
    final int statusCode = err.response.statusCode;
    final ErrorResponse response = ErrorResponse.fromJson(err.response.data);
    switch (statusCode) {
      case 401:
        try {
          final String msg = response.respStatusMessage['invalid_token'];
          if (msg != null) {
            if (msg.contains('expired')) {
              if (!hasRefreshToken) {
                _dio.interceptors.requestLock.lock();
                _dio.interceptors.responseLock.lock();
                await doRefreshToken();
                RequestOptions options = err.response.request;
                _dio.interceptors.requestLock.unlock();
                _dio.interceptors.responseLock.unlock();
                return _dio.request(options.path, options: options);
              } else {
                await clearSharedPreferences();
              }
            } else {
              await clearSharedPreferences();
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
    await putSharedPreferences(await _authAPI.token(body));
  }

  Future<void> putSharedPreferences(OAuthResult value) async {
    await _sharedPreferences.putString('access_token', value.accessToken);
    await _sharedPreferences.putString('refresh_token', value.refreshToken);
    await _sharedPreferences.putString('token_type', value.tokenType);
    await _sharedPreferences.putString('xrkey', value.publicKey);
    await _sharedPreferences.putInt('expires_in', value.expiresIn);
    await _sharedPreferences.putString('authority', value.authority);
    await _sharedPreferences.putString('provider', value.provider);
    await _sharedPreferences.putString('image', value.image);
    await _sharedPreferences.putString('email', value.email);
    await _sharedPreferences.putString('menus', value.menus);
    await _sharedPreferences.putString('extras', value.extras);
    await _sharedPreferences.putString('server_date', value.serverDate);
    await _sharedPreferences.putString('locale', value.locale);
    await _sharedPreferences.putString('theme', value.theme);
    await _sharedPreferences.putString('name', value.name);
    hasRefreshToken = !hasRefreshToken;
  }

  Future<void> clearSharedPreferences() async {
    await _sharedPreferences.clearKey('access_token');
    await _sharedPreferences.clearKey('refresh_token');
    await _sharedPreferences.clearKey('token_type');
    await _sharedPreferences.clearKey('expires_in');
    await _sharedPreferences.clearKey('authority');
    await _sharedPreferences.clearKey('provider');
    await _sharedPreferences.clearKey('server_date');
    hasRefreshToken = false;
  }
}
