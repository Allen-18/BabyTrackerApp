import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:tracker/authentication/repository/auth_repo_provider.dart';
import 'package:tracker/authentication/repository/auth_repo.dart';

part 'forgot_password_state.dart';

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordController, ForgotPasswordState>(
  (ref) => ForgotPasswordController(
    ref.watch(authRepoProvider),
  ),
);

class ForgotPasswordController extends StateNotifier<ForgotPasswordState> {
  final AuthenticationRepository _authenticationRepository;

  ForgotPasswordController(this._authenticationRepository)
      : super(const ForgotPasswordState());

  void onEmailChange(String value) {
    final email = Email.dirty(value);
    final isValid = Formz.validate([email]);
    FormzSubmissionStatus newStatus =
        isValid ? FormzSubmissionStatus.success : FormzSubmissionStatus.failure;

    state = state.copyWith(email: email, status: newStatus);
  }

  Future<void> forgotPassword() async {
    if (!state.status.isSuccess) return;
    state = state.copyWith(status: FormzSubmissionStatus.inProgress);
    try {
      await _authenticationRepository.forgotPassword(email: state.email.value);
      state = state.copyWith(status: FormzSubmissionStatus.success);
    } on ForgotPasswordFailure catch (e) {
      String errorMessage = 'A apărut o eroare neașteptată.';
      switch (e.error) {
        case ForgotPasswordError.invalidEmail:
          errorMessage = 'Adresa de email nu este validă.';
          break;
        case ForgotPasswordError.userNotFound:
          errorMessage = 'Nu a fost găsit niciun utilizator cu acest email.';
          break;
        default:
          errorMessage = 'A apărut o eroare neașteptată.';
      }
      state = state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: errorMessage);
    }
  }
}
