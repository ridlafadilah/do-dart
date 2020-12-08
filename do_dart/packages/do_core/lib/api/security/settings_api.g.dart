// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SettingsAPI implements SettingsAPI {
  _SettingsAPI(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<BaseResponse> putSettings(settings) async {
    ArgumentError.checkNotNull(settings, 'settings');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(settings?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/do/api/security/trx/put/settings/v.1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'content-type': 'application/json'},
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = BaseResponse.fromJson(_result.data);
    return value;
  }
}
