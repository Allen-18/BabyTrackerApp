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
          child: temperatures.isEmpty
              ? noRecords(context)
              : temperatureTable(context, ref, temperatures),
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
                  ref
                      .read(temperatureProvider.notifier)
                      .addTemperature(temperature);
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
          Flexible(
              child: Image.asset(
            AppAssets.temperature,
            scale: 2,
          )),
          const SizedBox(height: 10),
          Text(
            "Nu sunt înregistrări",
            style: getRegularStyle(color: Colors.grey, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget temperatureTable(BuildContext context, WidgetRef ref,
      List<Map<String, dynamic>> temperatures) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Temperatura')),
            DataColumn(label: Text('Data înregistrării')),
            DataColumn(label: Text('')),
          ],
          rows: List<DataRow>.generate(
            temperatures.length,
            (index) => DataRow(
              cells: [
                DataCell(Text('${temperatures[index]['temperature']}°C')),
                DataCell(Text('${temperatures[index]['timestamp']}')),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => showEditTemperatureDialog(
                            context, ref, temperatures[index], index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => ref
                            .read(temperatureProvider.notifier)
                            .deleteTemperature(index),
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
            onChanged: (value) {
              tempController.value = tempController.value.copyWith(
                text: value.replaceAll(',', '.'),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Anulează'),
            ),
            TextButton(
              onPressed: () {
                double? enteredTemperature =
                    double.tryParse(tempController.text.replaceAll(',', '.'));
                if (enteredTemperature != null &&
                    enteredTemperature >= 35 &&
                    enteredTemperature <= 42) {
                  Navigator.pop(context, enteredTemperature);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Introduceți o valoare între 35 și 42°C.'),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
              child: const Text('Salvează'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showEditTemperatureDialog(BuildContext context, WidgetRef ref,
      Map<String, dynamic> temperature, int index) async {
    TextEditingController tempController =
        TextEditingController(text: '${temperature['temperature']}');
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editează temperatura'),
          content: TextField(
            controller: tempController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(hintText: 'Introdu temperatura'),
            onChanged: (value) {
              tempController.value = tempController.value.copyWith(
                text: value.replaceAll(',', '.'),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Anulează'),
            ),
            TextButton(
              onPressed: () {
                double? enteredTemperature =
                    double.tryParse(tempController.text.replaceAll(',', '.'));
                if (enteredTemperature != null &&
                    enteredTemperature >= 35 &&
                    enteredTemperature <= 42) {
                  ref
                      .read(temperatureProvider.notifier)
                      .editTemperature(index, enteredTemperature);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Introduceți o valoare între 35 și 42°C.'),
                    duration: Duration(seconds: 2),
                  ));
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
