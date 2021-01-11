part of 'verification_forgot_password_bloc.dart';

class VerificationForgotPasswordState extends Equatable {
  const VerificationForgotPasswordState({
    this.error = '',
    this.status = FormzStatus.pure,
    this.action = FormzStatus.pure,
    this.verificationId = '',
    this.verificationCode = const Number.pure(),
  });

  final String error;
  final FormzStatus status;
  final FormzStatus action;
  final String verificationId;
  final Number verificationCode;

  VerificationForgotPasswordState copyWith({
    String error,
    FormzStatus status,
    FormzStatus action,
    String verificationId,
    Number verificationCode,
  }) {
    return VerificationForgotPasswordState(
      error: error ?? this.error,
      status: status ?? this.status,
      action: action ?? this.action,
      verificationId: verificationId ?? this.verificationId,
      verificationCode: verificationCode ?? this.verificationCode,
    );
  }

  @override
  List<Object> get props => [status, action, verificationId, verificationCode];
}
