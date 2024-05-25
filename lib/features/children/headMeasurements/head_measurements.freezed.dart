// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'head_measurements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HeadMeasurements _$HeadMeasurementsFromJson(Map<String, dynamic> json) {
  return _HeadMeasurements.fromJson(json);
}

/// @nodoc
mixin _$HeadMeasurements {
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get measurements => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HeadMeasurementsCopyWith<HeadMeasurements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HeadMeasurementsCopyWith<$Res> {
  factory $HeadMeasurementsCopyWith(
          HeadMeasurements value, $Res Function(HeadMeasurements) then) =
      _$HeadMeasurementsCopyWithImpl<$Res, HeadMeasurements>;
  @useResult
  $Res call({DateTime timestamp, String? measurements});
}

/// @nodoc
class _$HeadMeasurementsCopyWithImpl<$Res, $Val extends HeadMeasurements>
    implements $HeadMeasurementsCopyWith<$Res> {
  _$HeadMeasurementsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? measurements = freezed,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      measurements: freezed == measurements
          ? _value.measurements
          : measurements // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HeadMeasurementsImplCopyWith<$Res>
    implements $HeadMeasurementsCopyWith<$Res> {
  factory _$$HeadMeasurementsImplCopyWith(_$HeadMeasurementsImpl value,
          $Res Function(_$HeadMeasurementsImpl) then) =
      __$$HeadMeasurementsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime timestamp, String? measurements});
}

/// @nodoc
class __$$HeadMeasurementsImplCopyWithImpl<$Res>
    extends _$HeadMeasurementsCopyWithImpl<$Res, _$HeadMeasurementsImpl>
    implements _$$HeadMeasurementsImplCopyWith<$Res> {
  __$$HeadMeasurementsImplCopyWithImpl(_$HeadMeasurementsImpl _value,
      $Res Function(_$HeadMeasurementsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? measurements = freezed,
  }) {
    return _then(_$HeadMeasurementsImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      measurements: freezed == measurements
          ? _value.measurements
          : measurements // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HeadMeasurementsImpl implements _HeadMeasurements {
  const _$HeadMeasurementsImpl({required this.timestamp, this.measurements});

  factory _$HeadMeasurementsImpl.fromJson(Map<String, dynamic> json) =>
      _$$HeadMeasurementsImplFromJson(json);

  @override
  final DateTime timestamp;
  @override
  final String? measurements;

  @override
  String toString() {
    return 'HeadMeasurements(timestamp: $timestamp, measurements: $measurements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HeadMeasurementsImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.measurements, measurements) ||
                other.measurements == measurements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, timestamp, measurements);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HeadMeasurementsImplCopyWith<_$HeadMeasurementsImpl> get copyWith =>
      __$$HeadMeasurementsImplCopyWithImpl<_$HeadMeasurementsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HeadMeasurementsImplToJson(
      this,
    );
  }
}

abstract class _HeadMeasurements implements HeadMeasurements {
  const factory _HeadMeasurements(
      {required final DateTime timestamp,
      final String? measurements}) = _$HeadMeasurementsImpl;

  factory _HeadMeasurements.fromJson(Map<String, dynamic> json) =
      _$HeadMeasurementsImpl.fromJson;

  @override
  DateTime get timestamp;
  @override
  String? get measurements;
  @override
  @JsonKey(ignore: true)
  _$$HeadMeasurementsImplCopyWith<_$HeadMeasurementsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
