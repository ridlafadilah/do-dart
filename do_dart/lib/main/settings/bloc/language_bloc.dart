import 'package:do_core/bloc.dart';
import 'package:do_core/models.dart';

class LanguageBloc extends CommonBloc {
  LanguageBloc() : super(RequestInProgressState());
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

  @override
  Future<List<LocaleDto>> getData() async {
    return locales;
  }

  @override
  Future<dynamic> putData() {
    return null;
  }
}
