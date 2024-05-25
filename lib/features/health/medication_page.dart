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
        const SizedBox(height: 15,),
        Expanded(
          flex: 5,
          child: medications.isEmpty ? noRecords(context) : medicationTable(medications),
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
                "Adaugă medicamentație",
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child:
          Image.asset(AppAssets.medication, scale: 2,)),
          const SizedBox(height: 10),
          Text(
            "Nu sunt înregistrări",
            style: getRegularStyle(color: Colors.grey, fontSize: 20),
          ),
        ]
      ),
    );
  }

  Widget medicationTable(List<Medication> medications) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Nume')),
          DataColumn(label: Text('Dozaj')),
          DataColumn(label: Text('Data introducerii')),
        ],
        rows: medications.map((medication) {
          return DataRow(cells: [
            DataCell(Text(medication.name)),
            DataCell(Text(medication.dosage)),
            DataCell(Text(formatTimestamp(medication.timestamp))),  // Assuming formatTimestamp is implemented
          ]);
        }).toList(),
      ),
    );
  }

  Future<void> showAddMedicationDialog(BuildContext context, WidgetRef ref) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController dosageController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Medication'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Enter medication name'),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: dosageController,
                decoration: const InputDecoration(hintText: 'Enter dosage'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && dosageController.text.isNotEmpty) {
                  ref.read(medicationProvider.notifier).addMedication(
                    nameController.text,
                    dosageController.text,
                    DateTime.now(),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Salvare date'),
            ),
          ],
        );
      },
    );
  }
}
