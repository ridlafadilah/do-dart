import 'package:formz/formz.dart';

enum NameValidationError { empty, length }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError validator(String value) {
    if (value?.isNotEmpty == true) {
      if (value.length >= 5) {
        return null;
      } else {
        return NameValidationError.length;
      }
    } else {
      return NameValidationError.empty;
    }
  }
}
