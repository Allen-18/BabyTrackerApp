import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tracker/authentication/repository/collections.dart';
import 'auth_repo.dart';
import 'domain/user.dart';

part 'users.g.dart';

class UsersRepository {
  UsersRepository();

  Stream<User?> getUserStream(String? uid) {
    if (uid == null) {
      return const Stream.empty();
    }

    final userStream = userCollection().doc(uid).snapshots().map((querySnap) {
      final usr = querySnap.data();
      if (kDebugMode) {
        print('$usr');
      }
      return querySnap.data();
    });

    return userStream;
  }

  Stream<User?> getCurrentUserStream() {
    final uid = fa.FirebaseAuth.instance.currentUser?.uid;
    if (kDebugMode) {
      print('$uid');
    }
    return getUserStream(uid);
  }

  Future<User?> getUser(String? uid) async {
    if (uid == null) {
      return null;
    }
    final user = await userCollection().doc(uid).get();
    if (user.exists) {
      final usr = user.data();

      if (kDebugMode) {
        print('$usr');
      }
    }
    if (kDebugMode) {
      print(
          'Get user by id failed because the document does not exist in firestore');
    }
    return null;
  }

  Future<User?> getCurrentUser() async {
    final uid = fa.FirebaseAuth.instance.currentUser?.uid;
    return getUser(uid);
  }

  Future<void> createUser(User user) async {
    if (fa.FirebaseAuth.instance.currentUser?.uid == null) {
      throw Exception("createUser | user is not authenticated with firebase");
    }
    await userCollection().add(user);
    if (kDebugMode) {
      print('Create user ${user.name}');
    }
  }

  Future<void> updateUser(User user) async {
    if (user.id == null) {
      return;
    }
    await userCollection().doc(user.id).set(user);
    if (kDebugMode) {
      print('Updated user ${user.name}');
    }
  }

  Future<void> deleteUser(String documentId) async {
    try {
      await userCollection().doc(documentId).delete();
      if (kDebugMode) {
        print('Document $documentId deleted successfully!');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to delete document $documentId: $e');
      }
    }
  }
}

@riverpod
UsersRepository usersRepository(UsersRepositoryRef ref) => UsersRepository();

@riverpod
Future<User?> getUser(GetUserRef ref, {required String? id}) {
  return UsersRepository().getUser(id);
}

@riverpod
Future<User?> getCurrentUser(GetCurrentUserRef ref) async {
  ref.watch(authStateChangeProvider);
  return await UsersRepository().getCurrentUser();
}

@Riverpod(keepAlive: true)
Stream<User?> getCurrentUserStream(GetCurrentUserStreamRef ref) {
  if (kDebugMode) {
    print('Starting stream ...');
  }
  ref.onDispose(
      () => ('getCurrentUserStream, Disposed provider: getCurrentUserStream'));
  return UsersRepository().getCurrentUserStream();
}

@riverpod
Stream<User?> getUserStream(GetUserStreamRef ref, {String? uid}) {
  return UsersRepository().getUserStream(uid);
}
