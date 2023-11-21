import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../globals/global.dart';

class Auth with ChangeNotifier {
  int? _userId;
  String? _token;

  bool get isAuth {
    return token != null;
  }

  int? get getUserId {
    return _userId;
  }

  String? get token {
    return _token;
  }

  final url = Global.url;

  Future<void> signup(String username, String password) async {
    Map<String, String> header = {"Content-Type": "application/json"};
    var finalUrl = '$url/api/register';
    try {
      var response = await http.post(
        Uri.parse(finalUrl),
        headers: header,
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );
      if (response.statusCode != 201) {
        throw Exception();
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> login(String username, String password) async {
    Map<String, String> header = {"Content-Type": "application/json"};
    var finalUrl = '$url/api/login';
    try {
      var response = await http
          .post(
            Uri.parse(finalUrl),
            headers: header,
            body: json.encode({
              'username': username,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 3));
      final responseData = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception();
      }
      _userId = responseData['id'];
      _token = responseData['token'];
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'userId': _userId,
        'token': _token,
      });
      prefs.setString('userData', userData);
    } on TimeoutException catch (error) {
      throw error;
    } catch (error) {
      throw error;
    }
  }

  void logout() async {
    _token = null;
    _userId = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
