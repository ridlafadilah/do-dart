import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {
  String respStatusCode;
  Map<String, dynamic> respStatusMessage;

  ErrorResponse(this.respStatusCode, this.respStatusMessage);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  @override
  String toString() {
    return 'ErrorResponse : {' +
        'respStatusCode: $respStatusCode, ' +
        'respStatusMessage: $respStatusMessage}';
  }
}
