part of 'verification_forgot_password_bloc.dart';

class VerificationCodeChanged extends CommonEvent {
  const VerificationCodeChanged(this.verificationCode);

  final String verificationCode;

  @override
  List<Object> get props => [verificationCode];
}

class VerificationForgotPasswordEvent extends CommonEvent {
  const VerificationForgotPasswordEvent();
}
