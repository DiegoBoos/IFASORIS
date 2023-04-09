// ignore_for_file: constant_identifier_names

class ConnectionSQL {
  static const CREATE_USUARIO = '''
  CREATE TABLE IF NOT EXISTS Usuario (
      id TEXT,
      userName TEXT,
      municipio_id INTEGER,
      departamento_id INTEGER,
      password TEXT,
      token TEXT,
      PRIMARY KEY(id)
  )''';

  static const CREATE_AFILIADO = '''
  CREATE TABLE IF NOT EXISTS Afiliado (
      afiliado_id INTEGER,
      tipoDoc_Afiliado TEXT,
      documento TEXT,
      tipoDoc_CabezaFamilia TEXT,
      documentocabeza TEXT,
      apellido1 TEXT,
      apellido2 TEXT,
      nombre1 TEXT,
      nombre2 TEXT,
      fecnac DATE,
      codGenero_Afiliado TEXT,
      direccion TEXT,
      telefonofijo TEXT,
      telefonocel1 TEXT,
      telefonocel2 TEXT,
      departamento_Ide INTEGER,
      codMpio_Afiliado TEXT,
      nomMpio_Afiliado TEXT,
      codDpto_Afiliado TEXT,
      nomDpto_Afiliado TEXT,
      fechafiliacion DATE,
      codZona_Afiliado TEXT,
      codTipoPob_afiliado TEXT,
      ipsPrimaria_Afiliado TEXT
  )''';

  static const CREATE_DIFICULTAD_ACCESO_CA = '''
  CREATE TABLE IF NOT EXISTS DificultadAccesoCA (
      dificultaAcceso_id INTEGER,
      descripcion TEXT,
      departamento_Ide INTEGER,
      PRIMARY KEY(dificultaAcceso_id)
  )''';

  static const CREATE_ESTADO_VIA = '''
  CREATE TABLE IF NOT EXISTS EstadoVia (
      estadoVia_id INTEGER,
      descripcion TEXT,
      PRIMARY KEY(estadoVia_id)
  )''';

  static const CREATE_MEDIO_COMUNICACION = '''
  CREATE TABLE IF NOT EXISTS MedioComunicacion (
      medioComunicacion_id INTEGER,
      descripcion TEXT,
      PRIMARY KEY(medioComunicacion_id)
  )''';

  static const CREATE_MEDIO_UTILIZA_CA = '''
  CREATE TABLE IF NOT EXISTS MedioUtilizaCA (
      medioUtiliza_id INTEGER,
      descripcion TEXT,
      departamento_Ide TEXT,
      PRIMARY KEY(medioUtiliza_id)
  )''';

  static const CREATE_TIEMPO_TARDA_CA = '''
  CREATE TABLE IF NOT EXISTS TiempoTardaCA (
      tiempoTarda_id INTEGER,
      descripcion TEXT,
      PRIMARY KEY(tiempoTarda_id)
  )''';

  static const CREATE_VIA_ACCESO = '''
  CREATE TABLE IF NOT EXISTS ViaAcceso (
      viaAcceso_id INTEGER,
      descripcion TEXT,
      PRIMARY KEY(viaAcceso_id)
  )''';
}
