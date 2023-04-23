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

  get(String key) async {
    return json.decode(_prefs.getString(key)!);
  }

  set(String key, value) async {
    _prefs.setString(key, json.encode(value));
  }

  delete(String key) async {
    _prefs.remove(key);
  }

  clearStorage() {
    _prefs.clear();
  }
}
