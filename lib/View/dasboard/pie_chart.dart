import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartCard extends StatelessWidget {
  final double screenWidth;
  final Map<String, double> dataMap;
  final List<Color> colorsList;

  const PieChartCard({
    Key? key,
    required this.screenWidth,
    required this.dataMap,
    required this.colorsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0), // Bo tròn góc
      ),
      elevation: 5, // Độ sâu của bóng đổ
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenWidth - 32, // Chiều rộng Card
          maxHeight: 150, // Chiều cao Card
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: PieChart(
                  colorList: colorsList,
                  dataMap: dataMap,
                  chartType: ChartType.ring,
                  chartLegendSpacing: 80,
                  chartRadius: screenWidth / 4, // Kích thước PieChart
                  legendOptions: const LegendOptions(
                    legendPosition: LegendPosition.right,
                    legendTextStyle: TextStyle(fontSize: 12),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValuesInPercentage: false,
                    showChartValues: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
