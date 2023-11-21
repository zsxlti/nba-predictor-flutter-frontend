import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/games.dart';

import '../widgets/game_card.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late Future futureData;

  Future obtainFutureData() {
    String? teamId1 = teams[selectedTeam1 ?? ''];
    String? teamId2 = teams[selectedTeam2 ?? ''];

    if (teamId1 == null || teamId2 == null) {
      return Future.error('Please select both teams');
    }

    if (selectedSeason == null) {
      return Provider.of<Games>(context, listen: false)
          .fetchData(teamId1: teamId1, teamId2: teamId2);
    } else {
      return Provider.of<Games>(context, listen: false).fetchDataBySeason(
          teamId1: teamId1, teamId2: teamId2, seasonId: selectedSeason!);
    }
  }

  bool showStatistics = false;

  void clearSelection() {
    setState(() {
      selectedSeason = null;
    });
  }

  @override
  void initState() {
    super.initState();
    //print("initialized");
    futureData = obtainFutureData();
  }

  String? selectedTeam1;
  String? selectedTeam2;
  String? selectedSeason;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              isExpanded: true,
              hint: selectedTeam1 == null
                  ? Text('Please select a team')
                  : Text(
                      selectedTeam1!,
                      style: const TextStyle(color: Color(0xFF1d3557)),
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
                    selectedTeam1 = value;
                  });
                }
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            DropdownButton<String>(
              isExpanded: true,
              hint: selectedTeam2 == null
                  ? Text('Please select another team')
                  : Text(
                      selectedTeam2!,
                      style: const TextStyle(color: Color(0xFF1d3557)),
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
                    selectedTeam2 = value;
                  });
                }
              },
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Please select a season (optional)'),
                    value: selectedSeason,
                    style: const TextStyle(color: Color(0xFF1d3557)),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSeason = newValue;
                      });
                    },
                    items: seasons.map((String season) {
                      return DropdownMenuItem<String>(
                        value: season,
                        child: Text(season),
                      );
                    }).toList(),
                  ),
                ),
                if (selectedSeason != null)
                  GestureDetector(
                    onTap: clearSelection,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Icon(Icons.clear),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFa8dadc),
              ),
              onPressed: (selectedTeam1 != null && selectedTeam2 != null)
                  ? () async {
                      // Ellenőrizze, hogy a két kiválasztott csapat különböző-e
                      if (selectedTeam1 == selectedTeam2) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Warning'),
                              content: Text(
                                  'Please select different teams for statistics.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                        return; // Ne folytassa tovább, ha a csapatok egyeznek
                      }

                      setState(() {
                        showStatistics = true;
                        futureData = obtainFutureData();
                        if (selectedSeason == null) {
                          // Ha nincs kiválasztva szezon, akkor ürítsük a statisztikákat
                          Provider.of<Games>(context, listen: false)
                              .clearGames();
                        }
                      });
                    }
                  : null,
              child: Text(
                'Show statistics',
                style: const TextStyle(color: Color(0xFF1d3557)),
              ),
            ),
            SizedBox(height: 16.0),

            // Display Game Cards
            Column(
              children: [
                if (showStatistics)
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: FutureBuilder(
                      future: futureData,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          // Rendezzük a játékokat dátum szerint csökkenő sorrendben
                          List<Game> sortedGames =
                              Provider.of<Games>(context).games;
                          sortedGames.sort((a, b) => DateTime.parse(b.date)
                              .compareTo(DateTime.parse(a.date)));
                          return Consumer<Games>(
                            builder: (ctx, data, child) => ListView.builder(
                              itemCount: data.games.length,
                              itemBuilder: (context, index) {
                                return GameCard(index);
                              },
                            ),
                          );
                        } else {
                          // By default show a loading spinner.
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
