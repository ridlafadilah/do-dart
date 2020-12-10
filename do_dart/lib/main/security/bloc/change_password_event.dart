part of 'change_password_bloc.dart';

class OldPasswordChanged extends CommonEvent {
  const OldPasswordChanged(this.oldPassword);

  final String oldPassword;

  @override
  List<Object> get props => [oldPassword];
}

class NewPasswordChanged extends CommonEvent {
  const NewPasswordChanged(this.newPassword);

  final String newPassword;

  @override
  List<Object> get props => [newPassword];
}

class ConfirmPasswordChanged extends CommonEvent {
  const ConfirmPasswordChanged(this.confirmPassword);

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}
