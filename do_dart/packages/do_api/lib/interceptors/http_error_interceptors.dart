import 'package:dio/dio.dart';
import 'package:do_api/api.dart';
import 'package:do_storage/storage.dart';
import 'package:global_configuration/global_configuration.dart';

class HttpErrorInterceptors extends Interceptor {
  final Dio _dio;
  final AuthAPI _authAPI = AuthAPI(Dio());
  final SharedPreferencesService _sharedPreferences =
      storageLocator<SharedPreferencesService>();
  bool hasRefreshToken = false;
  HttpErrorInterceptors(this._dio);

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
              if (!this.hasRefreshToken) {
                this._dio.interceptors.requestLock.lock();
                this._dio.interceptors.responseLock.lock();
                await this.doRefreshToken();
                RequestOptions options = err.response.request;
                _dio.interceptors.requestLock.unlock();
                _dio.interceptors.responseLock.unlock();
                return _dio.request(options.path, options: options);
              } else {
                await this.clearSharedPreferences();
              }
            } else {
              await this.clearSharedPreferences();
            }
          }
        } catch (e) {}
        break;
      default:
        super.onError(err);
        break;
    }
  }

  Future<void> doRefreshToken() async {
    final String clientId =
        GlobalConfiguration().get('security_resource')['client_id'];
    final String refreshToken =
        this._sharedPreferences.getString('refresh_token');
    Map<String, dynamic> body = {
      'grant_type': 'refresh_token',
      'client_id': clientId,
      'refresh_token': refreshToken,
    };
    await this.putSharedPreferences(await this._authAPI.token(body));
  }

  Future<void> putSharedPreferences(OAuthResult value) async {
    await this._sharedPreferences.putString('access_token', value.accessToken);
    await this
        ._sharedPreferences
        .putString('refresh_token', value.refreshToken);
    await this._sharedPreferences.putString('token_type', value.tokenType);
    await this._sharedPreferences.putString('xrkey', value.publicKey);
    await this._sharedPreferences.putInt('expires_in', value.expiresIn);
    await this._sharedPreferences.putString('authority', value.authority);
    await this._sharedPreferences.putString('provider', value.provider);
    await this._sharedPreferences.putString('image', value.image);
    await this._sharedPreferences.putString('email', value.email);
    await this._sharedPreferences.putString('menus', value.menus);
    await this._sharedPreferences.putString('extras', value.extras);
    await this._sharedPreferences.putString('server_date', value.serverDate);
    await this._sharedPreferences.putString('locale', value.locale);
    await this._sharedPreferences.putString('theme', value.theme);
    await this._sharedPreferences.putString('name', value.name);
    this.hasRefreshToken = !this.hasRefreshToken;
  }

  Future<void> clearSharedPreferences() async {
    await this._sharedPreferences.clearKey('access_token');
    await this._sharedPreferences.clearKey('refresh_token');
    await this._sharedPreferences.clearKey('token_type');
    await this._sharedPreferences.clearKey('expires_in');
    await this._sharedPreferences.clearKey('authority');
    await this._sharedPreferences.clearKey('provider');
    await this._sharedPreferences.clearKey('server_date');
    this.hasRefreshToken = false;
  }
}
