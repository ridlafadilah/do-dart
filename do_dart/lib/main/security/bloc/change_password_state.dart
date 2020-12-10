part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.status = FormzStatus.pure,
    this.action = FormzStatus.pure,
    this.oldPassword = const Password.pure(),
    this.newPassword = const NewPassword.pure(),
    this.confirmPassword = const ConfirmedPassword.pure(),
  });

  final FormzStatus status;
  final FormzStatus action;
  final Password oldPassword;
  final NewPassword newPassword;
  final ConfirmedPassword confirmPassword;

  ChangePasswordState copyWith({
    FormzStatus status,
    FormzStatus action,
    Password oldPassword,
    NewPassword newPassword,
    ConfirmedPassword confirmPassword,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      action: action ?? this.action,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object> get props =>
      [status, action, oldPassword, newPassword, confirmPassword];
}
