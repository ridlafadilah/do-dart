part of 'request_forgot_password_bloc.dart';

class RequestForgotPasswordState extends Equatable {
  const RequestForgotPasswordState({
    this.error = '',
    this.status = FormzStatus.pure,
    this.action = FormzStatus.pure,
    this.email = const Email.pure(),
    this.verificationId = '',
  });

  final String error;
  final FormzStatus status;
  final FormzStatus action;
  final Email email;
  final String verificationId;

  RequestForgotPasswordState copyWith({
    String error,
    FormzStatus status,
    FormzStatus action,
    Email email,
    String verificationId,
  }) {
    return RequestForgotPasswordState(
      error: error ?? this.error,
      status: status ?? this.status,
      action: action ?? this.action,
      email: email ?? this.email,
      verificationId: verificationId ?? this.verificationId,
    );
  }

  @override
  List<Object> get props => [status, action, email, verificationId];
}
