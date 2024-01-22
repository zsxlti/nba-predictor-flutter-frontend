import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comparisons.dart';

class ComparisonTable extends StatefulWidget {
  final Comparison stats;

  ComparisonTable(this.stats);

  @override
  State<ComparisonTable> createState() => _ComparisonTableState();
}

class _ComparisonTableState extends State<ComparisonTable> {
  @override
  Widget build(BuildContext context) {
    final comparisonProvided = Provider.of<Comparisons>(context);
    var comparisons = comparisonProvided.comparisons;

    Map<int, String> teams = {
      1610612737: 'ATL',
      1610612738: 'BOS',
      1610612751: 'BKN',
      1610612766: 'CHA',
      1610612741: 'CHI',
      1610612739: 'CLE',
      1610612742: 'DAL',
      1610612743: 'DEN',
      1610612765: 'DET',
      1610612744: 'GSW',
      1610612745: 'HOU',
      1610612754: 'IND',
      1610612746: 'LAC',
      1610612747: 'LAL',
      1610612763: 'MEM',
      1610612748: 'MIA',
      1610612749: 'MIL',
      1610612750: 'MIN',
      1610612740: 'NOP',
      1610612752: 'NYK',
      1610612760: 'OKC',
      1610612753: 'ORL',
      1610612755: 'PHI',
      1610612756: 'PHX',
      1610612757: 'POR',
      1610612758: 'SAC',
      1610612759: 'SAS',
      1610612761: 'TOR',
      1610612762: 'UTA',
      1610612764: 'WAS',
    };

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFirstRow(
              teams[widget.stats.team1?.teamId] ?? '',
              teams[widget.stats.team2?.teamId] ?? '',
            ),
            _buildRow(
              'Total PTS',
              widget.stats.team1?.totalPts ?? 0,
              widget.stats.team2?.totalPts ?? 0,
            ),
            _buildRow(
              'Total AST',
              widget.stats.team1?.totalAst ?? 0,
              widget.stats.team2?.totalAst ?? 0,
            ),
            _buildRow(
              'Total REB',
              widget.stats.team1?.totalReb ?? 0,
              widget.stats.team2?.totalReb ?? 0,
            ),
            _buildRow(
              'Total DREB',
              widget.stats.team1?.totalDreb ?? 0,
              widget.stats.team2?.totalDreb ?? 0,
            ),
            _buildRow(
              'Total OREB',
              widget.stats.team1?.totalOreb ?? 0,
              widget.stats.team2?.totalOreb ?? 0,
            ),
            _buildRow(
              'Total BLK',
              widget.stats.team1?.totalBlk ?? 0,
              widget.stats.team2?.totalBlk ?? 0,
            ),
            _buildRow(
              'Total STL',
              widget.stats.team1?.totalStl ?? 0,
              widget.stats.team2?.totalStl ?? 0,
            ),
            _buildRow(
              'Total TOV',
              widget.stats.team1?.totalTov ?? 0,
              widget.stats.team2?.totalTov ?? 0,
            ),
            _buildRow(
              'Total PF',
              widget.stats.team1?.totalPf ?? 0,
              widget.stats.team2?.totalPf ?? 0,
              isSmallerGreen: true,
            ),

            _buildRow(
              'Total FGA',
              widget.stats.team1?.totalFga ?? 0,
              widget.stats.team2?.totalFga ?? 0,
            ),
            _buildRow(
              'Total FGM',
              widget.stats.team1?.totalFgm ?? 0,
              widget.stats.team2?.totalFgm ?? 0,
            ),
            _buildRow(
              'Total FG3A',
              widget.stats.team1?.totalFg3a ?? 0,
              widget.stats.team2?.totalFg3a ?? 0,
            ),
            _buildRow(
              'Total FG3M',
              widget.stats.team1?.totalFg3m ?? 0,
              widget.stats.team2?.totalFg3m ?? 0,
            ),
            _buildRow(
              'Total FTA',
              widget.stats.team1?.totalFta ?? 0,
              widget.stats.team2?.totalFta ?? 0,
            ),
            _buildRow(
              'Total FTM',
              widget.stats.team1?.totalFtm ?? 0,
              widget.stats.team2?.totalFtm ?? 0,
            ),
            // ... (add more rows as needed)
          ],
        ),
      ),
    );
  }

  Widget _buildFirstRow(String team1, String team2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '                                 ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(team1, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(team2, style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Diff.', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRow(String label, int value1, int value2,
      {bool isSmallerGreen = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(label),
              Spacer(),
              _buildTextContainer(value1, value2, isSmallerGreen),
              _buildTextContainer(value2, value1, isSmallerGreen),
              (label != 'Team')
                  ? _buildTextDifferenceContainer(
                      value1, value2, isSmallerGreen)
                  : Container(),
            ],
          ),
          Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildTextContainer(int value, int otherValue, bool isSmallerGreen) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: _buildTextWithColor(value, otherValue, isSmallerGreen),
        ),
      ),
    );
  }

  Widget _buildTextDifferenceContainer(
      int value1, int value2, bool isSmallerGreen) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: _buildTextDifference(value1, value2, isSmallerGreen),
        ),
      ),
    );
  }

  Widget _buildTextWithColor(int value, int otherValue, bool isSmallerGreen) {
    bool isValueGreater = value > otherValue;

    return RichText(
      textAlign: TextAlign.end,
      text: TextSpan(
        style: TextStyle(
          color: (isValueGreater && !isSmallerGreen) ||
                  (!isValueGreater && isSmallerGreen)
              ? Colors.green
              : Colors.black,
          fontWeight: (isValueGreater && !isSmallerGreen) ||
                  (!isValueGreater && isSmallerGreen)
              ? FontWeight.bold
              : FontWeight.normal,
        ),
        children: [
          TextSpan(text: '$value'),
        ],
      ),
    );
  }

  Widget _buildTextDifference(int value1, int value2, bool isSmallerGreen) {
    int difference = (value1 - value2).abs();
    return Text(
      '$difference',
      style: TextStyle(
        color: isSmallerGreen ? Colors.green : Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
