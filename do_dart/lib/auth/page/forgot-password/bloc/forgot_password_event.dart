part of 'forgot_password_bloc.dart';

class ForgotPasswordNewPasswordChanged extends CommonEvent {
  const ForgotPasswordNewPasswordChanged(this.newPassword);

  final String newPassword;

  @override
  List<Object> get props => [newPassword];
}

class ForgotPasswordConfirmPasswordChanged extends CommonEvent {
  const ForgotPasswordConfirmPasswordChanged(this.confirmPassword);

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

class ForgotPasswordEvent extends CommonEvent {
  const ForgotPasswordEvent();
}
