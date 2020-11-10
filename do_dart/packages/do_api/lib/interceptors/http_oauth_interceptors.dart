import 'package:dio/dio.dart';
import 'package:do_storage/storage.dart';
import 'package:logger/logger.dart';

class HttpOAuthInterceptors extends InterceptorsWrapper {
  final SharedPreferencesService _sharedPreferences =
      storageLocator<SharedPreferencesService>();
  final logger = Logger();

  @override
  Future onRequest(RequestOptions options) async {
    final String authorization =
        this._sharedPreferences.getString('access_token');
    assert(authorization != null);
    options.headers['authorization'] = 'Bearer $authorization';
    return options;
  }
}
