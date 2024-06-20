import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:tracker/features/common/utils/utils.dart';

final temperatureProvider =
    StateNotifierProvider<TemperatureNotifier, List<Map<String, dynamic>>>(
        (ref) {
  return TemperatureNotifier();
});

class TemperatureNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  TemperatureNotifier() : super([]) {
    _loadTemperatures();
  }

  Future<void> _loadTemperatures() async {
    final prefs = await SharedPreferences.getInstance();
    final String? temperaturesJson = prefs.getString('temperatures');
    if (temperaturesJson != null) {
      final List<dynamic> temperaturesList = json.decode(temperaturesJson);
      state = temperaturesList
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
  }

  Future<void> _saveTemperatures() async {
    final prefs = await SharedPreferences.getInstance();
    final String temperaturesJson = json.encode(state);
    await prefs.setString('temperatures', temperaturesJson);
  }

  void addTemperature(double value) {
    state = [
      ...state,
      {
        "temperature": value,
        "timestamp": formatTimestamp(DateTime.now()),
      }
    ];
    _saveTemperatures();
  }

  void editTemperature(int index, double value) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          {"temperature": value, "timestamp": state[i]["timestamp"]}
        else
          state[i]
    ];
    _saveTemperatures();
  }

  void deleteTemperature(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i]
    ];
    _saveTemperatures();
  }
}
