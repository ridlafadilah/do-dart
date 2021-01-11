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
  })  : assert(authService != null),
        _authService = authService,
        super(VerificationForgotPasswordState(verificationId: verificationId));

  final AuthService _authService;

  @override
  Stream<VerificationForgotPasswordState> mapEventToState(
    CommonEvent event,
  ) async* {
    if (event is VerificationCodeChanged) {
      yield _mapVerificationCodeChangedToState(event, state);
    } else if (event is VerificationForgotPasswordEvent) {
      yield* _mapVerificationForgotPasswordRequestedToState(event, state);
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
          action: FormzStatus.submissionInProgress);
      try {
        await _authService.verificationForgotPassword(
          verificationId: state.verificationId,
          verificationCode: state.verificationCode.value,
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
