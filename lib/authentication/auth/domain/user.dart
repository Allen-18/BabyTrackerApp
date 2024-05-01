import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();
  const factory User({
    // ignore: invalid_annotation_target
    @JsonKey(includeFromJson: false, includeToJson: false) String? id,
    @Default(null) String? email,
    @Default(null) String? name,
    @Default(null) String? relationship,
    @Default(null) DateTime? creationDate,
    @Default(false) bool hasChild,
    @Default(null) String? profileImgUri,
    @Default(false) bool isActive,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromFirstore(
          DocumentSnapshot snapshot,
          SnapshotOptions?
              options // ignore: avoid_unused_constructor_parameters
          ) =>
      User.fromJson((snapshot.data() ?? {}) as Map<String, dynamic>)
          .copyWith(id: snapshot.id);

  static Map<String, Object?> toFirestore(User user, SetOptions? options) =>
      user.toJson();

  factory User.empty() => const User(name: '', email: '', relationship: '');
}

enum Relationship {
  mother,
  father,
}

Map<String, String> userRoleStrings = {
  Relationship.mother.name: 'Mother',
  Relationship.father.name: 'Father',
};
