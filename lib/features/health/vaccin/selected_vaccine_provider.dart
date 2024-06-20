import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedVaccineNotifier extends StateNotifier<Map<String, List<String>>> {
  SelectedVaccineNotifier() : super({});

  void addVaccine(String kid, String vaccine) {
    state = {
      ...state,
      kid: [...(state[kid] ?? []), vaccine]
    };
  }

  void removeVaccine(String kid, String vaccine) {
    state = {...state, kid: (state[kid] ?? [])..remove(vaccine)};
  }
}

final selectedVaccineProvider =
    StateNotifierProvider<SelectedVaccineNotifier, Map<String, List<String>>>(
        (ref) {
  return SelectedVaccineNotifier();
});
