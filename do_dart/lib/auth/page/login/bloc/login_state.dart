part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.error = '',
    this.status = FormzStatus.pure,
    this.action = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });

  final String error;
  final FormzStatus status;
  final FormzStatus action;
  final Username username;
  final Password password;

  LoginState copyWith({
    String error,
    FormzStatus status,
    FormzStatus action,
    Username username,
    Password password,
  }) {
    return LoginState(
      error: error ?? this.error,
      status: status ?? this.status,
      action: action ?? this.action,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, action, username, password];
}
