import 'package:ifasoris/services/connection_sqlite_service.dart';

class Constants {
  static const ifasorisBaseUrl = 'http://172.17.1.57:9098/api';

  static Future<String> getToken() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.rawQuery('SELECT token from Usuario');
    if (res.isEmpty) return '';
    return res.first.entries.first.value as String;
  }
}
