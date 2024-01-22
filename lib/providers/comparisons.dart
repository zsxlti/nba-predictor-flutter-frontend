import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../globals/global.dart';

class Comparison {
  Team1? team1;
  Team2? team2;

  Comparison({this.team1, this.team2});

  Comparison.fromJson(Map<String, dynamic> json) {
    team1 = json['team_1'] != null ? new Team1.fromJson(json['team_1']) : null;
    team2 = json['team_2'] != null ? new Team2.fromJson(json['team_2']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.team1 != null) {
      data['team_1'] = this.team1!.toJson();
    }
    if (this.team2 != null) {
      data['team_2'] = this.team2!.toJson();
    }
    return data;
  }
}

class Team1 {
  int? avgFg3PctTeam1;
  int? avgFgPctTeam1;
  int? avgFtPctTeam1;
  int? teamId;
  int? totalAst;
  int? totalBlk;
  int? totalDreb;
  int? totalFg3a;
  int? totalFg3m;
  int? totalFga;
  int? totalFgm;
  int? totalFta;
  int? totalFtm;
  int? totalOreb;
  int? totalPf;
  int? totalPts;
  int? totalReb;
  int? totalStl;
  int? totalTov;

  Team1(
      {this.avgFg3PctTeam1,
      this.avgFgPctTeam1,
      this.avgFtPctTeam1,
      this.teamId,
      this.totalAst,
      this.totalBlk,
      this.totalDreb,
      this.totalFg3a,
      this.totalFg3m,
      this.totalFga,
      this.totalFgm,
      this.totalFta,
      this.totalFtm,
      this.totalOreb,
      this.totalPf,
      this.totalPts,
      this.totalReb,
      this.totalStl,
      this.totalTov});

  Team1.fromJson(Map<String, dynamic> json) {
    avgFg3PctTeam1 = json['avg_fg3_pct_team_1'];
    avgFgPctTeam1 = json['avg_fg_pct_team_1'];
    avgFtPctTeam1 = json['avg_ft_pct_team_1'];
    teamId = json['team_id'];
    totalAst = json['total_ast'];
    totalBlk = json['total_blk'];
    totalDreb = json['total_dreb'];
    totalFg3a = json['total_fg3a'];
    totalFg3m = json['total_fg3m'];
    totalFga = json['total_fga'];
    totalFgm = json['total_fgm'];
    totalFta = json['total_fta'];
    totalFtm = json['total_ftm'];
    totalOreb = json['total_oreb'];
    totalPf = json['total_pf'];
    totalPts = json['total_pts'];
    totalReb = json['total_reb'];
    totalStl = json['total_stl'];
    totalTov = json['total_tov'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg_fg3_pct_team_1'] = this.avgFg3PctTeam1;
    data['avg_fg_pct_team_1'] = this.avgFgPctTeam1;
    data['avg_ft_pct_team_1'] = this.avgFtPctTeam1;
    data['team_id'] = this.teamId;
    data['total_ast'] = this.totalAst;
    data['total_blk'] = this.totalBlk;
    data['total_dreb'] = this.totalDreb;
    data['total_fg3a'] = this.totalFg3a;
    data['total_fg3m'] = this.totalFg3m;
    data['total_fga'] = this.totalFga;
    data['total_fgm'] = this.totalFgm;
    data['total_fta'] = this.totalFta;
    data['total_ftm'] = this.totalFtm;
    data['total_oreb'] = this.totalOreb;
    data['total_pf'] = this.totalPf;
    data['total_pts'] = this.totalPts;
    data['total_reb'] = this.totalReb;
    data['total_stl'] = this.totalStl;
    data['total_tov'] = this.totalTov;
    return data;
  }
}

class Team2 {
  int? avgFg3PctTeam2;
  int? avgFgPctTeam2;
  int? avgFtPctTeam2;
  int? teamId;
  int? totalAst;
  int? totalBlk;
  int? totalDreb;
  int? totalFg3a;
  int? totalFg3m;
  int? totalFga;
  int? totalFgm;
  int? totalFta;
  int? totalFtm;
  int? totalOreb;
  int? totalPf;
  int? totalPts;
  int? totalReb;
  int? totalStl;
  int? totalTov;

  Team2(
      {this.avgFg3PctTeam2,
      this.avgFgPctTeam2,
      this.avgFtPctTeam2,
      this.teamId,
      this.totalAst,
      this.totalBlk,
      this.totalDreb,
      this.totalFg3a,
      this.totalFg3m,
      this.totalFga,
      this.totalFgm,
      this.totalFta,
      this.totalFtm,
      this.totalOreb,
      this.totalPf,
      this.totalPts,
      this.totalReb,
      this.totalStl,
      this.totalTov});

  Team2.fromJson(Map<String, dynamic> json) {
    avgFg3PctTeam2 = json['avg_fg3_pct_team_2'];
    avgFgPctTeam2 = json['avg_fg_pct_team_2'];
    avgFtPctTeam2 = json['avg_ft_pct_team_2'];
    teamId = json['team_id'];
    totalAst = json['total_ast'];
    totalBlk = json['total_blk'];
    totalDreb = json['total_dreb'];
    totalFg3a = json['total_fg3a'];
    totalFg3m = json['total_fg3m'];
    totalFga = json['total_fga'];
    totalFgm = json['total_fgm'];
    totalFta = json['total_fta'];
    totalFtm = json['total_ftm'];
    totalOreb = json['total_oreb'];
    totalPf = json['total_pf'];
    totalPts = json['total_pts'];
    totalReb = json['total_reb'];
    totalStl = json['total_stl'];
    totalTov = json['total_tov'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg_fg3_pct_team_2'] = this.avgFg3PctTeam2;
    data['avg_fg_pct_team_2'] = this.avgFgPctTeam2;
    data['avg_ft_pct_team_2'] = this.avgFtPctTeam2;
    data['team_id'] = this.teamId;
    data['total_ast'] = this.totalAst;
    data['total_blk'] = this.totalBlk;
    data['total_dreb'] = this.totalDreb;
    data['total_fg3a'] = this.totalFg3a;
    data['total_fg3m'] = this.totalFg3m;
    data['total_fga'] = this.totalFga;
    data['total_fgm'] = this.totalFgm;
    data['total_fta'] = this.totalFta;
    data['total_ftm'] = this.totalFtm;
    data['total_oreb'] = this.totalOreb;
    data['total_pf'] = this.totalPf;
    data['total_pts'] = this.totalPts;
    data['total_reb'] = this.totalReb;
    data['total_stl'] = this.totalStl;
    data['total_tov'] = this.totalTov;
    return data;
  }
}

class Comparisons with ChangeNotifier {
  final List<Comparison> _comparisons = [];

  List<Comparison> get comparisons => _comparisons;

  final url = Global.url;

  Future<void> fetchComparison({
    required String teamId1,
    required String teamId2,
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    const baseUrl = Global.url;

    // Formázott dátumok a kéréshez
    String formattedStartDate =
        startDate?.toIso8601String().split("T")[0] ?? '';
    String formattedEndDate = endDate?.toIso8601String().split("T")[0] ?? '';

    // Ellenőrzés, hogy legalább az egyik dátum meg van adva
    if (formattedStartDate.isEmpty && formattedEndDate.isEmpty) {
      print("Legalább az egyik dátumot meg kell adni.");
      return;
    }

    // Endpoint összeállítása a formázott dátumokkal
    String endpoint =
        '/api/game/stats/comparison/$teamId1/$teamId2/$formattedStartDate/$formattedEndDate';
    String url = '$baseUrl$endpoint';

    final response = await http
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});
    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      _comparisons.clear();

      if (data['team_1'] != null || data['team_2'] != null) {
        _comparisons.add(
          Comparison.fromJson({
            'team_1': data['team_1'] != null ? data['team_1'] : null,
            'team_2': data['team_2'] != null ? data['team_2'] : null,
          }),
        );
      }

      print(_comparisons);
      notifyListeners();
    } else {
      print(response.statusCode);
    }
  }
}
