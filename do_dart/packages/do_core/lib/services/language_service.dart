import 'dart:async';

import 'package:do_core/models/locale_dto.dart';
import 'package:logger/logger.dart';

class LanguageService {
  final logger = Logger();
  final List<LocaleDto> locales = <LocaleDto>[
    LocaleDto.fromJson({
      'localeCode': 'en-US',
      'identifier': 'English',
      'subIdentifier': 'United States',
      'icon': 'flag-icon flag-icon-us',
      'localeDefault': true,
      'localeEnabled': true,
    }),
    LocaleDto.fromJson({
      'localeCode': 'id-ID',
      'identifier': 'Indonesian',
      'subIdentifier': 'Indonesia',
      'icon': 'flag-icon flag-icon-id',
      'localeDefault': false,
      'localeEnabled': true,
    }),
  ];

  Future<List<LocaleDto>> getData() async {
    return locales;
  }

  Future<dynamic> putData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 3000));
    return true;
  }
}
