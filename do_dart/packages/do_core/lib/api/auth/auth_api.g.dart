// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AuthAPI implements AuthAPI {
  _AuthAPI(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<OAuthResult> token(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/do/oauth/token',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'content-type': 'application/x-www-form-urlencoded'
            },
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = OAuthResult.fromJson(_result.data);
    return value;
  }

  @override
  Future<OAuthResult> tokenVerifier(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/do/oauth/token-verifier',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{
              r'content-type': 'application/x-www-form-urlencoded'
            },
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = OAuthResult.fromJson(_result.data);
    return value;
  }
}
