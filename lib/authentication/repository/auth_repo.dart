import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tracker/authentication/domain/user.dart';

part 'auth_repo.g.dart';

class SignUpWithEmailAndPasswordFailure implements Exception {
  final String code;
  const SignUpWithEmailAndPasswordFailure(this.code);
}

class SignInWithEmailAndPasswordFailure implements Exception {
  final String code;
  const SignInWithEmailAndPasswordFailure(this.code);
}

class ForgotPasswordFailure implements Exception {
  final String code;
  const ForgotPasswordFailure(this.code);
}

class SignOutFailure implements Exception {}

class AuthenticationRepository {
  final _firebaseAuth = fa.FirebaseAuth.instance;

  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
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
      throw SignUpWithEmailAndPasswordFailure(e.code);
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
      throw SignInWithEmailAndPasswordFailure(e.code);
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on fa.FirebaseAuthException catch (e) {
      throw ForgotPasswordFailure(e.code);
    }
  }

  //  This getter will be returning a Stream of User object.
  //  It will be used to check if the user is logged in or not.
  Stream<fa.User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      throw SignOutFailure();
    }
  }
}

final authInstance = AuthenticationRepository();

@riverpod
Stream<fa.User?> authStateChange(AuthStateChangeRef ref) {
  return authInstance.authStateChange;
}
