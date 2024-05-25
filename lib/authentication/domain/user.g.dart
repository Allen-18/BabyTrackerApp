// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      email: json['email'] as String? ?? null,
      name: json['name'] as String? ?? null,
      relationship: json['relationship'] as String? ?? null,
      creationDate: json['creationDate'] == null
          ? null
          : DateTime.parse(json['creationDate'] as String),
      hasChild: json['hasChild'] as bool? ?? false,
      profileImgUri: json['profileImgUri'] as String? ?? null,
      isActive: json['isActive'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'relationship': instance.relationship,
      'creationDate': instance.creationDate?.toIso8601String(),
      'hasChild': instance.hasChild,
      'profileImgUri': instance.profileImgUri,
      'isActive': instance.isActive,
    };
