import 'package:form_validators/form_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:tracker/authentication/repository/auth_repo_provider.dart';
import 'package:tracker/authentication/repository/auth_repo.dart';

part 'signup_state.dart';

final signUpProvider = StateNotifierProvider<SignUpController, SignUpState>(
  (ref) => SignUpController(ref.watch(authRepoProvider)),
);

class SignUpController extends StateNotifier<SignUpState> {
  final AuthenticationRepository _authenticationRepository;
  SignUpController(this._authenticationRepository) : super(const SignUpState());
  void onEmailChange(String value) {
    final email = Email.dirty(value);
    final isValid = Formz.validate(
      [
        email,
        state.password,
      ],
    );
    FormzSubmissionStatus newStatus =
        isValid ? FormzSubmissionStatus.success : FormzSubmissionStatus.failure;

    state = state.copyWith(
      email: email,
      status: newStatus,
    );
  }

  void onPasswordChange(String value) {
    final password = Password.dirty(value);
    final isValid = Formz.validate(
      [
        state.email,
        password,
      ],
    );
    FormzSubmissionStatus newStatus =
        isValid ? FormzSubmissionStatus.success : FormzSubmissionStatus.failure;

    state = state.copyWith(
      password: password,
      status: newStatus,
    );
  }

  void onConfirmPasswordChange(String value) {
    final confirmPassword =
        ConfirmPassword.dirty(password: state.password.value, value: value);
    FormzSubmissionStatus newStatus = Formz.validate([
      state.email,
      state.password,
      confirmPassword,
    ])
        ? FormzSubmissionStatus.success
        : FormzSubmissionStatus.failure;

    state = state.copyWith(
      confirmPassword: confirmPassword,
      status: newStatus,
    );
  }

  Future<String?> signUpWithEmailAndPassword() async {
    state = state.copyWith(status: FormzSubmissionStatus.inProgress);
    try {
      await _authenticationRepository.signUpWithEmailAndPassword(
          email: state.email.value, password: state.password.value);
      state = state.copyWith(status: FormzSubmissionStatus.success);
      return null;
    } catch (e) {
      String errorMessage = 'An unexpected error occurred.';

      if (e is SignUpWithEmailAndPasswordFailure) {
        switch (e.error) {
          case SignUpError.weakPassword:
            errorMessage = 'Parola furnizată este prea slabă.';
            break;
          case SignUpError.emailAlreadyInUse:
            errorMessage = 'Există deja un cont cu acest email.';
            break;
          case SignUpError.invalidEmail:
            errorMessage = 'Adresa de email nu este validă.';
            break;
          case SignUpError.operationNotAllowed:
            errorMessage =
                'Operațiunea nu este permisă. Vă rugăm să contactați suportul.';
            break;
          default:
            errorMessage = 'A apărut o eroare neașteptată.';
        }
      }

      state = state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: errorMessage);
      return errorMessage;
    }
  }
}
