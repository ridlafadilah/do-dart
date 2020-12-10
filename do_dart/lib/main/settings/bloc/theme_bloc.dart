import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:meta/meta.dart';

class ThemeBloc extends CommonBloc<bool, bool, bool> {
  ThemeBloc({@required AuthService authService})
      : assert(authService != null),
        _authService = authService,
        super(RequestInProgressState());

  final AuthService _authService;
  ThemeService themeService;
  @override
  Future<bool> getData() async {
    themeService = ThemeService(authService: _authService);
    return themeService.getData();
  }

  @override
  Future<bool> putData(bool data) async {
    themeService = ThemeService(authService: _authService);
    return await themeService.putData(data);
  }
}
