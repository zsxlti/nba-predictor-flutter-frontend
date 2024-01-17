import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../globals/global.dart';

class Comparison {
  final int totalPts;
  final int totalAst;
  final int totalReb;
  final int totalDreb;
  final int totalOreb;
  final int totalStl;
  final int totalBlk;
  final int totalTov;
  final int totalPf;
  final int totalFga;
  final int totalFgm;
  final int totalFga3;
  final int totalFgm3;
  final int totalFta;
  final int totalFtm;
  final double avgFgPctHome;
  final double avgFg3PctHome;
  final double avgFtPctHome;

  const Comparison({
    required this.totalPts,
    required this.totalAst,
    required this.totalReb,
    required this.totalDreb,
    required this.totalOreb,
    required this.totalStl,
    required this.totalBlk,
    required this.totalTov,
    required this.totalPf,
    required this.totalFga,
    required this.totalFgm,
    required this.totalFga3,
    required this.totalFgm3,
    required this.totalFta,
    required this.totalFtm,
    required this.avgFgPctHome,
    required this.avgFg3PctHome,
    required this.avgFtPctHome,
  });
}

class Comparisons with ChangeNotifier {
  final List<Comparison> _comparisons = [];

  List<Comparison> get comparisons => _comparisons;

  final url = Global.url;

  Future<void> fetchComparison(
      {required int teamId1,
      required int teamId2,
      required String startDate,
      required String endDate}) async {
    const baseUrl = Global.url;
    String endpoint =
        '/api/game/stats/comparison/$teamId1/$teamId2/$startDate/$endDate';
    String url = '$baseUrl$endpoint';
    final response = await http
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final values = jsonDecode(response.body);
      _comparisons.clear();
      for (var value in values) {
        _comparisons.add(Comparison(
          totalPts: value['total_pts'],
          totalAst: value['total_ast'],
          totalReb: value['total_reb'],
          totalDreb: value['total_dreb'],
          totalOreb: value['total_oreb'],
          totalStl: value['total_stl'],
          totalBlk: value['total_blk'],
          totalTov: value['total_tov'],
          totalPf: value['total_pf'],
          totalFga: value['total_fga'],
          totalFgm: value['total_fgm'],
          totalFga3: value['total_fg3a'],
          totalFgm3: value['total_fg3m'],
          totalFta: value['total_fta'],
          totalFtm: value['total_ftm'],
          avgFgPctHome: value['avg_fg_pct'],
          avgFg3PctHome: value['avg_fg3_pct'],
          avgFtPctHome: value['avg_ft_pct'],
        ));
      }
      //print(_allGames);
      notifyListeners();
    } else {
      print(response.statusCode);
    }
  }
}
