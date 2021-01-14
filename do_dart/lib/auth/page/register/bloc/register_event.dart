part of 'register_bloc.dart';

class RegisterFullnameChanged extends CommonEvent {
  const RegisterFullnameChanged(this.fullname);

  final String fullname;

  @override
  List<Object> get props => [fullname];
}

class RegisterUsernameChanged extends CommonEvent {
  const RegisterUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class RegisterEmailChanged extends CommonEvent {
  const RegisterEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class RegisterPasswordChanged extends CommonEvent {
  const RegisterPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RegisterConfirmPasswordChanged extends CommonEvent {
  const RegisterConfirmPasswordChanged(this.confirmPassword);

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

class RegisterCaptchaChanged extends CommonEvent {
  const RegisterCaptchaChanged(this.captcha);

  final String captcha;

  @override
  List<Object> get props => [captcha];
}

class RegisterEvent extends CommonEvent {
  const RegisterEvent();
}
