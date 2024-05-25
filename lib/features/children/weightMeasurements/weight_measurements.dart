import 'package:freezed_annotation/freezed_annotation.dart';

part 'weight_measurements.freezed.dart';
part 'weight_measurements.g.dart';

@freezed
class WeightMeasurements with _$WeightMeasurements {
  const factory WeightMeasurements(
      {required DateTime timestamp,
        String? measurements,
        }) = _WeightMeasurements;

  factory WeightMeasurements.fromJson(Map<String, dynamic> json) =>
      _$WeightMeasurementsFromJson(json);

  factory WeightMeasurements.fromNewAction( DateTime? when,
      String measurement,) {
    var timestamp = when ?? DateTime.now().toUtc();
    return WeightMeasurements(
        timestamp: timestamp,
        measurements: measurement,);
  }
}
