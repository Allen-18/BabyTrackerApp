import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tracker/services/collections.dart';
import 'kids.dart';

part 'kids_repository.g.dart';

class KidsRepository {
  KidsRepository();

  Future<void> createNewKid(Kid kid) async {
    try {
      await kidsCollection().add(kid);
      if (kDebugMode) {
        print("Kid added successfully");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error adding kid: $e");
      }
      throw Exception('Failed to create new kid');
    }
  }

  Future<void> updateKid(Kid kid) async {
    if (kid.id == null) {
      return;
    }
    try {
      await kidsCollection().doc(kid.id).set(kid);
      if (kDebugMode) {
        print("Kid updated successfully");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error updating kid: $e");
      }
      throw Exception('Failed to update kid');
    }
  }

  Future<Kid?> getKid(String? uid) async {
    if (uid == null) {
      return null;
    }
    final kid = await kidsCollection().doc(uid).get();
    if (kid.exists) {
      final k = kid.data();

      if (kDebugMode) {
        print('$k');
      }
    }
    if (kDebugMode) {
      print(
          'Get kid by id failed because the document does not exist in firestore');
    }
    return null;
  }
}

@riverpod
KidsRepository kidsRepository(KidsRepositoryRef ref) => KidsRepository();

@riverpod
Future<Kid?> getKid(GetKidRef ref, {required String? id}) {
  return ref.watch(kidsRepositoryProvider).getKid(id);
}
