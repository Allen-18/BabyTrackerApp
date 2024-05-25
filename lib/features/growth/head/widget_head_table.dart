import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/common/utils/utils.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/growth/head/provider/kid_head_measurements_provider.dart';
import 'package:tracker/features/growth/head/widget_no_records.dart';



Widget headTable(BuildContext context, WidgetRef ref, Kid currentKid) {
  List<HeadData> head = ref.watch(kidHeadMeasurementsProvider(currentKid));
  if (head.isNotEmpty) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(label: Flexible(child: Text('Circumferința \ncapului (cm)'))),
          DataColumn(label: Text('Data înregistrării')),
        ],
        rows: head.map((head) {
          return DataRow(cells: [
            DataCell(Text('${head.value}  cm')),
            DataCell(Text(formatTimestamp(head.data))),
          ]);
        }).toList(),
      ),
    );
  } else {
    return headNoRecords(context);
  }
}
