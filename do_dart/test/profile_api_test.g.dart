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
}
