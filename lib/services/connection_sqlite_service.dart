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

      path = join(documentDirectory.path, 'ifasoris.db');
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
    db.transaction((ref) async {
      ref.execute(ConnectionSQL.CREATE_USUARIO);
      ref.execute(ConnectionSQL.CREATE_ACTIVIDADES_FISICAS);
      ref.execute(ConnectionSQL.CREATE_AFILIADO);
      ref.execute(ConnectionSQL.CREATE_ALIMENTACION);
      ref.execute(ConnectionSQL.CREATE_UBICACION);
      ref.execute(ConnectionSQL.CREATE_UBICACION_ACCESO_MED_TRADICIONAL);
      ref.execute(ConnectionSQL.CREATE_UBICACION_CEREALES);
      ref.execute(ConnectionSQL.CREATE_UBICACION_DIFICULTAD_ACCESO);
      ref.execute(ConnectionSQL.CREATE_UBICACION_ESPECIALIDAD_MED_TRADICIONAL);
      ref.execute(ConnectionSQL.CREATE_UBICACION_ESPECIE_ANIMALES_CRIA);
      ref.execute(ConnectionSQL.CREATE_UBICACION_FRUTOS);
      ref.execute(ConnectionSQL.CREATE_UBICACION_HORTALIZAS);
      ref.execute(ConnectionSQL.CREATE_UBICACION_LEGUMINOSAS);
      ref.execute(ConnectionSQL.CREATE_UBICACION_MEDIOS_COMUNICACION);
      ref.execute(ConnectionSQL.CREATE_UBICACION_MEDIOS_MED_TRADICIONAL);
      ref.execute(ConnectionSQL.CREATE_UBICACION_NOMBRES_MED_TRADICIONAL);
      ref.execute(ConnectionSQL.CREATE_UBICACION_TUBERCULOS_PLATANOS);
      ref.execute(ConnectionSQL.CREATE_UBICACION_VERDURAS);
      ref.execute(ConnectionSQL.CREATE_DATOS_VIVIENDA);
      ref.execute(ConnectionSQL.CREATE_DATOS_VIVIENDA_FACTORES_RIESGO);
      ref.execute(ConnectionSQL.CREATE_DATOS_VIVIENDA_PRESENCIA_ANIMALES);
      ref.execute(ConnectionSQL.CREATE_DATOS_VIVIENDA_SERVICIOS_PUBLICOS);
      ref.execute(ConnectionSQL.CREATE_DATOS_VIVIENDA_TECHOS);
      ref.execute(ConnectionSQL.CREATE_DATOS_VIVIENDA_TIPOS_COMBUSTIBLE);
      ref.execute(ConnectionSQL.CREATE_DATOS_VIVIENDA_TIPOS_SANITARIO);
      ref.execute(ConnectionSQL.CREATE_DATOS_VIVIENDA_TRATAMIENTOS_AGUA);
      ref.execute(ConnectionSQL.CREATE_GRUPO_FAMILIAR);
      ref.execute(ConnectionSQL.CREATE_ESTILOS_VIDA_SALUDABLE);
      ref.execute(ConnectionSQL.CREATE_CUIDADO_SALUD_COND_RIESGO);
      ref.execute(
          ConnectionSQL.CREATE_CUIDADO_SALUD_COND_RIESGO_NOMBRES_ENFERMEDAD);
      ref.execute(
          ConnectionSQL.CREATE_CUIDADO_SALUD_COND_RIESGO_SERVICIOS_SOLICITADOS);
      ref.execute(ConnectionSQL.CREATE_DIM_SOCIO_CULTURAL_PUEBLOS_INDIGENAS);
      ref.execute(
          ConnectionSQL.CREATE_DIM_SOCIO_CULTURAL_EVENTOS_COSTUMBRES_PARTICIPO);
      ref.execute(ConnectionSQL.CREATE_ATENCION_SALUD);
      ref.execute(
          ConnectionSQL.CREATE_ENFERMEDADES_TRADICIONALES_ATENCION_SALUD);
      ref.execute(ConnectionSQL.CREATE_ESPECIALIDADES_MED_TRAD_ATENCION_SALUD);
      ref.execute(ConnectionSQL.CREATE_LUGARES_ATENCION_ATENCION_SALUD);
      ref.execute(ConnectionSQL.CREATE_PLANTAS_MEDICINALES_ATENCION_SALUD);
      ref.execute(ConnectionSQL.CREATE_AUTORIDADES_INDIGENAS);
      ref.execute(ConnectionSQL.CREATE_CEREALES);
      ref.execute(ConnectionSQL.CREATE_CONDICIONES_NUTRICIONALES);
      ref.execute(ConnectionSQL.CREATE_CONDUCTAS_SEGUIR);
      ref.execute(ConnectionSQL.CREATE_COSTOS_DESPLAZAMIENTO_CENTRO_ATENCION);
      ref.execute(ConnectionSQL.CREATE_COSTUMBRES_PRACTICAN);
      ref.execute(ConnectionSQL.CREATE_DIFICULTADES_ACCESO_MED_TRADICIONAL);
      ref.execute(ConnectionSQL.CREATE_DIFICULTADES_ACCESO_CENTRO_ATENCION);
      ref.execute(ConnectionSQL.CREATE_ENFERMEDADES_ACUDE);
      ref.execute(ConnectionSQL.CREATE_ENFERMEDADES_TRADICIONALES);
      ref.execute(ConnectionSQL.CREATE_ENFERMEDADES_TRATAMIENTOS);
      ref.execute(ConnectionSQL.CREATE_ESPECIALIDADES_MED_TRADICIONAL);
      ref.execute(ConnectionSQL.CREATE_ESPECIES_ANIMALES);
      ref.execute(ConnectionSQL.CREATE_ESQUEMAS_VACUNACION);
      ref.execute(ConnectionSQL.CREATE_ESTADOS_VIAS);
      ref.execute(ConnectionSQL.CREATE_EVENTOS_COSTUMBRES_PARTICIPO);
      ref.execute(ConnectionSQL.CREATE_FACTORES_RIESGO_VIVIENDA);
      ref.execute(ConnectionSQL.CREATE_FAMILIA);
      ref.execute(ConnectionSQL.CREATE_FICHA);
      ref.execute(ConnectionSQL.CREATE_FRUTOS);
      ref.execute(ConnectionSQL.CREATE_HORTALIZAS);
      ref.execute(ConnectionSQL.CREATE_ILUMINACION_VIVIENDA);
      ref.execute(ConnectionSQL.CREATE_LEGUMINOSAS);
      ref.execute(ConnectionSQL.CREATE_LUGARES_ATENCION_MEDICO);
      ref.execute(ConnectionSQL.CREATE_LUGARES_PLANTAS_MEDICINALES);
      ref.execute(ConnectionSQL.CREATE_LUGARES_VACUNACION);
      ref.execute(ConnectionSQL.CREATE_MEDIOS_COMUNICACION);
      ref.execute(ConnectionSQL.CREATE_MEDIOS_UTILIZA_MED_TRADICIONAL);
      ref.execute(ConnectionSQL.CREATE_MEDIOS_UTILIZA_CENTRO_ATENCION);
      ref.execute(ConnectionSQL.CREATE_METODOS_PLANIFICACION);
      ref.execute(ConnectionSQL.CREATE_NOMBRES_ENFERMEDAD);
      ref.execute(ConnectionSQL.CREATE_NUMERO_CIGARRILLOS_DIA);
      ref.execute(ConnectionSQL.CREATE_CONSUMO_ALCOHOL);
      ref.execute(ConnectionSQL.CREATE_OPCIONES_SI_NO);
      ref.execute(ConnectionSQL.CREATE_ORIGEN_ETNICO_5602);
      ref.execute(ConnectionSQL.CREATE_PISOS_VIVIENDA);
      ref.execute(ConnectionSQL.CREATE_PLANTAS_MEDICINALES);
      ref.execute(ConnectionSQL.CREATE_PRESENCIA_ANIMALES_VIVIENDA);
      ref.execute(ConnectionSQL.CREATE_RELIGIONES_PROFESA);
      ref.execute(ConnectionSQL.CREATE_RESGUARDOS);
      ref.execute(ConnectionSQL.CREATE_SANCIONES_JUSTICIA);
      ref.execute(ConnectionSQL.CREATE_SEGUIMIENTO_ENFERMEDADES);
      ref.execute(ConnectionSQL.CREATE_SERVICIOS_PUBLICOS_VIVIENDA);
      ref.execute(ConnectionSQL.CREATE_SERVICIOS_SOLICITADOS);
      ref.execute(ConnectionSQL.CREATE_TECHOS_VIVIENDA);
      ref.execute(ConnectionSQL.CREATE_TENENCIAS_VIVIENDA);
      ref.execute(ConnectionSQL.CREATE_TIEMPOS_TARDA_MED_TRADICIONAL);
      ref.execute(ConnectionSQL.CREATE_TIEMPOS_TARDA_CENTRO_ATENCION);
      ref.execute(ConnectionSQL.CREATE_TIPOS_CALENDARIOS);
      ref.execute(ConnectionSQL.CREATE_TIPO_COMBUSTIBLE_VIVIENDA);
      ref.execute(ConnectionSQL.CREATE_TIPO_SANITARIO_VIVIENDA);
      ref.execute(ConnectionSQL.CREATE_TIPOS_VIVIENDA);
      ref.execute(ConnectionSQL.CREATE_TRATAMIENTO_AGUA_VIVIENDA);
      ref.execute(ConnectionSQL.CREATE_TUBERCULOS_PLATANOS);
      ref.execute(ConnectionSQL.CREATE_ULTIMA_VEZ_INST_SALUD);
      ref.execute(ConnectionSQL.CREATE_VENTILACION_VIVIENDA);
      ref.execute(ConnectionSQL.CREATE_VERDURAS);
      ref.execute(ConnectionSQL.CREATE_VIAS_ACCESO);
      ref.execute(ConnectionSQL.CREATE_CURSO_VIDA);
      ref.execute(ConnectionSQL.CREATE_ETNIA);
      ref.execute(ConnectionSQL.CREATE_GENERO);
      ref.execute(ConnectionSQL.CREATE_GRUPO_RIESGO);
      ref.execute(ConnectionSQL.CREATE_LENGUA_MANEJA);
      ref.execute(ConnectionSQL.CREATE_NIVEL_EDUCATIVO);
      ref.execute(ConnectionSQL.CREATE_NOMBRE_LENGUA_MATERNA);
      ref.execute(ConnectionSQL.CREATE_OCUPACION);
      ref.execute(ConnectionSQL.CREATE_PARENTESCO);
      ref.execute(ConnectionSQL.CREATE_PUEBLOS_INDIGENAS);
      ref.execute(ConnectionSQL.CREATE_REGIMEN);
      ref.execute(ConnectionSQL.CREATE_TIPOS_DOCUMENTO);
    });
  }

  static Future<int> truncateTable(String table) async {
    var dbClient = await db;
    return await dbClient.delete(table);
  }

  static Future<bool> isTableEmpty(String tableName) async {
    var dbClient = await db;
    int? count = Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableName'));
    return count == 0;
  }
}
