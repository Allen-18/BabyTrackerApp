// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'head_measurements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HeadMeasurementsImpl _$$HeadMeasurementsImplFromJson(
        Map<String, dynamic> json) =>
    _$HeadMeasurementsImpl(
      timestamp: DateTime.parse(json['timestamp'] as String),
      measurements: json['measurements'] as String?,
    );

Map<String, dynamic> _$$HeadMeasurementsImplToJson(
        _$HeadMeasurementsImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'measurements': instance.measurements,
    };
