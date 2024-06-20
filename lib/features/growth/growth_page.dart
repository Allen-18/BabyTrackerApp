import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:tracker/features/growth/weight/provider/kid_weight_measurements_provider.dart';
import 'package:tracker/features/growth/weight/weight_page.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/styles_manager.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/common/utils/utils.dart';
import 'package:tracker/features/progress/components/load_custom_font.dart';
import 'head/head_page.dart';
import 'head/provider/kid_head_measurements_provider.dart';
import 'height/height_page.dart';
import 'height/provider/kid_height_measurements_provider.dart';

class Growth extends ConsumerWidget {
  const Growth({super.key, required this.currentKid});
  final Kid currentKid;

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
              onPressed: () => _showSaveOptionsDialog(context, ref, currentKid),
            ),
          ],
          title: Text(
            'Creșterea copilului',
            style: getMediumStyle(color: Colors.black, fontSize: 20),
          ),
          bottom: TabBar(
            labelColor: AppColors.primary,
            indicatorColor: AppColors.primary,
            unselectedLabelColor: AppColors.grey,
            tabs: const [
              Tab(
                text: "Greutate",
              ),
              Tab(
                text: "Înălțime",
              ),
              Tab(
                text: "Circumferința capului",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GrowthWeight(
              currentKid: currentKid,
            ),
            GrowthHeight(
              currentKid: currentKid,
            ),
            GrowthHead(
              currentKid: currentKid,
            ),
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
                      title: const Text('Greutate'),
                      value: selectedOptions.contains('weight'),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedOptions.add('weight');
                          } else {
                            selectedOptions.remove('weight');
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Înălțime'),
                      value: selectedOptions.contains('height'),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedOptions.add('height');
                          } else {
                            selectedOptions.remove('height');
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Circumferința capului'),
                      value: selectedOptions.contains('head'),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedOptions.add('head');
                          } else {
                            selectedOptions.remove('head');
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

    if (selectedOptions.contains('weight')) {
      addWeightData(
          page, currentKid, headerFont, bodyFont, imageBytes, footerFont, ref);
    }
    if (selectedOptions.contains('height')) {
      addHeightData(
          page, currentKid, headerFont, bodyFont, imageBytes, footerFont, ref);
    }
    if (selectedOptions.contains('head')) {
      addHeadData(
          page, currentKid, headerFont, bodyFont, imageBytes, footerFont, ref);
    }
    try {
      final directory = await getExternalStorageDirectory();
      final file = File("${directory?.path}/CreștereaCopilului.pdf");
      await file.writeAsBytes(document.saveSync());
      document.dispose();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF Salvat: ${file.path}')),
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

  void addWeightData(
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
      'Monitorizarea greutății pentru ${kid.name}',
      headerFont,
      bounds: Rect.fromLTWH(0, 0, pageWidth, 30),
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    final weights = ref.read(kidWeightMeasurementsProvider(kid));
    final weightText = weights
        .map((weight) => '${weight.value} kg - ${formatTimestamp(weight.data)}')
        .join('\n');
    page.graphics.drawString(
      weightText,
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

  void addHeightData(
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
      'Monitorizarea înălțimii pentru ${kid.name}',
      headerFont,
      bounds: Rect.fromLTWH(
          0, page.graphics.clientSize.height * 0.25, pageWidth, 30),
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    final heights = ref.read(kidHeightMeasurementsProvider(kid));
    final heightText = heights
        .map((height) => '${height.value} cm - ${formatTimestamp(height.data)}')
        .join('\n');
    page.graphics.drawString(
      heightText,
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

  void addHeadData(PdfPage page, Kid kid, PdfFont headerFont, PdfFont bodyFont,
      Uint8List imageBytes, PdfFont footerFont, WidgetRef ref) {
    final pageWidth = page.getClientSize().width;
    final pageHeight = page.getClientSize().height;

    page.graphics.drawString(
      'Monitorizarea circumferinței capului pentru ${kid.name}',
      headerFont,
      bounds: Rect.fromLTWH(
          0, page.graphics.clientSize.height * 0.5, pageWidth, 30),
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    final headCircumferences = ref.read(kidHeadMeasurementsProvider(kid));
    final headText = headCircumferences
        .map((head) => '${head.value} cm - ${formatTimestamp(head.data)}')
        .join('\n');
    page.graphics.drawString(
      headText,
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
