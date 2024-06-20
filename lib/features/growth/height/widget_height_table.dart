import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/common/utils/utils.dart';
import 'package:tracker/features/growth/height/provider/kid_height_measurements_provider.dart';
import 'package:tracker/features/children/kids.dart';
import 'height_no_records.dart';

Widget heightTable(BuildContext context, WidgetRef ref, Kid currentKid) {
  final notifier = ref.read(kidHeightMeasurementsProvider(currentKid).notifier);
  final heights = ref.watch(kidHeightMeasurementsProvider(currentKid));

  void editHeightMeasurement(HeightData heightData) {
    final heightController = TextEditingController(text: heightData.value);

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editează Înălțimea'),
          content: TextField(
            controller: heightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(hintText: 'Editează înălțimea'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Anulează'),
            ),
            TextButton(
              onPressed: () async {
                double? height = double.tryParse(heightController.text);
                if (height != null) {
                  notifier.editHeightMeasurement(
                      heightData, heightController.text);
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

  void deleteHeightMeasurement(HeightData heightData) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Șterge Înălțimea'),
          content: const Text(
              'Sigur dorești să ștergi această măsurătoare de înălțime?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Anulează'),
            ),
            TextButton(
              onPressed: () async {
                notifier.deleteHeightMeasurement(heightData);
                Navigator.pop(context);
              },
              child: const Text('Șterge'),
            ),
          ],
        );
      },
    );
  }

  if (heights.isNotEmpty) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              columnSpacing: 20.0,
              columns: const [
                DataColumn(label: Text('Înălțime(cm)')),
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
              rows: heights.map((height) {
                return DataRow(cells: [
                  DataCell(Text('${height.value} cm')),
                  DataCell(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatTimestamp(height.data),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => editHeightMeasurement(height),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteHeightMeasurement(height),
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
    return heightNoRecords(context);
  }
}
