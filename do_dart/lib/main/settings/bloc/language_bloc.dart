import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:meta/meta.dart';

class LanguageBloc
    extends CommonBloc<List<LocaleDto>, LocaleDto, BaseResponse> {
  LanguageBloc({@required AuthService authService})
      : assert(authService != null),
        _authService = authService,
        super(RequestInProgressState());

  final AuthService _authService;
  LanguageService languageService;
  @override
  Future<List<LocaleDto>> getData() async {
    languageService = LanguageService(authService: _authService);
    return await languageService.getData();
  }

  @override
  Future<BaseResponse> putData(LocaleDto data) async {
    languageService = LanguageService(authService: _authService);
    return await languageService.putData(data);
  }
}
