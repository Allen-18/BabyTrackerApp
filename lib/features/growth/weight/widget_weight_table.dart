import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/common/utils/utils.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/growth/weight/wight_no_records.dart';
import 'kid_weight_measurements_provider.dart';

Widget weightTable(BuildContext context, WidgetRef ref, Kid currentKid) {
  List<WeightData> weights = ref.watch(kidWeightMeasurementsProvider(currentKid));
      if (weights.isNotEmpty) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Greutate (kg)')),
              DataColumn(label: Text('Data înregistrării')),
            ],
            rows: weights.map((weight) {
              return DataRow(cells: [
                DataCell(Text('${weight.value} kg')),
                DataCell(Text(formatTimestamp(weight.data))),
              ]);
            }).toList(),
          ),
        );
      } else {
        return weightNoRecords(context);
      }
}
