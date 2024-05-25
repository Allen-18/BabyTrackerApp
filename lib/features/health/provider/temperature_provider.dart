import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/common/utils/utils.dart';

final temperatureProvider = StateNotifierProvider<TemperatureNotifier, List<Map<String, dynamic>>>((ref) {
  return TemperatureNotifier();
});

class TemperatureNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  TemperatureNotifier() : super([]);

  void addTemperature(double value) {
    state = [
      ...state,
      {
        "temperature": value,
        "timestamp": formatTimestamp(DateTime.now()),
      }
    ];
  }
}
