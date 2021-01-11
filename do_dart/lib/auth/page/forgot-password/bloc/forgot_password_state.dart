part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.error = '',
    this.status = FormzStatus.pure,
    this.action = FormzStatus.pure,
    this.email = const Email.pure(),
    this.verificationId = '',
    this.verificationCode = '',
    this.newPassword = const NewPassword.pure(),
    this.confirmPassword = const ConfirmedPassword.pure(),
  });

  final String error;
  final FormzStatus status;
  final FormzStatus action;
  final Email email;
  final String verificationId;
  final String verificationCode;
  final NewPassword newPassword;
  final ConfirmedPassword confirmPassword;

  ForgotPasswordState copyWith({
    String error,
    FormzStatus status,
    FormzStatus action,
    Email email,
    String verificationId,
    String verificationCode,
    NewPassword newPassword,
    ConfirmedPassword confirmPassword,
  }) {
    return ForgotPasswordState(
      error: error ?? this.error,
      status: status ?? this.status,
      action: action ?? this.action,
      email: email ?? this.email,
      verificationId: verificationId ?? this.verificationId,
      verificationCode: verificationCode ?? this.verificationCode,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object> get props => [
        status,
        action,
        email,
        verificationId,
        verificationCode,
        newPassword,
        confirmPassword
      ];
}
