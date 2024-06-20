import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/common/utils/utils.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/growth/weight/provider/kid_weight_measurements_provider.dart';
import 'package:tracker/features/growth/weight/wight_no_records.dart';

Widget weightTable(BuildContext context, WidgetRef ref, Kid currentKid) {
  final weights = ref.watch(kidWeightMeasurementsProvider(currentKid));
  final notifier = ref.read(kidWeightMeasurementsProvider(currentKid).notifier);

  void editWeightMeasurement(WeightData weightData) {
    final weightController = TextEditingController(text: weightData.value);

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editează Greutatea'),
          content: TextField(
            controller: weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(hintText: 'Editează Greutatea'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Anulează'),
            ),
            TextButton(
              onPressed: () async {
                double? weight = double.tryParse(weightController.text);
                if (weight != null) {
                  notifier.editWeightMeasurement(
                      weightData, weightController.text);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Introduceți o greutate validă.'),
                    ),
                  );
                }
              },
              child: const Text('Salvează'),
            ),
          ],
        );
      },
    );
  }

  void deleteWeightMeasurement(WeightData weightData) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Șterge Greutatea'),
          content: const Text(
              'Sigur dorești să ștergi această măsurătoare de greutate?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Anulează'),
            ),
            TextButton(
              onPressed: () async {
                notifier.deleteWeightMeasurement(weightData);
                Navigator.pop(context);
              },
              child: const Text('Șterge'),
            ),
          ],
        );
      },
    );
  }

  if (weights.isNotEmpty) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              columnSpacing: 20.0,
              columns: const [
                DataColumn(label: Text('Greutate(kg)')),
                DataColumn(
                  label: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Data\n'),
                        TextSpan(text: 'înregistrării'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                DataColumn(label: Text('')),
              ],
              rows: weights.map((weight) {
                return DataRow(cells: [
                  DataCell(Text('${weight.value} kg')),
                  DataCell(Text(
                    formatTimestamp(weight.data),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataCell(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => editWeightMeasurement(weight),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteWeightMeasurement(weight),
                        ),
                      ],
                    ),
                  ),
                ]);
              }).toList(),
            ),
          ),
        );
      },
    );
  } else {
    return weightNoRecords(context);
  }
}
