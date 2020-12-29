// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_api_test.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ProfileAPITest implements ProfileAPITest {
  _ProfileAPITest(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ProfileDto> getProfile() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/do/api/profile/vw/get/profile/v.1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'content-type': 'application/json'},
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = ProfileDto.fromJson(_result.data);
    return value;
  }

  @override
  Future<BaseResponse> putProfile(profile) async {
    ArgumentError.checkNotNull(profile, 'profile');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(profile?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/do/api/profile/trx/post/profile/v.1',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'content-type': 'application/json'},
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = BaseResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<HttpResponse<dynamic>> getPhotoProfile(imageUUID) async {
    ArgumentError.checkNotNull(imageUUID, 'imageUUID');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request(
        '/do/api/file/vw/get/photo-profile/v.1/$imageUUID',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'content-type': 'image/png'},
            extra: _extra,
            contentType: 'image/png',
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }
}
