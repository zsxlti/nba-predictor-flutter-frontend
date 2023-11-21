import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/games.dart';

class GameCard extends StatefulWidget {
  final int gameId;

  GameCard(this.gameId);

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final gamesProvided = Provider.of<Games>(context);
    var games = gamesProvided.games;

    // Map létrehozása a csapatnevekkel
    Map<int, String> teamsNames = {
      1610612737: 'Atlanta Hawks',
      1610612738: 'Boston Celtics',
      1610612751: 'Brooklyn Nets',
      1610612766: 'Charlotte Hornets',
      1610612741: 'Chicago Bulls',
      1610612739: 'Cleveland Cavaliers',
      1610612742: 'Dallas Mavericks',
      1610612743: 'Denver Nuggets',
      1610612765: 'Detroit Pistons',
      1610612744: 'Golden State Warriors',
      1610612745: 'Houston Rockets',
      1610612754: 'Indiana Pacers',
      1610612746: 'Los Angeles Clippers',
      1610612747: 'Los Angeles Lakers',
      1610612763: 'Memphis Grizzlies',
      1610612748: 'Miami Heat',
      1610612749: 'Milwaukee Bucks',
      1610612750: 'Minnesota Timberwolves',
      1610612740: 'New Orleans Pelicans',
      1610612752: 'New York Knicks',
      1610612760: 'Oklahoma City Thunder',
      1610612753: 'Orlando Magic',
      1610612755: 'Philadelphia 76ers',
      1610612756: 'Phoenix Suns',
      1610612757: 'Portland Trail Blazers',
      1610612758: 'Sacramento Kings',
      1610612759: 'San Antonio Spurs',
      1610612761: 'Toronto Raptors',
      1610612762: 'Utah Jazz',
      1610612764: 'Washington Wizards',
    };

    // Formázott dátum létrehozása
    String formattedDate = DateFormat('yyyy.MM.dd').format(
      DateTime.parse(games[widget.gameId].date),
    );

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Color(0xFF1d3557),
        elevation: 5,
        child: ExpansionPanelList(
          elevation: 1,
          expandedHeaderPadding: EdgeInsets.zero,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          children: [
            ExpansionPanel(
              backgroundColor: Color(0xFFa8dadc),
              isExpanded: _isExpanded,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Container(
                  color: Color(0xFF1d3557),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    }, // Címsor háttérszíne
                    child: ListTile(
                      title: Text(
                        '${teamsNames[games[widget.gameId].team_id_home] ?? 'Unknown Team'} ${games[widget.gameId].pts_home.toInt()} - ${games[widget.gameId].pts_away.toInt()} ${teamsNames[games[widget.gameId].team_id_away] ?? 'Unknown Team'}',
                        style: TextStyle(
                          color: Color(0xFFa8dadc),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Date: $formattedDate',
                        style: TextStyle(
                          color: Color(0xFFa8dadc),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
              body: SingleChildScrollView(
                child: _isExpanded
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${games[widget.gameId].ast_home.toInt()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1d3557),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'AST',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1d3557),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${games[widget.gameId].ast_away.toInt()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1d3557),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${games[widget.gameId].reb_home.toInt()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1d3557),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'REB',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1d3557),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${games[widget.gameId].reb_away.toInt()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1d3557),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${games[widget.gameId].stl_home.toInt()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1d3557),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'STL',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1d3557),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${games[widget.gameId].stl_away.toInt()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1d3557),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${games[widget.gameId].blk_home.toInt()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1d3557),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'BLK',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1d3557),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${games[widget.gameId].blk_away.toInt()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1d3557),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${games[widget.gameId].tov_home.toInt()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1d3557),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'TOV',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1d3557),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${games[widget.gameId].tov_away.toInt()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1d3557),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${games[widget.gameId].pf_home.toInt()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1d3557),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'PF',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1d3557),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${games[widget.gameId].pf_away.toInt()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1d3557),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${games[widget.gameId].fga_home.toInt()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1d3557),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'FGA',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1d3557),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${games[widget.gameId].fga_away.toInt()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1d3557),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${games[widget.gameId].fgm_home.toInt()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1d3557),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'FGM',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1d3557),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${games[widget.gameId].fgm_away.toInt()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1d3557),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
