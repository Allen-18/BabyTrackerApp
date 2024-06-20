import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tracker/authentication/domain/user.dart';

part 'auth_repo.g.dart';

enum SignInError {
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
}

enum SignUpError {
  weakPassword,
  operationNotAllowed,
  invalidEmail,
  emailAlreadyInUse,
}

enum ForgotPasswordError {
  invalidEmail,
  userNotFound,
}

enum SignOutError {
  signOutFailed,
}

class SignUpWithEmailAndPasswordFailure implements Exception {
  final SignUpError error;
  const SignUpWithEmailAndPasswordFailure(this.error);
}

class SignInWithEmailAndPasswordFailure implements Exception {
  final SignInError error;
  const SignInWithEmailAndPasswordFailure(this.error);
}

class ForgotPasswordFailure implements Exception {
  final ForgotPasswordError error;
  const ForgotPasswordFailure(this.error);
}

class SignOutFailure implements Exception {
  final SignOutError error;
  const SignOutFailure(this.error);
}

class AuthenticationRepository {
  final _firebaseAuth = fa.FirebaseAuth.instance;

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      fa.UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User newUser = User(
        email: email,
        isActive: false,
        creationDate: DateTime.now().toUtc(),
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(newUser.toJson());
    } on fa.FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw const SignUpWithEmailAndPasswordFailure(
              SignUpError.weakPassword);
        case 'operation-not-allowed':
          throw const SignUpWithEmailAndPasswordFailure(
              SignUpError.operationNotAllowed);
        case 'invalid-email':
          throw const SignUpWithEmailAndPasswordFailure(
              SignUpError.invalidEmail);
        case 'email-already-in-use':
          throw const SignUpWithEmailAndPasswordFailure(
              SignUpError.emailAlreadyInUse);
        default:
          throw const SignUpWithEmailAndPasswordFailure(
              SignUpError.invalidEmail);
      }
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on fa.FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw const SignInWithEmailAndPasswordFailure(
              SignInError.userNotFound);
        case 'wrong-password':
          throw const SignInWithEmailAndPasswordFailure(
              SignInError.wrongPassword);
        case 'invalid-email':
          throw const SignInWithEmailAndPasswordFailure(
              SignInError.invalidEmail);
        case 'user-disabled':
          throw const SignInWithEmailAndPasswordFailure(
              SignInError.userDisabled);
        default:
          throw const SignInWithEmailAndPasswordFailure(
              SignInError.invalidEmail);
      }
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on fa.FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw const ForgotPasswordFailure(ForgotPasswordError.invalidEmail);
        case 'user-not-found':
          throw const ForgotPasswordFailure(ForgotPasswordError.userNotFound);
        default:
          throw const ForgotPasswordFailure(ForgotPasswordError.invalidEmail);
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw const SignOutFailure(SignOutError.signOutFailed);
    }
  }

  // This getter will be returning a Stream of User object.
  // It will be used to check if the user is logged in or not.
  Stream<fa.User?> get authStateChange => _firebaseAuth.authStateChanges();
}

final authInstance = AuthenticationRepository();

@riverpod
Stream<fa.User?> authStateChange(AuthStateChangeRef ref) {
  return authInstance.authStateChange;
}
