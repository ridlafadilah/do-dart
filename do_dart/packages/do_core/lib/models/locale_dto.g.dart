// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocaleDto _$LocaleDtoFromJson(Map<String, dynamic> json) {
  return LocaleDto(
    json['localeCode'] as String,
    json['identifier'] as String,
    json['icon'] as String,
    json['localeDefault'] as bool,
    json['localeEnabled'] as bool,
    json['version'] as int,
    json['active'] as String,
    json['createdDate'] as String,
    json['createdBy'] as String,
    json['modifiedDate'] as String,
    json['modifiedBy'] as String,
  );
}

Map<String, dynamic> _$LocaleDtoToJson(LocaleDto instance) => <String, dynamic>{
      'localeCode': instance.localeCode,
      'identifier': instance.identifier,
      'icon': instance.icon,
      'localeDefault': instance.localeDefault,
      'localeEnabled': instance.localeEnabled,
      'version': instance.version,
      'active': instance.active,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
      'modifiedDate': instance.modifiedDate,
      'modifiedBy': instance.modifiedBy,
    };
