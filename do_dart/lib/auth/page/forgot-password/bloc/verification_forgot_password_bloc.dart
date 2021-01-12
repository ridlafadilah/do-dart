import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_common/common.dart';
import 'package:do_core/core.dart';
import 'package:do_core/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'verification_forgot_password_event.dart';
part 'verification_forgot_password_state.dart';

class VerificationForgotPasswordBloc
    extends Bloc<CommonEvent, VerificationForgotPasswordState> {
  VerificationForgotPasswordBloc({
    @required AuthService authService,
    @required String verificationId,
    @required String email,
  })  : assert(authService != null),
        _authService = authService,
        super(VerificationForgotPasswordState(
            email: email, verificationId: verificationId));

  final AuthService _authService;

  @override
  Stream<VerificationForgotPasswordState> mapEventToState(
    CommonEvent event,
  ) async* {
    if (event is VerificationCodeChanged) {
      yield _mapVerificationCodeChangedToState(event, state);
    } else if (event is VerificationForgotPasswordEvent) {
      yield* _mapVerificationForgotPasswordRequestedToState(event, state);
    } else if (event is ResendForgotPasswordEvent) {
      yield* _mapResendForgotPasswordRequestedToState(event, state);
    }
  }

  VerificationForgotPasswordState _mapVerificationCodeChangedToState(
    VerificationCodeChanged event,
    VerificationForgotPasswordState state,
  ) {
    final verificationCode = Number.dirty(event.verificationCode, 6);
    return state.copyWith(
      verificationCode: verificationCode,
      action: Formz.validate([verificationCode]),
      status: FormzStatus.pure,
      resend: FormzStatus.pure,
      error: null,
    );
  }

  Stream<VerificationForgotPasswordState>
      _mapVerificationForgotPasswordRequestedToState(
    VerificationForgotPasswordEvent event,
    VerificationForgotPasswordState state,
  ) async* {
    if (state.action.isValidated) {
      yield state.copyWith(
          status: FormzStatus.submissionInProgress,
          action: FormzStatus.submissionInProgress,
          resend: FormzStatus.pure);
      try {
        await _authService.verificationForgotPassword(
          verificationId: state.verificationId,
          verificationCode: state.verificationCode.value,
        );
        yield state.copyWith(
          status: FormzStatus.submissionSuccess,
          action: FormzStatus.submissionSuccess,
          resend: FormzStatus.pure,
          error: null,
        );
      } on ServerError catch (err) {
        yield state.copyWith(
          error: err.getErrorMessage(),
          action: FormzStatus.submissionFailure,
          status: FormzStatus.submissionFailure,
          resend: FormzStatus.pure,
        );
      }
    }
  }

  Stream<VerificationForgotPasswordState>
      _mapResendForgotPasswordRequestedToState(
    ResendForgotPasswordEvent event,
    VerificationForgotPasswordState state,
  ) async* {
    if (!state.status.isSubmissionInProgress) {
      yield state.copyWith(
        status: FormzStatus.submissionInProgress,
        resend: FormzStatus.submissionInProgress,
        error: null,
      );
      try {
        await _authService.requestForgotPassword(
          email: state.email,
        );
        yield state.copyWith(
          status: FormzStatus.pure,
          action: FormzStatus.pure,
          resend: FormzStatus.submissionSuccess,
          error: null,
        );
      } on ServerError catch (err) {
        yield state.copyWith(
          error: err.getErrorMessage(),
          status: FormzStatus.submissionFailure,
          action: FormzStatus.submissionFailure,
          resend: FormzStatus.submissionFailure,
        );
      }
    }
  }
}
