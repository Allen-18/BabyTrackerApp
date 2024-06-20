import 'package:formz/formz.dart';

enum TwinValidationError { empty, invalid }

class TwinName extends FormzInput<String, TwinValidationError> {
  const TwinName.pure() : super.pure('');
  const TwinName.dirty([String value = '']) : super.dirty(value);

  @override
  TwinValidationError? validator(String value) {
    if (value.isEmpty) {
      return TwinValidationError.empty;
    } else if (value.length < 3) {
      return TwinValidationError.invalid;
    } else {
      return null;
    }
  }

  static String? showTwinNameErrorMessage(TwinValidationError? error) {
    if (error == TwinValidationError.empty) {
      return 'Numele este gol';
    } else if (error == TwinValidationError.invalid) {
      return 'Numele este prea scurt';
    } else {
      return null;
    }
  }
}
