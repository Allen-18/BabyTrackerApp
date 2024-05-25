import 'package:freezed_annotation/freezed_annotation.dart';

part 'head_measurements.freezed.dart';
part 'head_measurements.g.dart';

@freezed
class HeadMeasurements with _$HeadMeasurements {
  const factory HeadMeasurements(
      {required DateTime timestamp,
        String? measurements,
      }) = _HeadMeasurements;

  factory HeadMeasurements.fromJson(Map<String, dynamic> json) =>
      _$HeadMeasurementsFromJson(json);

  factory HeadMeasurements.fromNewAction( DateTime? when,
      String measurements,) {
    var timestamp = when ?? DateTime.now().toUtc();
    return HeadMeasurements(
        timestamp: timestamp,
        measurements: measurements);
  }
}
