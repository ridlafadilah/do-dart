import 'dart:async';

import 'package:dio/dio.dart';
import 'package:do_api/api.dart';
import 'package:do_auth/models/auth_status.dart';
import 'package:do_storage/storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

class AuthService {
  final SharedPreferencesService _sharedPreferences =
      storageLocator<SharedPreferencesService>();
  final logger = Logger();
  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (_sharedPreferences.isKeyExists('access_token')) {
      yield AuthStatus.authenticated;
    } else {
      yield AuthStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  Future<void> logIn({
    @required String username,
    @required String password,
  }) async {
    final String clientId =
        GlobalConfiguration().get('security_resource')['client_id'].toString();
    final _authAPI = AuthAPI(Dio());
    Map<String, dynamic> body = {
      'grant_type': 'password',
      'client_id': clientId,
      'username': username,
      'password': password
    };
    await _authAPI.token(body).then((value) async {
      await putSharedPreferences(value)
          .then((value) => _controller.add(AuthStatus.authenticated));
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final error = ServerError.withError(error: obj as DioError);
          logger.e(error.getErrorMessage());
          break;
        default:
      }
    });
  }

  Future<void> logOut() async {
    await _sharedPreferences.clearKey('access_token');
    await _sharedPreferences.clearKey('refresh_token');
    await _sharedPreferences.clearKey('token_type');
    await _sharedPreferences.clearKey('expires_in');
    await _sharedPreferences.clearKey('authority');
    await _sharedPreferences.clearKey('provider');
    await _sharedPreferences.clearKey('server_date');
    _controller.add(AuthStatus.unauthenticated);
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
  }

  void dispose() => _controller.close();
}
