import 'package:formz/formz.dart';

enum NumberValidationError { invalid }

class Number extends FormzInput<String, NumberValidationError> {
  const Number.pure([String value = '']) : super.pure(value);
  const Number.dirty([String value = '']) : super.dirty(value);

  static final RegExp _numberRegExp = RegExp(
    r'^\d$',
  );

  @override
  NumberValidationError validator(String value) {
    return _numberRegExp.hasMatch(value) ? null : NumberValidationError.invalid;
  }
}
