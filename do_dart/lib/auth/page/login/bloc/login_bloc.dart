import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_common/common.dart';
import 'package:do_core/core.dart';
import 'package:do_core/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<CommonEvent, LoginState> {
  LoginBloc({
    @required AuthService authService,
  })  : assert(authService != null),
        _authService = authService,
        super(const LoginState());

  final AuthService _authService;

  @override
  Stream<LoginState> mapEventToState(
    CommonEvent event,
  ) async* {
    if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is SubmittedEvent) {
      yield* _mapLoginSubmittedToState(event, state);
    } else if (event is GoogleLoginEvent) {
      yield* _mapLoginGoogleToState(event, state);
    }
  }

  LoginState _mapUsernameChangedToState(
    LoginUsernameChanged event,
    LoginState state,
  ) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      action: Formz.validate([state.password, username]),
      status: FormzStatus.pure,
      error: null,
    );
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      action: Formz.validate([password, state.username]),
      status: FormzStatus.pure,
      error: null,
    );
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    SubmittedEvent event,
    LoginState state,
  ) async* {
    if (state.action.isValidated) {
      yield state.copyWith(
          status: FormzStatus.submissionInProgress,
          action: FormzStatus.submissionInProgress);
      try {
        await _authService.logIn(
          username: state.username.value,
          password: state.password.value,
        );
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

  Stream<LoginState> _mapLoginGoogleToState(
    GoogleLoginEvent event,
    LoginState state,
  ) async* {
    yield state.copyWith(
        status: FormzStatus.submissionInProgress,
        action: FormzStatus.submissionInProgress);
    try {
      await _authService.loginGoogle();
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
