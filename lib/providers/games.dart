import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../globals/global.dart';

class Game {
  final int gameId;
  final String date;
  final int team_id_home;
  final int team_id_away;
  final double pts_home;
  final double pts_away;
  final double ast_home;
  final double ast_away;
  final double reb_home;
  final double reb_away;
  final double stl_home;
  final double stl_away;
  final double blk_home;
  final double blk_away;
  final double tov_home;
  final double tov_away;
  final double pf_home;
  final double pf_away;
  final double fga_home;
  final double fgm_home;
  final double fga_away;
  final double fgm_away;

  const Game({
    required this.gameId,
    required this.date,
    required this.team_id_home,
    required this.team_id_away,
    required this.pts_home,
    required this.pts_away,
    required this.ast_home,
    required this.ast_away,
    required this.reb_home,
    required this.reb_away,
    required this.stl_home,
    required this.stl_away,
    required this.blk_home,
    required this.blk_away,
    required this.tov_home,
    required this.tov_away,
    required this.pf_home,
    required this.pf_away,
    required this.fga_home,
    required this.fgm_home,
    required this.fga_away,
    required this.fgm_away,
  });
}

class Games with ChangeNotifier {
  final List<Game> _allGames = [];
  final List<Game> _seasonGames = [];

  List<Game> get games => _seasonGames.isNotEmpty ? _seasonGames : _allGames;

  final url = Global.url;

  Future<void> fetchData(
      {required String teamId1, required String teamId2}) async {
    const baseUrl = Global.url;
    String endpoint = '/api/game/stats/$teamId1/$teamId2';
    String url = '$baseUrl$endpoint';

    final response = await http
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final values = jsonDecode(response.body);
      _allGames.clear();
      for (var value in values) {
        _allGames.add(Game(
            gameId: value['id'],
            date: value['date'],
            team_id_home: value['team_id_home'],
            team_id_away: value['team_id_away'],
            pts_home: value['pts_home'],
            pts_away: value['pts_away'],
            ast_home: value['ast_home'],
            ast_away: value['ast_away'],
            reb_home: value['reb_home'],
            reb_away: value['reb_away'],
            stl_home: value['stl_home'],
            stl_away: value['stl_away'],
            blk_home: value['blk_home'],
            blk_away: value['blk_away'],
            tov_home: value['tov_home'],
            tov_away: value['tov_away'],
            pf_home: value['pf_home'],
            pf_away: value['pf_away'],
            fga_home: value['fga_home'],
            fgm_home: value['fgm_home'],
            fga_away: value['fga_away'],
            fgm_away: value['fgm_away']));
      }
      //print(_allGames);
      notifyListeners();
    } else {
      print(response.statusCode);
    }
  }

  Future<void> fetchDataBySeason(
      {required String teamId1,
      required String teamId2,
      required String seasonId}) async {
    const baseUrl = Global.url;
    String endpoint = '/api/game/stats/$teamId1/$teamId2/$seasonId';
    String url = '$baseUrl$endpoint';

    final response = await http
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final values = jsonDecode(response.body);
      _seasonGames.clear();
      for (var value in values) {
        //print('PRocessing game: $value');
        _seasonGames.add(Game(
            gameId: value['id'],
            date: value['date'],
            team_id_home: value['team_id_home'],
            team_id_away: value['team_id_away'],
            pts_home: value['pts_home'],
            pts_away: value['pts_away'],
            ast_home: value['ast_home'],
            ast_away: value['ast_away'],
            reb_home: value['reb_home'],
            reb_away: value['reb_away'],
            stl_home: value['stl_home'],
            stl_away: value['stl_away'],
            blk_home: value['blk_home'],
            blk_away: value['blk_away'],
            tov_home: value['tov_home'],
            tov_away: value['tov_away'],
            pf_home: value['pf_home'],
            pf_away: value['pf_away'],
            fga_home: value['fga_home'],
            fgm_home: value['fgm_home'],
            fga_away: value['fga_away'],
            fgm_away: value['fgm_away']));
      }
      print(_seasonGames);
      notifyListeners();
    } else {
      print(response.statusCode);
    }
  }

  void clearGames() async {
    _seasonGames.clear();
    notifyListeners();
  }
}
