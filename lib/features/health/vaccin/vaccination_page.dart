import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker/features/health/vaccin/vaccine_provider.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'selected_vaccine_provider.dart';

final selectedVaccinationsFutureProvider =
    FutureProvider.family<List<String>, String>((ref, kid) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('savedVaccinations') ?? [];
});

class HealthVaccination extends ConsumerWidget {
  final String kid;

  const HealthVaccination({super.key, required this.kid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(vaccinationProvider.notifier).fetchVaccinations();
    final vaccinations = ref.watch(vaccinationProvider);
    final selectedVaccinationsAsync =
        ref.watch(selectedVaccinationsFutureProvider(kid));

    selectedVaccinationsAsync.whenData((selectedVaccinations) {
      Future.microtask(() {
        for (var vaccination in selectedVaccinations) {
          ref
              .read(selectedVaccineProvider.notifier)
              .addVaccine(kid, vaccination);
        }
      });
    });

    final selectedVaccinations = ref.watch(selectedVaccineProvider)[kid] ?? [];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: AppColors.lightPrimary,
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                indicatorColor: AppColors.black,
                tabs: const [
                  Tab(text: 'Vaccinuri de efectuat'),
                  Tab(text: 'Vaccinuri efectuate'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: vaccinations.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: vaccinations.length,
                            itemBuilder: (context, index) {
                              final vaccination = vaccinations[index];
                              return Card(
                                color: AppColors.white,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(
                                      'Luna ${vaccination.month} - ${vaccination.name}'),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.save_alt),
                                    onPressed: () => saveVaccination(
                                        vaccination.name, ref, context),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: selectedVaccinations.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: Image.asset(AppAssets.vaccination)),
                              const SizedBox(height: 10),
                              Text(
                                "Niciun vaccin selectat",
                                style: getRegularStyle(
                                    color: Colors.grey, fontSize: 20),
                              ),
                            ],
                          )
                        : DataTable(
                            columns: const [
                              DataColumn(label: Text('Vaccin')),
                              DataColumn(label: Text('')),
                            ],
                            rows: selectedVaccinations.map((vaccination) {
                              return DataRow(cells: [
                                DataCell(
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                          child: Text(vaccination,
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                                DataCell(
                                  IconButton(
                                    icon: const Icon(Icons.delete_forever),
                                    onPressed: () => removeVaccination(
                                        vaccination, ref, context),
                                  ),
                                ),
                              ]);
                            }).toList(),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveVaccination(
      String vaccination, WidgetRef ref, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedVaccinations =
        prefs.getStringList('savedVaccinations') ?? [];
    if (!savedVaccinations.contains(vaccination)) {
      savedVaccinations.add(vaccination);
      await prefs.setStringList('savedVaccinations', savedVaccinations);
      ref.read(selectedVaccineProvider.notifier).addVaccine(kid, vaccination);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Vaccinul a fost salvat cu succes!')));
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Vaccinul este deja salvat.')));
      }
    }
  }

  Future<void> removeVaccination(
      String vaccination, WidgetRef ref, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedVaccinations =
        prefs.getStringList('savedVaccinations') ?? [];
    if (savedVaccinations.contains(vaccination)) {
      savedVaccinations.remove(vaccination);
      await prefs.setStringList('savedVaccinations', savedVaccinations);
      ref
          .read(selectedVaccineProvider.notifier)
          .removeVaccine(kid, vaccination);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Vaccinul a fost șters cu succes!')));
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Vaccinul nu a fost găsit.')));
      }
    }
  }
}
