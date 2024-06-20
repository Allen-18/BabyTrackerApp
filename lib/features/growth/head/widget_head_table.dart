import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/common/utils/utils.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/growth/head/provider/kid_head_measurements_provider.dart';
import 'package:tracker/features/growth/head/widget_no_records.dart';

Widget headTable(BuildContext context, WidgetRef ref, Kid currentKid) {
  List<HeadData> head = ref.watch(kidHeadMeasurementsProvider(currentKid));
  final notifier = ref.read(kidHeadMeasurementsProvider(currentKid).notifier);

  void editHeadMeasurement(HeadData headData) {
    final headController = TextEditingController(text: headData.value);

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editează Circumferința Capului'),
          content: TextField(
            controller: headController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
                hintText: 'Editează Circumferința Capului'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Anulează'),
            ),
            TextButton(
              onPressed: () async {
                double? headCircumference =
                    double.tryParse(headController.text);
                if (headCircumference != null) {
                  notifier.editHeadMeasurement(headData, headController.text);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Introduceți o circumferință validă.'),
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

  void deleteHeadMeasurement(HeadData headData) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Șterge Circumferința Capului'),
          content: const Text(
              'Sigur dorești să ștergi această măsurătoare de circumferință a capului?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Anulează'),
            ),
            TextButton(
              onPressed: () async {
                notifier.deleteHeadMeasurement(headData);
                Navigator.pop(context);
              },
              child: const Text('Șterge'),
            ),
          ],
        );
      },
    );
  }

  if (head.isNotEmpty) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              columnSpacing: 30.0,
              columns: const [
                DataColumn(
                  label: Flexible(
                      child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Circumferința\n'),
                        TextSpan(text: 'Capului(cm)'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  )),
                ),
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
              rows: head.map((head) {
                return DataRow(cells: [
                  DataCell(Text('${head.value} cm')),
                  DataCell(
                    Text(
                      formatTimestamp(head.data),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => editHeadMeasurement(head),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteHeadMeasurement(head),
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
    return headNoRecords(context);
  }
}
