import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/health/provider/temperature_provider.dart';
import 'package:tracker/helpers/assets_manager.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';

class HealthTemperature extends ConsumerWidget {
  const HealthTemperature({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<String, dynamic>> temperatures = ref.watch(temperatureProvider);

    return Column(
      children: [
        Expanded(
          flex: 6,
          child: temperatures.isEmpty ? noRecords(context) : temperatureTable(temperatures),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final temperature = await showAddTemperatureDialog(context);
                if (temperature != null) {
                  ref.read(temperatureProvider.notifier).addTemperature(temperature);
                }
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.primary)),
              child: const Text(
                "Adaugă temperatură",
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
          Flexible(child: Image.asset(AppAssets.temperature,  scale: 2,)),
          const SizedBox(height: 10),
          Text(
            "Nu sunt înregistrări",
            style: getRegularStyle(color: Colors.grey, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget temperatureTable(List<Map<String, dynamic>> temperatures) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Temperatura')),
          DataColumn(label: Text('Data inregistrarii')),
        ],
        rows: temperatures.map((temp) {
          return DataRow(cells: [
            DataCell(Text('${temp['temperature']}°C')),
            DataCell(Text('${temp['timestamp']}')),
          ]);
        }).toList(),
      ),
    );
  }

  Future<double?> showAddTemperatureDialog(BuildContext context) {
    TextEditingController tempController = TextEditingController();
    return showDialog<double>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adaugă temperatura'),
          content: TextField(
            controller: tempController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(hintText: 'Introdu temperatura'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                double? enteredTemperature = double.tryParse(tempController.text);
                if (enteredTemperature != null && enteredTemperature >= 35 && enteredTemperature <= 42) {
                  Navigator.pop(context, enteredTemperature);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Introduceți o valoare între 35 și 42°C.'),
                        duration: Duration(seconds: 2),
                      )
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
}
