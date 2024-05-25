// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'height_measurements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HeightMeasurements _$HeightMeasurementsFromJson(Map<String, dynamic> json) {
  return _HeightMeasurements.fromJson(json);
}

/// @nodoc
mixin _$HeightMeasurements {
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get measurements => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HeightMeasurementsCopyWith<HeightMeasurements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HeightMeasurementsCopyWith<$Res> {
  factory $HeightMeasurementsCopyWith(
          HeightMeasurements value, $Res Function(HeightMeasurements) then) =
      _$HeightMeasurementsCopyWithImpl<$Res, HeightMeasurements>;
  @useResult
  $Res call({DateTime timestamp, String? measurements});
}

/// @nodoc
class _$HeightMeasurementsCopyWithImpl<$Res, $Val extends HeightMeasurements>
    implements $HeightMeasurementsCopyWith<$Res> {
  _$HeightMeasurementsCopyWithImpl(this._value, this._then);

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
abstract class _$$HeightMeasurementsImplCopyWith<$Res>
    implements $HeightMeasurementsCopyWith<$Res> {
  factory _$$HeightMeasurementsImplCopyWith(_$HeightMeasurementsImpl value,
          $Res Function(_$HeightMeasurementsImpl) then) =
      __$$HeightMeasurementsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime timestamp, String? measurements});
}

/// @nodoc
class __$$HeightMeasurementsImplCopyWithImpl<$Res>
    extends _$HeightMeasurementsCopyWithImpl<$Res, _$HeightMeasurementsImpl>
    implements _$$HeightMeasurementsImplCopyWith<$Res> {
  __$$HeightMeasurementsImplCopyWithImpl(_$HeightMeasurementsImpl _value,
      $Res Function(_$HeightMeasurementsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? measurements = freezed,
  }) {
    return _then(_$HeightMeasurementsImpl(
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
class _$HeightMeasurementsImpl implements _HeightMeasurements {
  const _$HeightMeasurementsImpl({required this.timestamp, this.measurements});

  factory _$HeightMeasurementsImpl.fromJson(Map<String, dynamic> json) =>
      _$$HeightMeasurementsImplFromJson(json);

  @override
  final DateTime timestamp;
  @override
  final String? measurements;

  @override
  String toString() {
    return 'HeightMeasurements(timestamp: $timestamp, measurements: $measurements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HeightMeasurementsImpl &&
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
  _$$HeightMeasurementsImplCopyWith<_$HeightMeasurementsImpl> get copyWith =>
      __$$HeightMeasurementsImplCopyWithImpl<_$HeightMeasurementsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HeightMeasurementsImplToJson(
      this,
    );
  }
}

abstract class _HeightMeasurements implements HeightMeasurements {
  const factory _HeightMeasurements(
      {required final DateTime timestamp,
      final String? measurements}) = _$HeightMeasurementsImpl;

  factory _HeightMeasurements.fromJson(Map<String, dynamic> json) =
      _$HeightMeasurementsImpl.fromJson;

  @override
  DateTime get timestamp;
  @override
  String? get measurements;
  @override
  @JsonKey(ignore: true)
  _$$HeightMeasurementsImplCopyWith<_$HeightMeasurementsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
