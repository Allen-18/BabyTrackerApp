import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tracker/features/common/utils/utils.dart';
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

  Future<void> updateMotorSkillsKid(Kid kid) async {
    if (kid.id == null) {
      if (kDebugMode) {
        print("Error: Kid ID is null.");
      }
      return;
    }
    try {
      // Convert each KidSkills object to a map right before saving
      var motorSkillsMap =
          kid.motorSkills.map((skill) => skill.toJson()).toList();
      await kidsCollection()
          .doc(kid.id)
          .update({'motorSkills': motorSkillsMap});
      if (kDebugMode) {
        print("Kid updated successfully");
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print("Error updating kid: $e");
        print("Stacktrace: $stacktrace");
      }
      throw Exception('Failed to update kid: $e');
    }
  }

  Future<void> updateCognitiveSkillsKid(Kid kid) async {
    if (kid.id == null) {
      if (kDebugMode) {
        print("Error: Kid ID is null.");
      }
      return;
    }
    try {
      var cognitiveSkillsMap =
          kid.cognitiveSkills.map((skill) => skill.toJson()).toList();
      await kidsCollection()
          .doc(kid.id)
          .update({'cognitiveSkills': cognitiveSkillsMap});
      if (kDebugMode) {
        print("Kid updated successfully");
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print("Error updating kid: $e");
        print("Stacktrace: $stacktrace");
      }
      throw Exception('Failed to update kid: $e');
    }
  }

  Future<void> updateSocialSkillsKid(Kid kid) async {
    if (kid.id == null) {
      if (kDebugMode) {
        print("Error: Kid ID is null.");
      }
      return;
    }
    try {
      // Convert each KidSkills object to a map right before saving
      var socialSkillsMap =
          kid.socialSkills.map((skill) => skill.toJson()).toList();
      await kidsCollection()
          .doc(kid.id)
          .update({'socialSkills': socialSkillsMap});
      if (kDebugMode) {
        print("Kid updated successfully");
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print("Error updating kid: $e");
        print("Stacktrace: $stacktrace");
      }
      throw Exception('Failed to update kid: $e');
    }
  }

  Future<void> updateLinguisticSkillsKid(Kid kid) async {
    if (kid.id == null) {
      if (kDebugMode) {
        print("Error: Kid ID is null.");
      }
      return;
    }
    try {
      // Convert each KidSkills object to a map right before saving
      var linguisticSkillsMap =
          kid.socialSkills.map((skill) => skill.toJson()).toList();
      await kidsCollection()
          .doc(kid.id)
          .update({'linguisticSkills': linguisticSkillsMap});
      if (kDebugMode) {
        print("Kid updated successfully");
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print("Error updating kid: $e");
        print("Stacktrace: $stacktrace");
      }
      throw Exception('Failed to update kid: $e');
    }
  }

  Future<void> updateWeightMeasurementsForKid(Kid kid) async {
    if (kid.id == null) {
      if (kDebugMode) {
        print("Error: Kid ID is null.");
      }
      return;
    }
    try {
      var weightMeasurementsMap =
          kid.weightMeasurements.map((weight) => weight.toJson()).toList();
      await kidsCollection()
          .doc(kid.id)
          .update({'weightMeasurements': weightMeasurementsMap});
      if (kDebugMode) {
        print("Kid updated successfully");
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print("Error updating kid: $e");
        print("Stacktrace: $stacktrace");
      }
      throw Exception('Failed to update kid: $e');
    }
  }

  Future<void> updateHeadMeasurementsForKid(Kid kid) async {
    if (kid.id == null) {
      if (kDebugMode) {
        print("Error: Kid ID is null.");
      }
      return;
    }
    try {
      var headMeasurementsMap = kid.headCircumferenceMeasurements
          .map((head) => head.toJson())
          .toList();
      await kidsCollection()
          .doc(kid.id)
          .update({'headCircumferenceMeasurements': headMeasurementsMap});
      if (kDebugMode) {
        print("Kid updated successfully");
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print("Error updating kid: $e");
        print("Stacktrace: $stacktrace");
      }
      throw Exception('Failed to update kid: $e');
    }
  }

  Future<Kid?> getKid(String? uid) async {
    if (uid == null) {
      if (kDebugMode) {
        print('UID is null, returning null');
      }
      return null;
    }

    final kidDocument = await kidsCollection().doc(uid).get();

    if (kidDocument.exists) {
      final kidData = kidDocument.data();
      if (kDebugMode) {
        print('Retrieved kid data: $kidData');
      }
      return kidData;
    } else {
      if (kDebugMode) {
        print(
            'Get kid by id failed because the document does not exist in Firestore');
      }
      return null;
    }
  }

  Future<void> updateKid(Kid kid) async {
    if (kid.id == null) {
      return;
    }

    final Map<String, dynamic> updatedFields = {};

    updatedFields['name'] = kid.name;
    updatedFields['dateOfBirth'] = kid.dateOfBirth;
    updatedFields['childWeight'] = kid.childWeight;
    updatedFields['childHeight'] = kid.childHeight;
    updatedFields['childHeadCircumference'] = kid.childHeadCircumference;
    if (kid.profileImgUriChild != null) {
      updatedFields['profileImgUriChild'] = kid.profileImgUriChild;
    }
    updatedFields['isPremature'] = kid.isPremature;
    updatedFields['isHasTwin'] = kid.isHasTwin;

    await kidsCollection().doc(kid.id).update(updatedFields);

    if (kDebugMode) {
      print('Updated user ${kid.name}');
    }
  }
}

@riverpod
KidsRepository kidsRepository(KidsRepositoryRef ref) => KidsRepository();

@riverpod
Future<Kid?> getKid(GetKidRef ref, {required String? id}) {
  return KidsRepository().getKid(id);
}

@riverpod
Stream<Kid?> getKidStream(GetKidStreamRef ref, {required String kidId}) {
  return kidsCollection().doc(kidId).snapshots().toStreamDoc(kidId: kidId);
}

@riverpod
Future<Kid?> getKidFuture(GetKidFutureRef ref, {required String kidId}) async {
  final kidStream = ref.watch(getKidStreamProvider(kidId: kidId).future);
  final kid = await kidStream;
  if (kid == null) {
    throw Exception('Could not find kid with id $kidId');
  }
  return kid;
}
