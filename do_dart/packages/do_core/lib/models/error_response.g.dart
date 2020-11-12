// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) {
  return ErrorResponse(
    json['respStatusCode'] as String,
    json['respStatusMessage'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'respStatusCode': instance.respStatusCode,
      'respStatusMessage': instance.respStatusMessage,
    };
