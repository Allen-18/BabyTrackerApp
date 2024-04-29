import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validators/form_validators.dart';
import 'package:tracker/authentication/auth/auth_repo.dart';
import 'package:tracker/authentication/repository/auth_repo_provider.dart';
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

  Future<FirebaseException?> signInWithEmailAndPassword() async {
    state = state.copyWith(status: FormzSubmissionStatus.inProgress);
    try {
      await _authenticationRepository.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      state = state.copyWith(status: FormzSubmissionStatus.success);
      return null;
    } catch (e) {
      String errorMessage = 'An unexpected error occurred.';
      FirebaseException? exceptionToReturn;
      if (e is SignInWithEmailAndPasswordFailure) {
        errorMessage = e.code;
        exceptionToReturn =
            FirebaseException(plugin: 'Authentication', message: errorMessage);
      }
      state = state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: errorMessage);
      return exceptionToReturn;
    }
  }
}
