import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:tracker/features/Health/temperature_page.dart';
import 'package:tracker/features/health/provider/medication_provider.dart';
import 'package:tracker/features/health/provider/temperature_provider.dart';
import 'package:tracker/features/health/vaccin/vaccination_page.dart';
import 'package:tracker/features/health/vaccin/vaccine_provider.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/health/medication_page.dart';
import 'package:tracker/features/progress/components/load_custom_font.dart';
import 'package:tracker/features/common/utils/utils.dart';

class Health extends ConsumerWidget {
  final Kid kid;

  const Health({super.key, required this.kid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(
                color: AppColors.darkGrey,
                Icons.save_rounded,
                size: 35,
              ),
              onPressed: () => _showSaveOptionsDialog(context, ref, kid),
            ),
          ],
          title: Text(
            'Monitorizare sănătate',
            style: getMediumStyle(color: Colors.black, fontSize: 20),
          ),
          bottom: TabBar(
            labelColor: AppColors.primary,
            indicatorColor: AppColors.primary,
            unselectedLabelColor: AppColors.grey,
            tabs: const [
              Tab(
                text: "Temperatură",
              ),
              Tab(
                text: "Medicamentație",
              ),
              Tab(
                text: "Vaccinări",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const HealthTemperature(),
            const HealthMedication(),
            HealthVaccination(kid: kid.id!),
          ],
        ),
      ),
    );
  }

  void _showSaveOptionsDialog(
      BuildContext context, WidgetRef ref, Kid currentKid) {
    List<String> selectedOptions = [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Selectează datele dorite'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    CheckboxListTile(
                      title: const Text('Temperatură'),
                      value: selectedOptions.contains('temperature'),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedOptions.add('temperature');
                          } else {
                            selectedOptions.remove('temperature');
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Medicamentație'),
                      value: selectedOptions.contains('medication'),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedOptions.add('medication');
                          } else {
                            selectedOptions.remove('medication');
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Vaccinări'),
                      value: selectedOptions.contains('vaccinations'),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedOptions.add('vaccinations');
                          } else {
                            selectedOptions.remove('vaccinations');
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Anulează'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Salvează'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _saveTableAsPDF(context, ref, currentKid, selectedOptions);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _saveTableAsPDF(BuildContext context, WidgetRef ref,
      Kid currentKid, List<String> selectedOptions) async {
    final document = PdfDocument();
    final PdfFont headerFont = await loadCustomFont(18);
    final PdfFont bodyFont = await loadCustomFont(20);
    final PdfFont footerFont = await loadCustomFont(20);
    final imageData = await rootBundle.load('assets/images/logo.png');
    final imageBytes = imageData.buffer.asUint8List();
    final page = document.pages.add();

    if (selectedOptions.contains('temperature')) {
      addTemperatureData(
          page, currentKid, headerFont, bodyFont, imageBytes, footerFont, ref);
    }
    if (selectedOptions.contains('medication')) {
      addMedicationData(
          page, currentKid, headerFont, bodyFont, imageBytes, footerFont, ref);
    }
    if (selectedOptions.contains('vaccinations')) {
      addVaccinationData(
          page, currentKid, headerFont, bodyFont, imageBytes, footerFont, ref);
    }

    try {
      final directory = await getExternalStorageDirectory();
      final file = File("${directory?.path}/MonitorizareSănătate.pdf");
      await file.writeAsBytes(document.saveSync());
      document.dispose();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF salvat: ${file.path}')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Eroare la salvarea PDF-ului: $e')),
        );
      }
    }
  }

  void addTemperatureData(
      PdfPage page,
      Kid kid,
      PdfFont headerFont,
      PdfFont bodyFont,
      Uint8List imageBytes,
      PdfFont footerFont,
      WidgetRef ref) {
    final pageWidth = page.getClientSize().width;
    final pageHeight = page.getClientSize().height;

    page.graphics.drawString(
      'Monitorizare temperatură pentru ${kid.name}',
      headerFont,
      bounds: Rect.fromLTWH(0, 0, pageWidth, 30),
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    final temperatures = ref.read(temperatureProvider);
    final temperatureText = temperatures
        .map((temp) => '${temp["temperature"]} °C - ${temp["timestamp"]}')
        .join('\n');
    page.graphics.drawString(
      temperatureText,
      bodyFont,
      bounds: Rect.fromLTWH(0, 40, pageWidth, pageHeight - 160),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    final image = PdfBitmap(imageBytes);

    const footerHeight = 80;
    final footerYPosition = pageHeight - footerHeight - 40;

    const imageSize = Size(80, 80);
    page.graphics.drawImage(
      image,
      Rect.fromLTWH((pageWidth - imageSize.width) / 2, footerYPosition,
          imageSize.width, imageSize.height),
    );

    const footerText = 'Generat de KidTracker';
    final textBounds =
        Rect.fromLTRB(0, footerYPosition + imageSize.height + 5, pageWidth, 20);
    page.graphics.drawString(
      footerText,
      footerFont,
      bounds: textBounds,
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );
  }

  void addMedicationData(
      PdfPage page,
      Kid kid,
      PdfFont headerFont,
      PdfFont bodyFont,
      Uint8List imageBytes,
      PdfFont footerFont,
      WidgetRef ref) {
    final pageWidth = page.getClientSize().width;
    final pageHeight = page.getClientSize().height;

    page.graphics.drawString(
      'Monitorizare medicație pentru ${kid.name}',
      headerFont,
      bounds: Rect.fromLTWH(
          0, page.graphics.clientSize.height * 0.25, pageWidth, 30),
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    final medications = ref.read(medicationProvider);
    final medicationText = medications
        .map((med) => '${med.name} - ${formatTimestamp(med.timestamp)}')
        .join('\n');
    page.graphics.drawString(
      medicationText,
      bodyFont,
      bounds: Rect.fromLTWH(0, page.graphics.clientSize.height * 0.30,
          pageWidth, pageHeight - 160),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    final image = PdfBitmap(imageBytes);

    const footerHeight = 80;
    final footerYPosition = pageHeight - footerHeight - 40;

    const imageSize = Size(80, 80);
    page.graphics.drawImage(
      image,
      Rect.fromLTWH((pageWidth - imageSize.width) / 2, footerYPosition,
          imageSize.width, imageSize.height),
    );

    const footerText = 'Generat de KidTracker';
    final textBounds =
        Rect.fromLTRB(0, footerYPosition + imageSize.height + 5, pageWidth, 20);
    page.graphics.drawString(
      footerText,
      footerFont,
      bounds: textBounds,
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );
  }

  void addVaccinationData(
      PdfPage page,
      Kid kid,
      PdfFont headerFont,
      PdfFont bodyFont,
      Uint8List imageBytes,
      PdfFont footerFont,
      WidgetRef ref) {
    final pageWidth = page.getClientSize().width;
    final pageHeight = page.getClientSize().height;

    page.graphics.drawString(
      'Monitorizare vaccinări pentru ${kid.name}',
      headerFont,
      bounds: Rect.fromLTWH(
          0, page.graphics.clientSize.height * 0.5, pageWidth, 30),
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    final vaccinations = ref.read(vaccinationProvider);
    final vaccinationText = vaccinations
        .map((vacc) => '${vacc.name} - ${vacc.month} luni')
        .join('\n');
    page.graphics.drawString(
      vaccinationText,
      bodyFont,
      bounds: Rect.fromLTWH(0, page.graphics.clientSize.height * 0.55,
          pageWidth, pageHeight - 160),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    final image = PdfBitmap(imageBytes);

    const footerHeight = 80;
    final footerYPosition = pageHeight - footerHeight - 40;

    const imageSize = Size(80, 80);
    page.graphics.drawImage(
      image,
      Rect.fromLTWH((pageWidth - imageSize.width) / 2, footerYPosition,
          imageSize.width, imageSize.height),
    );

    const footerText = 'Generat de KidTracker';
    final textBounds =
        Rect.fromLTRB(0, footerYPosition + imageSize.height + 5, pageWidth, 20);
    page.graphics.drawString(
      footerText,
      footerFont,
      bounds: textBounds,
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );
  }
}
