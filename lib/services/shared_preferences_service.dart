import 'dart:convert';
import 'package:ifasoris/domain/usecases/afiliado/afiliado_exports.dart';
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

  Future<bool> setJson(String key, value) {
    String jsonString = jsonEncode(value);
    return _prefs.setString(key, jsonString);
  }

  void saveAfiliadoToSharedPreferences(AfiliadoEntity afiliado) {
    final jsonData = afiliado.toJsonForSharedPreferences();
    _prefs.setString('afiliado', jsonEncode(jsonData));
  }

  Future<bool> delete(String key) async {
    return await _prefs.remove(key);
  }

  Future<bool> clearStorage() async {
    return await _prefs.clear();
  }
}
