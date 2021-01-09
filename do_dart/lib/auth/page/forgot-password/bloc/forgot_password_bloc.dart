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
  })  : assert(authService != null),
        _authService = authService,
        super(const ForgotPasswordState());

  final AuthService _authService;

  @override
  Stream<ForgotPasswordState> mapEventToState(
    CommonEvent event,
  ) async* {
    if (event is ForgotPasswordEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is RequestForgotPasswordEvent) {
      yield* _mapRequestForgotPasswordRequestedToState(event, state);
    }
  }

  ForgotPasswordState _mapEmailChangedToState(
    ForgotPasswordEmailChanged event,
    ForgotPasswordState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      action: Formz.validate([state.email]),
      status: FormzStatus.pure,
      error: null,
    );
  }

  Stream<ForgotPasswordState> _mapRequestForgotPasswordRequestedToState(
    RequestForgotPasswordEvent event,
    ForgotPasswordState state,
  ) async* {
    if (state.action.isValidated) {
      yield state.copyWith(
          status: FormzStatus.submissionInProgress,
          action: FormzStatus.submissionInProgress);
      try {
        String verificationId = await _authService.requestForgotPassword(
          email: state.email.value,
        );
        yield state.copyWith(
          status: FormzStatus.submissionSuccess,
          action: FormzStatus.submissionSuccess,
          error: null,
          verificationId: verificationId,
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
