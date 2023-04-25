// ignore_for_file: constant_identifier_names

class ConnectionSQL {
  static const CREATE_USUARIO = '''
  CREATE TABLE Usuario (
  id TEXT NOT NULL,
  userName TEXT,
  municipio_id INTEGER,
  departamento_id INTEGER,
  password TEXT
  )''';

  static const CREATE_AFILIADO = '''
  CREATE TABLE [Afiliado] (
	[Afiliado_id]	integer NOT NULL,
	[TipoDoc_Afiliado]	varchar(3) COLLATE NOCASE,
	[documento]	varchar(18) COLLATE NOCASE,
	[AfiliadoId_CabezaFamilia]	integer,
	[TipoDoc_CabezaFamilia]	varchar(3) COLLATE NOCASE,
	[documentocabeza]	varchar(18) COLLATE NOCASE,
	[apellido1]	varchar(50) COLLATE NOCASE,
	[apellido2]	varchar(50) COLLATE NOCASE,
	[nombre1]	varchar(50) COLLATE NOCASE,
	[nombre2]	varchar(50) COLLATE NOCASE,
	[fecnac]	datetime COLLATE NOCASE,
	[CodGenero_Afiliado]	varchar(2) COLLATE NOCASE,
	[Direccion]	varchar(200) COLLATE NOCASE,
	[Telefonofijo]	varchar(10) COLLATE NOCASE,
	[Telefonocel1]	varchar(10) COLLATE NOCASE,
	[Telefonocel2]	varchar(10) COLLATE NOCASE,
	[Departamento_Ide]	integer,
	[CodMpio_Afiliado]	varchar(4) COLLATE NOCASE,
	[NomMpio_Afiliado]	varchar(100) COLLATE NOCASE,
	[CodDpto_Afiliado]	varchar(4) COLLATE NOCASE,
	[NomDpto_Afiliado]	varchar(100) COLLATE NOCASE,
	[fechafiliacion]	datetime COLLATE NOCASE,
	[CodZona_Afiliado]	varchar(1) COLLATE NOCASE,
	[CodTipoPob_afiliado]	varchar(2) COLLATE NOCASE,
	[IPSPrimaria_Afiliado]	varchar COLLATE NOCASE
  )''';

  static const CREATE_DIFICULTADES_ACCESO_CENTRO_ATENCION = '''
  CREATE TABLE [DificultadesAcceso_CentroAtencion] (
	[DificultaAcceso_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_ESTADOS_VIAS = '''
  CREATE TABLE [EstadoVias] (
	[EstadoVia_id]	integer NOT NULL,
	[Descripcion]	varchar(15) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_MEDIOS_COMUNICACION = '''
  CREATE TABLE [MediosComunicacion] (
	[MedioComunicacion_id]	integer NOT NULL,
	[Descripcion]	varchar(150) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_MEDIOS_UTILIZA_CENTRO_ATENCION = '''
  CREATE TABLE [MediosUtiliza_CentroAtencion] (
	[MedioUtiliza_id]	integer NOT NULL,
	[Descripcion]	varchar(20) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_TIEMPOS_TARDA_CENTRO_ATENCION = '''
 CREATE TABLE [TiemposTarda_CentroAtencion] (
	[TiempoTarda_id]	integer NOT NULL,
	[Descripcion]	varchar(20) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_VIAS_ACCESO = '''
  CREATE TABLE [ViasAcceso] (
	[ViaAcceso_id]	integer NOT NULL,
	[Descripcion]	varchar(10) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_AUTORIDADES_INDIGENAS = '''
  CREATE TABLE [AutoridadesIndigenas_DatosVivienda] (
  [AutoridadIndigena_id]	integer NOT NULL,
  [Descripcion]	varchar(30) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_CEREALES = '''
  CREATE TABLE [Cereales_AspectosSocioEconomicos] (
	[Cereal_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_COSTOS_DESPLAZAMIENTO_CENTRO_ATENCION = '''
  CREATE TABLE [CostosDesplazamiento_CentroAtencion] (
	[CostoDesplazamiento_id]	integer NOT NULL,
	[Descripcion]	varchar(100) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_DIFICULTADES_ACCESO_MED_TRADICIONAL = '''
  CREATE TABLE [DificultadesAcceso_AccesoMedTradicional] (
	[DificultadAccesoMedTrad_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_ESPECIALIDADES_MED_TRADICIONAL = '''
  CREATE TABLE [EspecialidadesMedTrad_AccesoMedTradicional] (
	[EspecialidadMedTrad_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_ESPECIES_ANIMALES = '''
  CREATE TABLE [EspecieAnimalesCria_AspectosSocioEconomicos] (
	[EspecieAnimalCria_id]	integer NOT NULL,
	[Descripcion]	varchar(50) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_FRUTOS = '''
  CREATE TABLE [Frutos_AspectosSocioEconomicos] (
	[Fruto_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_HORTALIZAS = '''
  CREATE TABLE [Hortalizas_AspectosSocioEconomicos] (
	[Hortaliza_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_LEGUMINOSAS = '''
  CREATE TABLE [Leguminosas_AspectosSocioEconomicos] (
	[Leguminosa_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_MEDIOS_UTILIZA_MED_TRADICIONAL = '''
  CREATE TABLE [MediosUtiliza_AccesoMedTradicional] (
	[MedioUtilizaMedTrad_id]	integer NOT NULL,
	[Descripcion]	varchar(20) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_OPCIONES_SI_NO = '''
  CREATE TABLE [OpcionesSi_No] (
	[Opcion_id]	integer NOT NULL,
	[Descripcion]	varchar(3) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_RESGUARDOS = '''
  CREATE TABLE [Resguardos] (
	[Resguardo_id]	integer NOT NULL,
	[Departamento_Ide]	integer NOT NULL,
	[CodaneResguardo]	varchar(9) COLLATE NOCASE,
	[NombreResguardo]	varchar NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_TIEMPOS_TARDA_MED_TRADICIONAL = '''
  CREATE TABLE [TiemposTarda_AccesoMedTradicional] (
	[TiempoTardaMedTrad_id]	integer NOT NULL,
	[Descripcion]	varchar(20) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_TUBERCULOS_PLATANOS = '''
  CREATE TABLE [TuberculosPlatanos_AspectosSocioEconomicos] (
	[TuberculoPlatano_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_VERDURAS = '''
  CREATE TABLE [Verduras_AspectosSocioEconomicos] (
	[Verdura_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';
}
