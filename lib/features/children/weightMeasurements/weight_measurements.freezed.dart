// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weight_measurements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeightMeasurements _$WeightMeasurementsFromJson(Map<String, dynamic> json) {
  return _WeightMeasurements.fromJson(json);
}

/// @nodoc
mixin _$WeightMeasurements {
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get measurements => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeightMeasurementsCopyWith<WeightMeasurements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeightMeasurementsCopyWith<$Res> {
  factory $WeightMeasurementsCopyWith(
          WeightMeasurements value, $Res Function(WeightMeasurements) then) =
      _$WeightMeasurementsCopyWithImpl<$Res, WeightMeasurements>;
  @useResult
  $Res call({DateTime timestamp, String? measurements});
}

/// @nodoc
class _$WeightMeasurementsCopyWithImpl<$Res, $Val extends WeightMeasurements>
    implements $WeightMeasurementsCopyWith<$Res> {
  _$WeightMeasurementsCopyWithImpl(this._value, this._then);

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
abstract class _$$WeightMeasurementsImplCopyWith<$Res>
    implements $WeightMeasurementsCopyWith<$Res> {
  factory _$$WeightMeasurementsImplCopyWith(_$WeightMeasurementsImpl value,
          $Res Function(_$WeightMeasurementsImpl) then) =
      __$$WeightMeasurementsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime timestamp, String? measurements});
}

/// @nodoc
class __$$WeightMeasurementsImplCopyWithImpl<$Res>
    extends _$WeightMeasurementsCopyWithImpl<$Res, _$WeightMeasurementsImpl>
    implements _$$WeightMeasurementsImplCopyWith<$Res> {
  __$$WeightMeasurementsImplCopyWithImpl(_$WeightMeasurementsImpl _value,
      $Res Function(_$WeightMeasurementsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? measurements = freezed,
  }) {
    return _then(_$WeightMeasurementsImpl(
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
class _$WeightMeasurementsImpl implements _WeightMeasurements {
  const _$WeightMeasurementsImpl({required this.timestamp, this.measurements});

  factory _$WeightMeasurementsImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeightMeasurementsImplFromJson(json);

  @override
  final DateTime timestamp;
  @override
  final String? measurements;

  @override
  String toString() {
    return 'WeightMeasurements(timestamp: $timestamp, measurements: $measurements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeightMeasurementsImpl &&
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
  _$$WeightMeasurementsImplCopyWith<_$WeightMeasurementsImpl> get copyWith =>
      __$$WeightMeasurementsImplCopyWithImpl<_$WeightMeasurementsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeightMeasurementsImplToJson(
      this,
    );
  }
}

abstract class _WeightMeasurements implements WeightMeasurements {
  const factory _WeightMeasurements(
      {required final DateTime timestamp,
      final String? measurements}) = _$WeightMeasurementsImpl;

  factory _WeightMeasurements.fromJson(Map<String, dynamic> json) =
      _$WeightMeasurementsImpl.fromJson;

  @override
  DateTime get timestamp;
  @override
  String? get measurements;
  @override
  @JsonKey(ignore: true)
  _$$WeightMeasurementsImplCopyWith<_$WeightMeasurementsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
