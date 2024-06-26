import 'package:formz/formz.dart';

enum NameValidationError { empty, invalid }

class MotherName extends FormzInput<String, NameValidationError> {
  const MotherName.pure() : super.pure('');
  const MotherName.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) {
      return NameValidationError.empty;
    } else if (value.length < 3) {
      return NameValidationError.invalid;
    } else {
      return null;
    }
  }

  static String? showMotherNameErrorMessage(NameValidationError? error) {
    if (error == NameValidationError.empty) {
      return 'Numele este gol';
    } else if (error == NameValidationError.invalid) {
      return 'Numele este prea scurt';
    } else {
      return null;
    }
  }
}
