import 'package:freezed_annotation/freezed_annotation.dart';

part 'height_measurements.freezed.dart';
part 'height_measurements.g.dart';

@freezed
class HeightMeasurements with _$HeightMeasurements {
  const factory HeightMeasurements(
      {required DateTime timestamp,
        String? measurements,
      }) = _HeightMeasurements;

  factory HeightMeasurements.fromJson(Map<String, dynamic> json) =>
      _$HeightMeasurementsFromJson(json);

  factory HeightMeasurements.fromNewAction( DateTime? when,
      String measurements,) {
    var timestamp = when ?? DateTime.now().toUtc();
    return HeightMeasurements(
        timestamp: timestamp,
        measurements: measurements);
  }
}
