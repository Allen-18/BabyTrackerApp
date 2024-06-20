import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tracker/features/progress/skill_data.dart';
import 'package:tracker/features/children/kids.dart';
import 'package:tracker/features/children/kids_repository.dart';
import 'package:tracker/features/progress/components/load_custom_font.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'package:tracker/helpers/widget_manager.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tracker/features/common/utils/utils.dart';

class MotorSkillSelectionChart extends ConsumerWidget {
  final List<SkillChartData> chartData;
  final String kid;

  const MotorSkillSelectionChart(
      {super.key, required this.chartData, required this.kid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(kidsRepositoryProvider);
    return Column(
      children: [
        SfCartesianChart(
          primaryXAxis: const CategoryAxis(),
          primaryYAxis:
              const NumericAxis(minimum: 0, maximum: 100, interval: 10),
          title: const ChartTitle(text: 'Progres dezvoltare motorie'),
          legend: const Legend(isVisible: true),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CartesianSeries>[
            ColumnSeries<SkillChartData, String>(
              dataSource: chartData,
              xValueMapper: (SkillChartData data, _) => data.monthIndex,
              yValueMapper: (SkillChartData data, _) => data.value,
              name: 'Dezvoltare motorie',
              color: AppColors.primary,
            )
          ],
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () async {
            final currentKid = await repo.getKid(kid);
            if (context.mounted) {
              extractSkillsForPDF(context, currentKid!);
            }
          },
          child: appButton(text: "Salvează PDF"),
        ),
      ],
    );
  }

  Future<void> savePDF(Kid kid) async {
    final document = PdfDocument();
    final PdfFont headerFont = await loadCustomFont(18);
    final PdfFont bodyFont = await loadCustomFont(20);
    final PdfFont footerFont = await loadCustomFont(20);
    final imageData = await rootBundle.load('assets/images/logo.png');
    final imageBytes = imageData.buffer.asUint8List();

    final motorSkillsPage = document.pages.add();
    addMotorSkillsData(
        motorSkillsPage, kid, headerFont, bodyFont, imageBytes, footerFont);

    try {
      final directory = await getExternalStorageDirectory();
      final file = File("${directory?.path}/ProgresDezvoltareMotorie.pdf");
      await file.writeAsBytes(document.saveSync());
      document.dispose();
      if (kDebugMode) {
        print('PDF Saved: ${file.path}');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Failed to save PDF: $e");
      }
    }
  }

  void extractSkillsForPDF(BuildContext context, Kid kid) async {
    await savePDF(kid);
    final directory = await getExternalStorageDirectory();
    String filePath = '${directory?.path}/ProgresDezvoltareMotorie.pdf';

    try {
      final bytes = await File(filePath).readAsBytes();
      final document = PdfDocument(inputBytes: bytes);
      String text =
          'Datele salvate în fișierul: ProgresDezvoltareMotorie.pdf \n';
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Progres dezvoltare motorie'),
              content: SingleChildScrollView(
                child: Text(text),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Închide'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      document.dispose();
    } catch (e) {
      if (kDebugMode) {
        print('Failed to extract text from PDF: $e');
      }
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Eroare'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Eșec la extragerea textului din PDF: $e')
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Închide'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  void addMotorSkillsData(PdfPage page, Kid kid, PdfFont headerFont,
      PdfFont bodyFont, Uint8List imageBytes, PdfFont footerFont) {
    final pageWidth = page.getClientSize().width;
    final pageHeight = page.getClientSize().height;
    page.graphics.drawString(
      'Progres dezvoltare motorie pentru ${kid.name}',
      headerFont,
      bounds: Rect.fromLTWH(0, 0, pageWidth, 30),
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    );

    final skillsText = kid.motorSkills.map((e) {
      final skills =
          e.skills != null ? e.skills?.map((s) => '- $s').join('\n  ') : '';
      return 'Progres ${getTextForMonth(e.monthIndex)} - înregistrată la data de ${formatDateOnly(e.timestamp)}\n  $skills';
    }).join('\n\n');
    page.graphics.drawString(
      skillsText,
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
}
