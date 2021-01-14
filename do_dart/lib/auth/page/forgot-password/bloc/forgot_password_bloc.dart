import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_common/common.dart';
import 'package:do_core/core.dart';
import 'package:do_core/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<CommonEvent, ForgotPasswordState> {
  ForgotPasswordBloc({
    @required AuthService authService,
    @required String verificationId,
    @required String verificationCode,
  })  : assert(authService != null),
        _authService = authService,
        super(ForgotPasswordState(
            verificationId: verificationId,
            verificationCode: verificationCode));

  final AuthService _authService;

  @override
  Stream<ForgotPasswordState> mapEventToState(
    CommonEvent event,
  ) async* {
    if (event is ForgotPasswordNewPasswordChanged) {
      yield _mapNewPasswordChangedToState(event, state);
    } else if (event is ForgotPasswordConfirmPasswordChanged) {
      yield _mapConfirmPasswordChangedToState(event, state);
    } else if (event is ForgotPasswordEvent) {
      yield* _mapForgotPasswordRequestedToState(event, state);
    }
  }

  ForgotPasswordState _mapNewPasswordChangedToState(
    ForgotPasswordNewPasswordChanged event,
    ForgotPasswordState state,
  ) {
    final newPassword = NewPassword.dirty(event.newPassword);
    return state.copyWith(
      newPassword: newPassword,
      action: Formz.validate([newPassword, state.confirmPassword]),
      status: FormzStatus.pure,
      error: null,
    );
  }

  ForgotPasswordState _mapConfirmPasswordChangedToState(
    ForgotPasswordConfirmPasswordChanged event,
    ForgotPasswordState state,
  ) {
    final confirmPassword = ConfirmedPassword.dirty(
        password: state.newPassword.value, value: event.confirmPassword);
    return state.copyWith(
      confirmPassword: confirmPassword,
      action: Formz.validate([state.newPassword, confirmPassword]),
      status: FormzStatus.pure,
      error: null,
    );
  }

  Stream<ForgotPasswordState> _mapForgotPasswordRequestedToState(
    ForgotPasswordEvent event,
    ForgotPasswordState state,
  ) async* {
    if (state.action.isValidated) {
      yield state.copyWith(
          status: FormzStatus.submissionInProgress,
          action: FormzStatus.submissionInProgress);
      try {
        await _authService.forgotPassword(
          verificationId: state.verificationId,
          verificationCode: state.verificationCode,
          newPassword: state.newPassword.value,
          confirmPassword: state.confirmPassword.value,
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
}
