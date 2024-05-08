import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'cognitiveMilestone/cognitive_kid_skills.dart';
import 'motorMilestone/motor_kid_skills.dart';

part 'kids.freezed.dart';
part 'kids.g.dart';

@freezed
class Kid with _$Kid {
  const Kid._();

  const factory Kid({
    // ignore: invalid_annotation_target
    @JsonKey(includeFromJson: false, includeToJson: false) String? id,
    required String name,
    required String dateOfBirth,
    required String gender,
    @Default(false) bool isPremature,
    @Default(false) bool isHasTwin,
    @Default(0.0) double childWeight,
    @Default(0.0) double childHeight,
    @Default(0.0) double childHeadCircumference,
    @Default(null) String? profileImgUriChild,
    @Default([]) List<MotorKidSkills> motorSkills,
    @Default([]) List<CognitiveKidSkills> cognitiveSkills,
    String? assignedParentId,
  }) = _Kid;

  factory Kid.fromJson(Map<String, dynamic> json) => _$KidFromJson(json);

  factory Kid.fromFirstore(
          DocumentSnapshot snapshot,
          SnapshotOptions?
              options // ignore: avoid_unused_constructor_parameters
          ) =>
      Kid.fromJson((snapshot.data() ?? {}) as Map<String, dynamic>)
          .copyWith(id: snapshot.id);

  static Map<String, Object?> toFirestore(Kid kid, SetOptions? options) =>
      kid.toJson();

  static int compareById(Kid a, Kid b) {
    if (a.id == null && b.id == null) {
      return 0;
    }
    if (a.id == null) {
      return -1;
    }
    if (b.id == null) {
      return 1;
    }
    return a.id!.compareTo(b.id!);
  }

  // method for getting the current age of the kid ->
  String getCurrentAge(String dateOfBirth) {
    DateTime currentDate = DateTime.now();
    List<String> dateComponents = dateOfBirth.split('-');
    int day = int.parse(dateComponents[0]);
    int month = int.parse(dateComponents[1]);
    int year = int.parse(dateComponents[2]);
    DateTime birthDate = DateTime(year, month, day);
    Duration ageDifference = currentDate.difference(birthDate);

    String? age;
    if (ageDifference.inDays >= 365 * 5) {
      age = "${ageDifference.inDays ~/ 365} ani";
    } else if (ageDifference.inDays >= 365 && ageDifference.inDays < 365 * 5) {
      int years = ageDifference.inDays ~/ 365;
      int months = (ageDifference.inDays % 365) ~/ 30;
      if (years == 1) {
        age = "$years an";
      } else {
        age = "$years ani";
      }
      if (months > 0) {
        age += " $months luni";
      }
    } else if (ageDifference.inDays >= 30) {
      int months = ageDifference.inDays ~/ 30;
      int days = ageDifference.inDays % 30;
      if (months == 1) {
        age = "$months luna";
      } else {
        age = "$months luni";
      }
      if (days > 0) {
        age += " $days zile";
      }
    } else {
      int days = ageDifference.inDays;
      if (days == 1) {
        age = "$days zi";
      } else {
        age = "$days zile";
      }
    }
    return age;
  }
}
