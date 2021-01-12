part of 'verification_forgot_password_bloc.dart';

class VerificationForgotPasswordState extends Equatable {
  const VerificationForgotPasswordState({
    this.error = '',
    this.status = FormzStatus.pure,
    this.action = FormzStatus.pure,
    this.resend = FormzStatus.pure,
    this.email = '',
    this.verificationId = '',
    this.verificationCode = const Number.pure(),
  });

  final String error;
  final FormzStatus status;
  final FormzStatus action;
  final FormzStatus resend;
  final String email;
  final String verificationId;
  final Number verificationCode;

  VerificationForgotPasswordState copyWith({
    String error,
    FormzStatus status,
    FormzStatus action,
    FormzStatus resend,
    String email,
    String verificationId,
    Number verificationCode,
  }) {
    return VerificationForgotPasswordState(
      error: error ?? this.error,
      status: status ?? this.status,
      action: action ?? this.action,
      resend: resend ?? this.resend,
      email: email ?? this.email,
      verificationId: verificationId ?? this.verificationId,
      verificationCode: verificationCode ?? this.verificationCode,
    );
  }

  @override
  List<Object> get props =>
      [status, action, resend, email, verificationId, verificationCode];
}
