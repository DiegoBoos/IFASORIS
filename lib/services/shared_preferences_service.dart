import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instancia =
      SharedPreferencesService._internal();

  factory SharedPreferencesService() {
    return _instancia;
  }

  SharedPreferencesService._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GET & SET  token
  String get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  getJson(String key) {
    String jsonString = _prefs.getString(key) ?? '{}';
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    return jsonMap;
  }

  setJson(String key, value) {
    String jsonString = jsonEncode(value);
    _prefs.setString(key, jsonString);
  }

  delete(String key) {
    _prefs.remove(key);
  }

  clearStorage() {
    _prefs.clear();
  }
}
