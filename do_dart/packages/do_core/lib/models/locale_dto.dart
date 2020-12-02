import 'package:json_annotation/json_annotation.dart';

part 'locale_dto.g.dart';

@JsonSerializable()
class LocaleDto {
  LocaleDto(
    this.localeCode,
    this.identifier,
    this.icon,
    this.localeDefault,
    this.localeEnabled,
    this.version,
    this.active,
    this.createdDate,
    this.createdBy,
    this.modifiedDate,
    this.modifiedBy,
  );

  factory LocaleDto.fromJson(Map<String, dynamic> json) =>
      _$LocaleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocaleDtoToJson(this);

  String localeCode;
  String identifier;
  String icon;
  bool localeDefault;
  bool localeEnabled;
  int version;
  String active;
  String createdDate;
  String createdBy;
  String modifiedDate;
  String modifiedBy;
}
