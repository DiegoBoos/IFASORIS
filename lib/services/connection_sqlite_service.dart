// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'sql.dart';

class ConnectionSQLiteService {
  ConnectionSQLiteService._();

  static ConnectionSQLiteService? _instance;

  static ConnectionSQLiteService get instance {
    _instance ??= ConnectionSQLiteService._();
    return _instance!;
  }

  static const DATABASE_NAME = 'ifasoris';
  static const DATABASE_VERSION = 1;
  static Database? _db;

  static Future<Database> get db => openDatabase();

  static Future<Database> openDatabase() async {
    String path = "";
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      String databasePath = await databaseFactoryFfi.getDatabasesPath();
      path = join(databasePath, DATABASE_NAME);
      print('Ruta base escritorio: $path');

      DatabaseFactory databaseFactory = databaseFactoryFfi;

      _db ??= await databaseFactory.openDatabase(path,
          options: OpenDatabaseOptions(
            onCreate: _onCreate,
            version: DATABASE_VERSION,
          ));
    } else {
      //Path donde se almacena la base de datos
      Directory documentDirectory = await getApplicationDocumentsDirectory();

      path = join(documentDirectory.path, 'paap.db');
      print('Ruta base móvil: $path');

      _db ??= await databaseFactory.openDatabase(path,
          options: OpenDatabaseOptions(
            onCreate: _onCreate,
            version: DATABASE_VERSION,
          ));
    }

    return _db!;
  }

  static FutureOr<void> _onCreate(Database db, int version) {
    db.transaction((reference) async {
      reference.execute(ConnectionSQL.CREATE_USUARIO);
      reference.execute(ConnectionSQL.CREATE_AFILIADO);
      reference.execute(ConnectionSQL.CREATE_DIFICULTAD_ACCESO_CA);
      reference.execute(ConnectionSQL.CREATE_ESTADO_VIA);
      reference.execute(ConnectionSQL.CREATE_MEDIO_COMUNICACION);
      reference.execute(ConnectionSQL.CREATE_MEDIO_UTILIZA_CA);
      reference.execute(ConnectionSQL.CREATE_TIEMPO_TARDA_CA);
      reference.execute(ConnectionSQL.CREATE_VIA_ACCESO);
    });
  }

  static Future<int> truncateTable(String table) async {
    var dbClient = await db;
    return await dbClient.delete(table);
  }
}
