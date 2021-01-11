import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_common/common.dart';
import 'package:do_core/core.dart';
import 'package:do_core/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'request_forgot_password_event.dart';
part 'request_forgot_password_state.dart';

class RequestForgotPasswordBloc
    extends Bloc<CommonEvent, RequestForgotPasswordState> {
  RequestForgotPasswordBloc({
    @required AuthService authService,
  })  : assert(authService != null),
        _authService = authService,
        super(const RequestForgotPasswordState());

  final AuthService _authService;

  @override
  Stream<RequestForgotPasswordState> mapEventToState(
    CommonEvent event,
  ) async* {
    if (event is RequestEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is RequestForgotPasswordEvent) {
      yield* _mapRequestForgotPasswordRequestedToState(event, state);
    }
  }

  RequestForgotPasswordState _mapEmailChangedToState(
    RequestEmailChanged event,
    RequestForgotPasswordState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      action: Formz.validate([email]),
      status: FormzStatus.pure,
      error: null,
    );
  }

  Stream<RequestForgotPasswordState> _mapRequestForgotPasswordRequestedToState(
    RequestForgotPasswordEvent event,
    RequestForgotPasswordState state,
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
