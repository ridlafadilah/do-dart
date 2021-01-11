part of 'request_forgot_password_bloc.dart';

class RequestEmailChanged extends CommonEvent {
  const RequestEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class RequestForgotPasswordEvent extends CommonEvent {
  const RequestForgotPasswordEvent();
}
