import 'package:flutter/material.dart';
import 'package:frontend/widgets/game_chart.dart';
import 'package:provider/provider.dart';

import '../providers/stats.dart';

class DiagramScreen extends StatefulWidget {
  @override
  _DiagramScreenState createState() => _DiagramScreenState();
}

class _DiagramScreenState extends State<DiagramScreen> {
  String? _selectedTeam;
  String? _selectedSeason;
  String? _selectedType;

  Map<String, String> teams = {
    'Atlanta Hawks': '1610612737',
    'Boston Celtics': '1610612738',
    'Brooklyn Nets': '1610612751',
    'Charlotte Hornets': '1610612766',
    'Chicago Bulls': '1610612741',
    'Cleveland Cavaliers': '1610612739',
    'Dallas Mavericks': '1610612742',
    'Denver Nuggets': '1610612743',
    'Detroit Pistons': '1610612765',
    'Golden State Warriors': '1610612744',
    'Houston Rockets': '1610612745',
    'Indiana Pacers': '1610612754',
    'Los Angeles Clippers': '1610612746',
    'Los Angeles Lakers': '1610612747',
    'Memphis Grizzlies': '1610612763',
    'Miami Heat': '1610612748',
    'Milwaukee Bucks': '1610612749',
    'Minnesota Timberwolves': '1610612750',
    'New Orleans Pelicans': '1610612740',
    'New York Knicks': '1610612752',
    'Oklahoma City Thunder': '1610612760',
    'Orlando Magic': '1610612753',
    'Philadelphia 76ers': '1610612755',
    'Phoenix Suns': '1610612756',
    'Portland Trail Blazers': '1610612757',
    'Sacramento Kings': '1610612758',
    'San Antonio Spurs': '1610612759',
    'Toronto Raptors': '1610612761',
    'Utah Jazz': '1610612762',
    'Washington Wizards': '1610612764',
  };

  List<String> seasons = [
    '1990',
    '1991',
    '1992',
    '1993',
    '1994',
    '1995',
    '1996',
    '1997',
    '1998',
    '1999',
    '2000',
    '2001',
    '2002',
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',
    '2009',
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
  ];

  Map<String, String> types = {
    'Points': 'pts',
    'Rebounds': 'reb',
    'Assists': 'ast',
    'Steals': 'stl',
    'Blocks': 'blk',
    'Turnovers': 'tov',
    'Personal fouls': 'pf',
  };

  bool _isDiagramGenerated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              hint: _selectedTeam == null
                  ? Text('Please select a team')
                  : Text(
                      _selectedTeam!,
                      style: TextStyle(color: Color(0xFF1d3557)),
                    ),
              items: teams.keys.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _selectedTeam = value;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              hint: _selectedSeason == null
                  ? Text('Please select a season')
                  : Text(
                      _selectedSeason!,
                      style: TextStyle(color: Color(0xFF1d3557)),
                    ),
              items: seasons.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _selectedSeason = value;
                  });
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButton<String>(
              isExpanded: true,
              hint: _selectedType == null
                  ? Text('Please select a stattype')
                  : Text(
                      _selectedType!,
                      style: TextStyle(color: Color(0xFF1d3557)),
                    ),
              items: types.keys.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _selectedType = value;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF457b9d),
              ),
              onPressed: (_selectedTeam != null &&
                      _selectedSeason != null &&
                      _selectedType != null)
                  ? () async {
                      await context.read<Diagram>().fetchStatistics(
                          seasonId: _selectedSeason!,
                          teamId: teams[_selectedTeam]!,
                          statType: types[_selectedType]!);
                      setState(() {
                        _isDiagramGenerated = true;
                      });
                    }
                  : null,
              child: Text(
                'Generate diagram',
                style: TextStyle(color: Color(0xFFf1faee)),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              // New Clear button
              style: ElevatedButton.styleFrom(
                fixedSize: Size(120, 40),
                backgroundColor: Colors.grey,
              ),
              onPressed: (_isDiagramGenerated)
                  ? () {
                      context.read<Diagram>().clearStatistics();
                      setState(() {
                        _isDiagramGenerated = false;
                      });
                    }
                  : null,
              child: Text(
                'Clear diagram',
                style: TextStyle(color: Color(0xFFf1faee)),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Consumer<Diagram>(
                builder: ((context, value, child) {
                  if (!_isDiagramGenerated ||
                      (value.stats.isEmpty && !value.isFetching)) {
                    // Stats have not been fetched yet or diagram not generated
                    return SizedBox();
                  } else if (value.stats.isEmpty && value.isFetching) {
                    // Fetching stats, you can show a loading indicator here
                    return CircularProgressIndicator();
                  } else {
                    // Stats have been fetched, display the chart
                    return SingleChildScrollView(
                      child: InteractiveViewer(
                        boundaryMargin: const EdgeInsets.all(20.0),
                        minScale: 0.1,
                        maxScale: 3.6,
                        child: GameChart(data: value.stats),
                      ),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
