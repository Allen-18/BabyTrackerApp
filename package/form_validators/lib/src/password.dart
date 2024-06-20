import 'package:formz/formz.dart';

enum PasswordValidationError {
  empty,
  tooShort,
  noUppercase,
  noLowercase,
  noNumber,
  noSpecialCharacter
}

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (value.length < 8) {
      return PasswordValidationError.tooShort;
    } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return PasswordValidationError.noUppercase;
    } else if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
      return PasswordValidationError.noLowercase;
    } else if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
      return PasswordValidationError.noNumber;
    } else if (!RegExp(r'(?=.*[@$!%*?&])').hasMatch(value)) {
      return PasswordValidationError.noSpecialCharacter;
    } else {
      return null;
    }
  }

  static String? showPasswordErrorMessage(PasswordValidationError? error) {
    switch (error) {
      case PasswordValidationError.empty:
        return 'Parola este goală';
      case PasswordValidationError.tooShort:
        return 'Parola este prea scurtă, trebuie să aibă cel puțin 8 caractere';
      case PasswordValidationError.noUppercase:
        return 'Parola trebuie să conțină cel puțin o literă mare';
      case PasswordValidationError.noLowercase:
        return 'Parola trebuie să conțină cel puțin o literă mică';
      case PasswordValidationError.noNumber:
        return 'Parola trebuie să conțină cel puțin un număr';
      case PasswordValidationError.noSpecialCharacter:
        return 'Parola trebuie să conțină cel puțin un caracter special (@, !, %, *, ?, &)';
      default:
        return null;
    }
  }
}
