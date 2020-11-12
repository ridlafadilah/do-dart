import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {
  ErrorResponse(this.respStatusCode, this.respStatusMessage);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  String respStatusCode;
  Map<String, dynamic> respStatusMessage;

  @override
  String toString() => '''
ErrorResponse : {${'respStatusCode: $respStatusCode, '}${'respStatusMessage: $respStatusMessage}'}''';
}
