part of 'forgot_password_bloc.dart';

class ForgotPasswordEmailChanged extends CommonEvent {
  const ForgotPasswordEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class RequestForgotPasswordEvent extends CommonEvent {
  const RequestForgotPasswordEvent();
}
