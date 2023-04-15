// ignore_for_file: constant_identifier_names

class ConnectionSQL {
  static const CREATE_USUARIO = '''
  CREATE TABLE Usuario (
  id TEXT NOT NULL,
  userName TEXT,
  municipio_id INTEGER,
  departamento_id INTEGER,
  password TEXT,
  token TEXT
  )''';

  static const CREATE_AFILIADO = '''
  CREATE TABLE [Afiliado] (
	[Afiliado_id]	integer NOT NULL,
	[SerialBDUA]	varchar(18) COLLATE NOCASE,
	[identificacion_id]	integer NOT NULL,
	[documento]	varchar(18) NOT NULL COLLATE NOCASE,
	[identificacion_cab_id]	integer,
	[documentocabeza]	varchar(18) COLLATE NOCASE,
	[apellido1]	varchar(50) COLLATE NOCASE,
	[apellido2]	varchar(50) COLLATE NOCASE,
	[nombre1]	varchar(50) NOT NULL COLLATE NOCASE,
	[nombre2]	varchar(50) COLLATE NOCASE,
	[fecnac]	datetime COLLATE NOCASE,
	[Genero_id]	integer,
	[Direccion]	varchar(200) COLLATE NOCASE,
	[Telefonofijo]	varchar(30) COLLATE NOCASE,
	[Telefonocel1]	varchar(20) COLLATE NOCASE,
	[Telefonocel2]	varchar(20) COLLATE NOCASE,
	[Municipio_ide]	integer,
	[Zona_ide]	integer,
	[fechafiliacion]	datetime COLLATE NOCASE,
	[tipopoblacion_id]	integer,
	[nivelsisben_id]	integer,
	[modalidad]	varchar(2) COLLATE NOCASE,
	[cod_integra]	varchar(15) COLLATE NOCASE,
	[IDE_PRESTADOR]	integer,
	[Tipocotizante_id]	integer,
	[TipoAfiliado_id]	integer,
	[parentesco_id]	integer,
	[Condicionbenf_id]	integer,
	[CiiuClase_id]	integer,
	[Cotizante_id]	integer,
	[Aportante_id]	integer,
	[Resguardo_id]	integer,
	[Observaciones]	varchar COLLATE NOCASE,
	[Estadoafiliacion_id]	integer,
	[Regimen_id]	integer,
	[fechaRetiro]	datetime COLLATE NOCASE,
	[discapacidad]	varchar(2) COLLATE NOCASE,
	[etnia]	varchar COLLATE NOCASE,
	[ips_portabilidad]	varchar(16) COLLATE NOCASE,
	[cod_sinfes]	varchar(50) COLLATE NOCASE,
	[codsiris]	varchar(15) COLLATE NOCASE,
	[Origenafiliacion_id]	integer,
	[eps_id]	integer,
	[IngresoPresuntivo]	numeric,
	[IBC]	numeric,
	[NivelCont_id]	integer,
	[TipoAfiliacion_id]	integer,
	[FMovilidad]	datetime COLLATE NOCASE,
	[OrigenEtnico5602_id]	integer,
	[Tipodiscapacidad5602_id]	integer,
	[Condicion5602_id]	integer,
	[puntajesisben]	numeric,
	[ARL_id]	integer,
	[AFP_id]	integer,
	[ArchivoProcesado_id]	integer,
	[BarrioVereda_ide]	integer,
	[IdR]	integer NOT NULL DEFAULT 0,
	[Mpio_EnteTerr]	integer,
	[CodDANE_EnteTerr]	varchar(5) COLLATE NOCASE,
	[FechaEfectividad_BDUA]	datetime COLLATE NOCASE,
	[ZonaIndigena_id]	integer,
	[ComunidadIndigena_id]	integer,
	[EtniaIndigena_id]	integer,
	[Comuna_id]	integer,
	[Email]	varchar(80) COLLATE NOCASE,
	[VictimaConflictoArmado]	integer,
	[Latitud]	varchar(30) COLLATE NOCASE,
	[Longitud]	varchar(30) COLLATE NOCASE,
	[CaducidadSC]	datetime COLLATE NOCASE,
	[Decreto_id]	integer,
	[EstadoDecreto_id]	integer,
	[GruposSisben_Id]	integer,
	[NivelGrupo]	integer,
	[ContribucionSolidaria]	integer,
	[FechaAceptaContribucion]	datetime COLLATE NOCASE,
	[OrientacionGenero_id]	integer
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
