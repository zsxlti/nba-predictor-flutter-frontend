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

  bool _isFetching = false;

  List<Stat> get stats => _stats;
  bool get isFetching => _isFetching;

  Future<void> fetchStatistics(
      {required String teamId,
      required String seasonId,
      required String statType}) async {
    _isFetching = true;
    notifyListeners();
    final finalUrl = Uri.parse("$url/api/stats/$seasonId/$teamId/$statType");
    final response =
        await http.get(finalUrl, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final values = jsonDecode(response.body);
      print(values);
      _stats.clear();
      for (var value in values) {
        _stats.add(Stat(value: value['stat_value'], date: value['game_date']));
      }
      //print(_stats);
      _isFetching = false;
      notifyListeners();
    } else {
      print(response.statusCode);
    }
  }

  void clearStatistics() async {
    _stats.clear();
    notifyListeners();
  }
}
