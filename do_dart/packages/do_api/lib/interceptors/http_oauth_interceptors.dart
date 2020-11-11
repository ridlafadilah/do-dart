import 'package:dio/dio.dart';
import 'package:do_storage/storage.dart';

class HttpOAuthInterceptors extends InterceptorsWrapper {
  final SharedPreferencesService _sharedPreferences =
      storageLocator<SharedPreferencesService>();

  @override
  Future onRequest(RequestOptions options) async {
    final String authorization =
        this._sharedPreferences.getString('access_token');
    assert(authorization != null);
    options.headers['authorization'] = 'Bearer $authorization';
    return options;
  }
}
