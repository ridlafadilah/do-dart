part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.error = '',
    this.status = FormzStatus.pure,
    this.action = FormzStatus.pure,
    this.fullname = const Name.pure(),
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const NewPassword.pure(),
    this.confirmPassword = const ConfirmedPassword.pure(),
    this.terms = const TextForm.pure(),
    this.captcha = const TextForm.pure(),
  });

  final String error;
  final FormzStatus status;
  final FormzStatus action;
  final Name fullname;
  final Username username;
  final Email email;
  final NewPassword password;
  final ConfirmedPassword confirmPassword;
  final TextForm terms;
  final TextForm captcha;

  RegisterState copyWith({
    String error,
    FormzStatus status,
    FormzStatus action,
    Name fullname,
    Username username,
    Email email,
    NewPassword password,
    ConfirmedPassword confirmPassword,
    TextForm terms,
    TextForm captcha,
  }) {
    return RegisterState(
      error: error ?? this.error,
      status: status ?? this.status,
      action: action ?? this.action,
      fullname: fullname ?? this.fullname,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      terms: terms ?? this.terms,
      captcha: captcha ?? this.captcha,
    );
  }

  @override
  List<Object> get props => [
        status,
        action,
        fullname,
        username,
        email,
        password,
        confirmPassword,
        terms,
        captcha,
      ];
}
