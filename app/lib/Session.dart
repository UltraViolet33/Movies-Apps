import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  Map<String, String> headers = {};

  Future<Map> get(String url) async {
    var uri = Uri.parse(url);
    http.Response response = await http.get(uri, headers: headers);
    updateCookie(response);
    return json.decode(response.body);
  }

  Future post(String url, dynamic data) async {
    var uri = Uri.parse(url);
    http.Response response = await http.post(uri, body: data, headers: headers);
    updateCookie(response);
    return response;
    // return json.decode(response.body);
  }

  void updateCookie(http.Response response) async {
    var rawCookie = response.headers['set-cookie'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
      prefs.setString("cookie", headers['cookie']!);
    }
  }
}
