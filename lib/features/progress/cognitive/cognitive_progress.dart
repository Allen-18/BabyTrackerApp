import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tracker/features/progress/skill_data.dart';

class CognitiveSkillSelectionChart extends StatelessWidget {
  final List<SkillChartData> chartData;

  const CognitiveSkillSelectionChart({super.key, required this.chartData});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: const CategoryAxis(),
      primaryYAxis: const NumericAxis(minimum: 0, maximum: 100, interval: 10),
      title: const ChartTitle(text: 'Progres dezvoltare cognitivă'),
      legend: const Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries>[
        ColumnSeries<SkillChartData, String>(
          dataSource: chartData,
          xValueMapper: (SkillChartData data, _) => data.monthIndex,
          yValueMapper: (SkillChartData data, _) => data.value,
          name: 'Dezvoltare cognitivă',
          color: Colors.blue,
        )
      ],
    );
  }
}
