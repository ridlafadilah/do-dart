import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

enum PasswordValidationError { empty, invalid, notEquals }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : PasswordValidationError.empty;
  }
}

class NewPassword extends FormzInput<String, PasswordValidationError> {
  const NewPassword.pure() : super.pure('');
  const NewPassword.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegExp =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]{8,}$');

  @override
  PasswordValidationError validator(String value) {
    return _passwordRegExp.hasMatch(value)
        ? null
        : PasswordValidationError.invalid;
  }
}

class ConfirmedPassword extends FormzInput<String, PasswordValidationError> {
  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmedPassword.dirty({@required this.password, String value = ''})
      : super.dirty(value);

  final String password;

  @override
  PasswordValidationError validator(String value) {
    if (value?.isNotEmpty == true) {
      return password == value ? null : PasswordValidationError.notEquals;
    } else {
      return PasswordValidationError.empty;
    }
  }
}
