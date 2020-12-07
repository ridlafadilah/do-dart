import 'package:do_core/bloc.dart';
import 'package:do_core/models.dart';

class ChangeLanguageBloc extends CommonBloc {
  ChangeLanguageBloc() : super(SubmitInProgressState());

  @override
  Future<List<LocaleDto>> getData() async {
    return null;
  }

  @override
  Future<dynamic> putData() {
    return null;
  }
}
