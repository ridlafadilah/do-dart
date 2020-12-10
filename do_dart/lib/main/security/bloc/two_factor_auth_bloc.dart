import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';

class TwoFactorAuthenticationBloc extends CommonBloc<bool, bool, bool> {
  TwoFactorAuthenticationBloc() : super(RequestInProgressState());

  TwoFactorAuthenticationService themeService;

  @override
  Future<bool> getData() async {
    themeService = TwoFactorAuthenticationService();
    return themeService.getData();
  }

  @override
  Future<bool> putData(bool data) async {
    themeService = TwoFactorAuthenticationService();
    return await themeService.putData(data);
  }
}
