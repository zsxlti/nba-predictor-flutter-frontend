import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/stats.dart';

class GameChart extends StatefulWidget {
  final List<Stat> data;
  final List<Stat> data2;
  final String? selectedTeam;
  final String? selectedTeam2;
  final bool isComparison;
  final bool isDiagramGenerated;

  const GameChart({
    Key? key,
    required this.data,
    required this.data2,
    required this.selectedTeam,
    required this.selectedTeam2,
    required this.isComparison,
    required this.isDiagramGenerated,
  }) : super(key: key);

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
    double minCommonValue = double.infinity;
    double maxCommonValue = double.negativeInfinity;

    // Az első csapat adatainak ellenőrzése
    for (var stat in widget.data) {
      if (stat.value < minCommonValue) {
        minCommonValue = stat.value;
      }

      if (stat.value > maxCommonValue) {
        maxCommonValue = stat.value;
      }
    }

    // A második csapat adatainak ellenőrzése
    for (var stat in widget.data2) {
      if (stat.value < minCommonValue) {
        minCommonValue = stat.value;
      }

      if (stat.value > maxCommonValue) {
        maxCommonValue = stat.value;
      }
    }

    setState(() {
      minY = minCommonValue;
      maxY = maxCommonValue;
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

        // A címkék megjelenítése a diagram alatt
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLabel(widget.selectedTeam!, Color(0xFF1d3557)),
                if (widget.data2.isNotEmpty)
                  _buildLabel(widget.selectedTeam2!, Colors.green),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Címke widget létrehozása
  Widget _buildLabel(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 10),
        Text(label),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
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
      fontSize: 12,
    );

    if (value < minY - 1 && value > maxY + 0.5) {
      return Container();
    }

    return Container(
      margin: const EdgeInsets.only(left: 16.0),
      child: Text(
        value.toStringAsFixed(0),
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  LineChartData mainData() {
    calculateMinMaxValues();

    List<FlSpot> selectedTeamSpots = [];
    List<FlSpot> selectedTeam2Spots = [];

    // If both teams' data are available
    if (widget.isComparison &&
        widget.selectedTeam2 != null &&
        widget.data2.isNotEmpty) {
      // The first team's data in blue
      selectedTeamSpots = List.generate(
        widget.data.length,
        (index) => FlSpot(index.toDouble(), widget.data[index].value),
      );

      // The second team's data in green
      selectedTeam2Spots = List.generate(
        widget.data2.length,
        (index) => FlSpot(index.toDouble(), widget.data2[index].value),
      );
    } else if (!widget.isComparison && widget.data.isNotEmpty) {
      // If only the first team's data is available
      selectedTeamSpots = List.generate(
        widget.data.length,
        (index) => FlSpot(index.toDouble(), widget.data[index].value),
      );
    }

    if (!widget.isDiagramGenerated ||
        (widget.isComparison && widget.data2.isEmpty)) {
      return LineChartData(); // Empty chart, as no data needs to be displayed
    }

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: (maxY - minY),
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
      minY: minY - 1.5,
      maxY: maxY * 1.1,
      lineBarsData: [
        LineChartBarData(
          spots: selectedTeamSpots,
          isCurved: true,
          color: Color(0xFF1d3557),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
        ),
        if (widget.data2.isNotEmpty)
          LineChartBarData(
            spots: selectedTeam2Spots,
            isCurved: true,
            color: Colors.green,
            barWidth: 1,
            isStrokeCapRound: true,
            dotData: const FlDotData(
              show: false,
            ),
          ),
      ],
    );
  }
}
