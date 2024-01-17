import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../globals/global.dart';

class Stat {
  final double value;
  final String date;

  @override
  String toString() => '${this.value}';
  const Stat({required this.value, required this.date});
}

class Diagram with ChangeNotifier {
  final url = Global.url;

  List<Stat> _stats = [];

  List<Stat> _comparedStats = [];

  bool _isFetching = false;

  List<Stat> get stats => _stats;

  List<Stat> get comparedStats => _comparedStats;

  bool get isFetching => _isFetching;

  Future<void> fetchStatistics(
      {required String teamId,
      required String seasonId,
      required String statType}) async {
    try {
      _isFetching = true;
      notifyListeners();
      final finalUrl = Uri.parse("$url/api/stats/$seasonId/$teamId/$statType");
      final response = await http
          .get(finalUrl, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        final values = jsonDecode(response.body);
        _stats.clear();
        for (var value in values) {
          _stats
              .add(Stat(value: value['stat_value'], date: value['game_date']));
        }

        _isFetching = false;
        notifyListeners();
      } else {
        throw Exception('Unexpected error occured!');
      }
    } on TimeoutException {
      rethrow;
    }
  }

  Future<void> fetchStatisticsComparison({
    required String teamId,
    required String seasonId,
    required String teamId2,
    required String statType,
  }) async {
    _isFetching = true;
    _stats.clear();
    notifyListeners();

    final finalUrl =
        Uri.parse("$url/api/stats/$seasonId/$teamId/$teamId2/$statType");

    try {
      final response = await http
          .get(finalUrl, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        final values = jsonDecode(response.body);

        print(values);

        _comparedStats.clear();

        for (var value in values['team1']) {
          _stats.add(
            Stat(value: value['stat_value1'], date: value['game_date1']),
          );
        }

        for (var value in values['team2']) {
          _comparedStats.add(
            Stat(value: value['stat_value2'], date: value['game_date2']),
          );
        }

        _isFetching = false;
        notifyListeners();
      } else {
        print(response.statusCode);
        // Handle error cases here
      }
    } catch (error) {
      // Handle error cases here
    }
  }

  void clearStatistics() async {
    _stats.clear();
    _comparedStats.clear();
    _isFetching = false;
    notifyListeners();
  }
}
