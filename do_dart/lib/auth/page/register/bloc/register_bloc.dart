import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_common/common.dart';
import 'package:do_core/core.dart';
import 'package:do_core/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<CommonEvent, RegisterState> {
  RegisterBloc({
    @required AuthService authService,
  })  : assert(authService != null),
        _authService = authService,
        super(const RegisterState());

  final AuthService _authService;

  @override
  Stream<RegisterState> mapEventToState(
    CommonEvent event,
  ) async* {
    if (event is RegisterEvent) {
      yield* _mapRegisterRequestedToState(event, state);
    } else {
      yield _mapEventToState(event, state);
    }
  }

  RegisterState _mapEventToState(
    CommonEvent event,
    RegisterState state,
  ) {
    Name fullname = state.fullname;
    Username username = state.username;
    Email email = state.email;
    NewPassword password = state.password;
    ConfirmedPassword confirmPassword = state.confirmPassword;
    TextForm captcha = state.captcha;
    if (event is RegisterFullnameChanged) {
      fullname = Name.dirty(event.fullname);
    } else if (event is RegisterUsernameChanged) {
      username = Username.dirty(event.username);
    } else if (event is RegisterEmailChanged) {
      email = Email.dirty(event.email);
    } else if (event is RegisterPasswordChanged) {
      password = NewPassword.dirty(event.password);
    } else if (event is RegisterConfirmPasswordChanged) {
      confirmPassword = ConfirmedPassword.dirty(
          password: password.value, value: event.confirmPassword);
    } else if (event is RegisterCaptchaChanged) {
      captcha = TextForm.dirty(event.captcha);
    }
    return state.copyWith(
      fullname: fullname,
      username: username,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      captcha: captcha,
      action: Formz.validate(
          [fullname, username, email, password, confirmPassword, captcha]),
      status: FormzStatus.pure,
      error: null,
    );
  }

  Stream<RegisterState> _mapRegisterRequestedToState(
    RegisterEvent event,
    RegisterState state,
  ) async* {
    if (state.action.isValidated) {
      yield state.copyWith(
          status: FormzStatus.submissionInProgress,
          action: FormzStatus.submissionInProgress);
      try {
        await _authService.signup(
            fullname: state.fullname.value,
            username: state.username.value,
            email: state.email.value,
            password: state.password.value,
            confirmPassword: state.confirmPassword.value,
            recaptcha: state.captcha.value,
            terms: null);
        yield state.copyWith(
          status: FormzStatus.submissionSuccess,
          action: FormzStatus.submissionSuccess,
          error: null,
        );
      } on ServerError catch (err) {
        yield state.copyWith(
          error: err.getErrorMessage(),
          action: FormzStatus.submissionFailure,
          status: FormzStatus.submissionFailure,
        );
      }
    }
  }
}
