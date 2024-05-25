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

class MotorSkillSelectionChart extends ConsumerWidget {
  final List<SkillChartData> chartData;
  final String kid;

  const MotorSkillSelectionChart({super.key, required this.chartData, required this.kid});


  @override
  Widget build(BuildContext context, WidgetRef ref)  {
    final repo = ref.read(kidsRepositoryProvider);
    return Column(
      children: [
        SfCartesianChart(
          primaryXAxis: const CategoryAxis(),
          primaryYAxis: const NumericAxis(
              minimum: 0, maximum: 100, interval: 10),
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
            if(context.mounted){
              extractSkillsForPDF(context,currentKid!);}},
          child: appButton(text: "Save PDF")),
      ],
    );
  }

  Future<void> savePDF(Kid kid) async {
    final document = PdfDocument();
    final PdfFont headerFont = await loadCustomFont(18);
    final PdfFont bodyFont = await loadCustomFont(20);

    final motorSkillsPage = document.pages.add();
    addMotorSkillsData(motorSkillsPage, kid, headerFont, bodyFont);

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
      String text = 'Date salvate in fisierul: ProgresDezvoltareMotorie.pdf \n';
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
                  child: const Text('Close'),
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
              title: const Text('Error'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Failed to extract text from PDF: $e')
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Close'),
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

  void addMotorSkillsData(PdfPage page, Kid kid, PdfFont headerFont, PdfFont bodyFont) {
    final bounds = Rect.fromLTWH(0, 0, page.getClientSize().width, page.getClientSize().height);
    page.graphics.drawString('Progres dezvoltare cognitivă ${kid.name}', headerFont, bounds: bounds, brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    final skillsText = kid.motorSkills.map((e) => '${e.monthIndex}: ${e.skills}').join('\n');
    page.graphics.drawString(skillsText, bodyFont, bounds: Rect.fromLTWH(0, 30, page.getClientSize().width, page.getClientSize().height));
  }
}