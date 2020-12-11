import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<CommonEvent, ChangePasswordState> {
  ChangePasswordBloc({@required AuthService authService})
      : assert(authService != null),
        _authService = authService,
        super(const ChangePasswordState());

  final AuthService _authService;

  @override
  Stream<ChangePasswordState> mapEventToState(
    CommonEvent event,
  ) async* {
    if (event is OldPasswordChanged) {
      yield _mapOldPasswordToState(event, state);
    } else if (event is NewPasswordChanged) {
      yield _mapNewPasswordToState(event, state);
    } else if (event is ConfirmPasswordChanged) {
      yield _mapConfirmPasswordToState(event, state);
    } else if (event is SubmittedEvent) {
      yield* _mapChangePasswordSubmittedToState(event, state);
    }
  }

  ChangePasswordState _mapOldPasswordToState(
    OldPasswordChanged event,
    ChangePasswordState state,
  ) {
    final oldPassword = Password.dirty(event.oldPassword);
    return state.copyWith(
      oldPassword: oldPassword,
      action: Formz.validate(
          [oldPassword, state.newPassword, state.confirmPassword]),
    );
  }

  ChangePasswordState _mapNewPasswordToState(
    NewPasswordChanged event,
    ChangePasswordState state,
  ) {
    final newPassword = NewPassword.dirty(event.newPassword);
    return state.copyWith(
      newPassword: newPassword,
      action: Formz.validate(
          [state.oldPassword, newPassword, state.confirmPassword]),
    );
  }

  ChangePasswordState _mapConfirmPasswordToState(
    ConfirmPasswordChanged event,
    ChangePasswordState state,
  ) {
    final confirmPassword = ConfirmedPassword.dirty(
        password: state.newPassword.value, value: event.confirmPassword);
    return state.copyWith(
      confirmPassword: confirmPassword,
      action: Formz.validate(
          [state.oldPassword, state.newPassword, confirmPassword]),
    );
  }

  Stream<ChangePasswordState> _mapChangePasswordSubmittedToState(
    SubmittedEvent event,
    ChangePasswordState state,
  ) async* {
    if (state.action.isValidated) {
      yield state.copyWith(
          status: FormzStatus.submissionInProgress,
          action: FormzStatus.submissionInProgress);
      try {
        ChangePasswordService changePasswordService =
            ChangePasswordService(authService: _authService);
        await changePasswordService
            .changePassword(
          password: state.oldPassword.value,
          newPassword: state.newPassword.value,
          confirmPassword: state.confirmPassword.value,
        )
            .then((value) async {
          await _authService.logOut();
        });
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
