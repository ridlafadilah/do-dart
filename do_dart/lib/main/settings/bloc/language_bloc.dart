import 'package:do_core/bloc.dart';
import 'package:do_core/models.dart';

class LanguageBloc extends CommonBloc<LocaleDto> {
  LanguageBloc() : super(InProgressState());

  @override
  Future<LocaleDto> getData() async {
    return null;
  }
}
