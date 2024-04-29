import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError { empty, mismatch }

class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  final String password;

  const ConfirmPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return ConfirmPasswordValidationError.empty;
    } else if (value != password) {
      return ConfirmPasswordValidationError.mismatch;
    } else {
      return null;
    }
  }

  static String? showConfirmPasswordErrorMessage(
      ConfirmPasswordValidationError? error) {
    if (error == ConfirmPasswordValidationError.empty) {
      return 'Confirm password is required';
    } else if (error == ConfirmPasswordValidationError.mismatch) {
      return 'Passwords do not match';
    } else {
      return null;
    }
  }
}
