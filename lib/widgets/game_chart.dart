import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/stats.dart';

class GameChart extends StatefulWidget {
  final List<Stat> data;
  const GameChart({Key? key, required this.data}) : super(key: key);

  @override
  State<GameChart> createState() => _GameChartState();
}

class _GameChartState extends State<GameChart> {
  List<Color> gradientColors = [
    Color(0xFF1d3557),
    Color(0xffe63946),
  ];

  double minY = 0;
  double maxY = 0;

  @override
  void initState() {
    super.initState();
    calculateMinMaxValues();
  }

  void calculateMinMaxValues() {
    double minValue = double.infinity;
    double maxValue = double.negativeInfinity;

    for (var stat in widget.data) {
      if (stat.value < minValue) {
        minValue = stat.value;
      }

      if (stat.value > maxValue) {
        maxValue = stat.value;
      }
    }

    setState(() {
      minY = minValue;
      maxY = maxValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 0.8,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 12,
              left: 6,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text = const Text('');

    switch (value.toInt()) {
      case 10:
        text = Text(
          DateFormat('MM/dd').format(DateTime.parse(widget.data[10].date)),
          style: style,
        );
        break;
      case 30:
        text = Text(
          DateFormat('MM/dd').format(DateTime.parse(widget.data[30].date)),
          style: style,
        );
        break;
      case 50:
        text = Text(
          DateFormat('MM/dd').format(DateTime.parse(widget.data[50].date)),
          style: style,
        );
        break;
      case 70:
        text = Text(
          DateFormat('MM/dd').format(DateTime.parse(widget.data[70].date)),
          style: style,
        );
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    // String text;
    // switch (value.toInt()) {
    //   case 1:
    //     text = '10K';
    //     break;
    //   case 3:
    //     text = '30k';
    //     break;
    //   case 5:
    //     text = '50k';
    //     break;
    //   default:
    //     return Container();
    // }

    return Text('', style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    calculateMinMaxValues();
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: (maxY - minY) / 5,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: (maxY - minY) / 5,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: Color(0xFF1d3557),
          width: 2,
        ),
      ),
      minX: 0,
      maxX: widget.data.length.toDouble() - 1,
      minY: minY - 1,
      maxY: maxY * 1.1,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
            widget.data.length,
            (index) => FlSpot(index.toDouble(), widget.data[index].value),
          ),
          isCurved: true,
          color: Color(0xFF1d3557),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: Color.fromRGBO(230, 57, 70, 0.5),
          ),
        ),
      ],
    );
  }
}
