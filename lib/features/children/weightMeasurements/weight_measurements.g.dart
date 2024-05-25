// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_measurements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeightMeasurementsImpl _$$WeightMeasurementsImplFromJson(
        Map<String, dynamic> json) =>
    _$WeightMeasurementsImpl(
      timestamp: DateTime.parse(json['timestamp'] as String),
      measurements: json['measurements'] as String?,
    );

Map<String, dynamic> _$$WeightMeasurementsImplToJson(
        _$WeightMeasurementsImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'measurements': instance.measurements,
    };
