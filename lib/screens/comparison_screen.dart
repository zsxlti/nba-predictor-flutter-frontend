import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/comparisons.dart';
import '../widgets/comparison_table.dart';

class ComparisonScreen extends StatefulWidget {
  @override
  _ComparisonScreenState createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  late Future futureData;

  DateTime? _startDate;
  DateTime? _endDate;

  Future obtainFutureData() {
    String? teamId1 = teams[selectedTeam1 ?? ''];
    String? teamId2 = teams[selectedTeam2 ?? ''];

    if (teamId1 == null || teamId2 == null) {
      _showErrorSnackBar('Please select both teams');
      return Future.error('');
    }

    if (_startDate == null ||
        _endDate == null ||
        _startDate!.isAfter(_endDate!)) {
      _showErrorSnackBar(
          'Invalid date range. End date must be after or equal to start date.');
      return Future.error('');
    }
    return Provider.of<Comparisons>(context, listen: false).fetchComparison(
        teamId1: teamId1,
        teamId2: teamId2,
        startDate: _startDate,
        endDate: _endDate);
  }

  bool showStatistics = false;

  void _showErrorSnackBar(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  void initState() {
    super.initState();
    //print("initialized");
    futureData = obtainFutureData();
    startDateController.text = "";
    endDateController.text = "";
  }

  String? selectedTeam1;
  String? selectedTeam2;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              isExpanded: true,
              dropdownColor: Color(0xFFf1faee),
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
            SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              dropdownColor: Color(0xFFf1faee),
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
            SizedBox(height: 20),
            TextField(
              controller: startDateController,
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Start Date",
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _startDate ?? null,
                  firstDate: DateTime(1990, 11, 2),
                  lastDate: DateTime(2023, 3, 10),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat("yyyy-MM-dd").format(pickedDate);

                  setState(() {
                    _startDate = pickedDate;
                    startDateController.text = formattedDate;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: endDateController,
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "End Date",
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _endDate ?? null,
                  firstDate: DateTime(1990, 11, 2),
                  lastDate: DateTime(2023, 3, 10),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat("yyyy-MM-dd").format(pickedDate);

                  setState(() {
                    _endDate = pickedDate;
                    endDateController.text = formattedDate;
                  });
                }
              },
            ),
            SizedBox(height: 20),
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
                        if (_startDate == null || _endDate == null) {
                          // Ha nincs kiválasztva szezon, akkor ürítsük a statisztikákat
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Warning'),
                                content: Text(
                                    'Please select a start and end date for comparison.'),
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
                        }
                      });
                    }
                  : null,
              child: Text(
                'Show statistics',
                style: const TextStyle(color: Color(0xFF1d3557)),
              ),
            ),
            SizedBox(height: 20),
            Column(children: [
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
                        return Consumer<Comparisons>(
                          builder: (ctx, data, child) => ListView.builder(
                            itemCount: data.comparisons.length,
                            itemBuilder: (context, index) {
                              return ComparisonTable(data.comparisons[index]);
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
            ]),
          ],
        ),
      ),
    );
  }
}
