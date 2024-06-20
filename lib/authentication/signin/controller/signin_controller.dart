import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:tracker/authentication/repository/auth_repo_provider.dart';
import 'package:tracker/authentication/repository/auth_repo.dart';
part 'signin_state.dart';

final signInProvider = StateNotifierProvider<SignInController, SignInState>(
  (ref) => SignInController(ref.watch(authRepoProvider)),
);

class SignInController extends StateNotifier<SignInState> {
  final AuthenticationRepository _authenticationRepository;
  SignInController(this._authenticationRepository) : super(const SignInState());
  void onEmailChange(String value) {
    final email = Email.dirty(value);
    final isValid = Formz.validate(
      [email, state.password],
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

  Future<String?> signInWithEmailAndPassword() async {
    state = state.copyWith(status: FormzSubmissionStatus.inProgress);
    try {
      await _authenticationRepository.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      state = state.copyWith(status: FormzSubmissionStatus.success);
      return null;
    } catch (e) {
      String errorMessage = 'A apărut o eroare neașteptată.';

      if (e is SignInWithEmailAndPasswordFailure) {
        switch (e.error) {
          case SignInError.userNotFound:
            errorMessage = 'Nu a fost găsit niciun utilizator cu acest email.';
            break;
          case SignInError.wrongPassword:
            errorMessage = 'Parolă incorectă.';
            break;
          case SignInError.invalidEmail:
            errorMessage = 'Adresa de email nu este validă.';
            break;
          case SignInError.userDisabled:
            errorMessage = 'Contul de utilizator a fost dezactivat.';
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
