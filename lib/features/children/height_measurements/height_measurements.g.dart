// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'height_measurements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HeightMeasurementsImpl _$$HeightMeasurementsImplFromJson(
        Map<String, dynamic> json) =>
    _$HeightMeasurementsImpl(
      timestamp: DateTime.parse(json['timestamp'] as String),
      measurements: json['measurements'] as String?,
    );

Map<String, dynamic> _$$HeightMeasurementsImplToJson(
        _$HeightMeasurementsImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'measurements': instance.measurements,
    };
