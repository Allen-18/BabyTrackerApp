import 'package:formz/formz.dart';

enum ChildValidationError { empty, invalid }

class ChildName extends FormzInput<String, ChildValidationError> {
  const ChildName.pure() : super.pure('');
  const ChildName.dirty([String value = '']) : super.dirty(value);

  @override
  ChildValidationError? validator(String value) {
    if (value.isEmpty) {
      return ChildValidationError.empty;
    } else if (value.length < 3) {
      return ChildValidationError.invalid;
    } else {
      return null;
    }
  }

  static String? showChildNameErrorMessage(ChildValidationError? error) {
    if (error == ChildValidationError.empty) {
      return 'Numele este gol';
    } else if (error == ChildValidationError.invalid) {
      return 'Numele este prea scurt';
    } else {
      return null;
    }
  }
}
