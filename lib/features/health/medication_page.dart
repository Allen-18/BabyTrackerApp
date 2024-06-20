import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/health/provider/medication_provider.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/features/common/utils/utils.dart';

class HealthMedication extends ConsumerWidget {
  const HealthMedication({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Medication> medications = ref.watch(medicationProvider);

    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Expanded(
          flex: 5,
          child: medications.isEmpty
              ? noRecords(context)
              : medicationTable(context, ref, medications),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => showAddMedicationDialog(context, ref),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.primary),
              ),
              child: const Text(
                "Adaugă medicație",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget noRecords(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Flexible(
            child: Image.asset(
          AppAssets.medication,
          scale: 2,
        )),
        const SizedBox(height: 10),
        Text(
          "Nu sunt înregistrări",
          style: getRegularStyle(color: Colors.grey, fontSize: 20),
        ),
      ]),
    );
  }

  Widget medicationTable(
      BuildContext context, WidgetRef ref, List<Medication> medications) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              columnSpacing: 20.0,
              columns: const [
                DataColumn(label: Text('Nume')),
                DataColumn(label: Text('Dozaj')),
                DataColumn(
                  label: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Data\n'),
                        TextSpan(text: 'introducerii'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                DataColumn(label: Text('')),
              ],
              rows: List<DataRow>.generate(
                medications.length,
                (index) => DataRow(
                  cells: [
                    DataCell(Text(medications[index].name)),
                    DataCell(Text(medications[index].dosage)),
                    DataCell(
                        Text(formatTimestamp(medications[index].timestamp))),
                    DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => showEditMedicationDialog(
                                context, ref, medications[index], index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => ref
                                .read(medicationProvider.notifier)
                                .deleteMedication(index),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showAddMedicationDialog(
      BuildContext context, WidgetRef ref) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController dosageController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adaugă medicație'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    hintText: 'Introdu numele medicației'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: dosageController,
                decoration: const InputDecoration(hintText: 'Introdu doza'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Anulează'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    dosageController.text.isNotEmpty) {
                  ref.read(medicationProvider.notifier).addMedication(
                        nameController.text,
                        dosageController.text,
                        DateTime.now(),
                      );
                  Navigator.pop(context);
                }
              },
              child: const Text('Salvează'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showEditMedicationDialog(BuildContext context, WidgetRef ref,
      Medication medication, int index) async {
    TextEditingController nameController =
        TextEditingController(text: medication.name);
    TextEditingController dosageController =
        TextEditingController(text: medication.dosage);

    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editează medicația'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    hintText: 'Introdu numele medicației'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: dosageController,
                decoration: const InputDecoration(hintText: 'Introdu doza'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Anulează'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    dosageController.text.isNotEmpty) {
                  ref.read(medicationProvider.notifier).editMedication(
                        index,
                        nameController.text,
                        dosageController.text,
                        medication.timestamp,
                      );
                  Navigator.pop(context);
                }
              },
              child: const Text('Salvează'),
            ),
          ],
        );
      },
    );
  }
}
