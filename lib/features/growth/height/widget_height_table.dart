import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/common/utils/utils.dart';
import 'package:tracker/features/growth/height/provider/kid_height_measurements_provider.dart';
import 'package:tracker/features/children/kids.dart';
import 'height_no_records.dart';

Widget heightTable(BuildContext context, WidgetRef ref, Kid currentKid) {
  List<HeightData> heights = ref.watch(kidHeightMeasurementsProvider(currentKid));
  if (heights.isNotEmpty) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Înalțime (cm)')),
          DataColumn(label: Text('Data înregistrării')),
        ],
        rows: heights.map((height) {
          return DataRow(cells: [
            DataCell(Text('${height.value} cm')),
            DataCell(Text(formatTimestamp(height.data))),
          ]);
        }).toList(),
      ),
    );
  } else {
    return heightNoRecords(context);
  }
}
