import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_core/models.dart';

class LanguageBloc extends CommonBloc {
  LanguageBloc() : super(RequestInProgressState());
  LanguageService languageService = LanguageService();

  @override
  Future<List<LocaleDto>> getData() async {
    return languageService.getData();
  }

  @override
  Future<dynamic> putData() async {
    return languageService.putData();
  }
}
