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
	[IPSPrimaria_Afiliado]	varchar COLLATE NOCASE,
	[Familia_id]	integer
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

  static const CREATE_FICHA = '''
  CREATE TABLE [Ficha] (
	[Ficha_id]	integer PRIMARY KEY AUTOINCREMENT,
	[FechaCreacion]	datetime NOT NULL,
	[NumFicha]	varchar(30) NOT NULL COLLATE NOCASE,
	[UserName]	varchar(20) NOT NULL COLLATE NOCASE,
	[UltimaActualizacion]	datetime NOT NULL
  )''';

  static const CREATE_FAMILIA = '''
  CREATE TABLE [Familia] (
	[Familia_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Ficha_id]	integer NOT NULL,
	[ApellidosFlia]	varchar(150) NOT NULL COLLATE NOCASE,
	[Afiliado_id]	integer NOT NULL
  )''';

  static const CREATE_UBICACION = '''
  CREATE TABLE [Asp1_Ubicacion] (
	[Ubicacion_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Familia_id]	integer NOT NULL,
	[NombreRecibeVisita]	varchar(150) NOT NULL COLLATE NOCASE,
	[TipoDoc_RecibeVisita]	varchar(2) NOT NULL COLLATE NOCASE,
	[Documento_RecibeVisita]	varchar(15) NOT NULL COLLATE NOCASE,
	[PerteneceResguardo]	integer NOT NULL,
	[ViaAcceso_id]	integer NOT NULL,
	[Resguardo_id]	integer NOT NULL,
	[AutoridadIndigena_id]	integer NOT NULL,
	[EstadoVia_id]	integer NOT NULL,
	[MediosComunicacion_ids]	TEXT,
	[TiempoTarda_id]	integer NOT NULL,
	[MediosUtiliza_ids]	TEXT,
	[DificultadesAcceso_ids]	TEXT,
	[CostoDesplazamiento_id]	integer NOT NULL,
	[ExisteMedTradicionalComunidad]	integer NOT NULL,
	[EspecialidadesMedTrad_ids]	TEXT,
	[TiempoTardaMedTrad_id]	integer,
	[MediosUtilizaMedTrad_ids]	TEXT,
	[DificultadesAccesoMedTrad_ids]	TEXT,
	[CostoDesplazamiento_MedTradicional]	integer,
	[nombresMedTradicional]	TEXT,
	[PoseeChagra]	integer NOT NULL,
	[TuberculosPlatanos_ids]	TEXT,
	[Leguminosas_ids]	TEXT,
	[Hortalizas_ids]	TEXT,
	[Verduras_ids]	TEXT,
	[Frutos_ids]	TEXT,
	[Cereales_ids]	TEXT,
	[EspeciesAnimalesCria_ids]	TEXT,
	[ProduccionMinera]	integer NOT NULL,
	[TiposCalendarios_ids]	TEXT,
    FOREIGN KEY ([AutoridadIndigena_id])
        REFERENCES [AutoridadesIndigenas_DatosVivienda]([AutoridadIndigena_id]),
    FOREIGN KEY ([CostoDesplazamiento_id])
        REFERENCES [CostosDesplazamiento_CentroAtencion]([CostoDesplazamiento_id]),
    FOREIGN KEY ([EstadoVia_id])
        REFERENCES [EstadoVias]([EstadoVia_id]),
    FOREIGN KEY ([Familia_id])
        REFERENCES [Familia]([Familia_id]),
    FOREIGN KEY ([PerteneceResguardo])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([ExisteMedTradicionalComunidad])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([PoseeChagra])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([ProduccionMinera])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([TiempoTarda_id])
        REFERENCES [TiemposTarda_CentroAtencion]([TiempoTarda_id]),
    FOREIGN KEY ([Ubicacion_id])
        REFERENCES [Asp1_Ubicacion]([Ubicacion_id]),
    FOREIGN KEY ([ViaAcceso_id])
        REFERENCES [ViasAcceso]([ViaAcceso_id])
  )''';

  static const CREATE_DATOS_VIVIENDA = '''
  CREATE TABLE [Asp2_DatosVivienda] (
	[DatoVivienda_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Familia_id]	integer NOT NULL,
	[TipoVivienda_id]	integer NOT NULL,
	[NumeroDormitorios]	integer,
	[TenenciaVivienda_id]	integer NOT NULL,
	[PisosVivienda_ids]	TEXT NOT NULL,
	[OtroTipoPiso]	varchar(50) COLLATE NOCASE,
	[TechosVivienda_ids]	TEXT NOT NULL,
	[OtroTipoTecho]	varchar(50) COLLATE NOCASE,
	[VentilacionVivienda_id]	integer NOT NULL,
	[IluminacionVivienda_id]	integer NOT NULL,
	[ServiciosPublicosVivienda_ids]	TEXT NOT NULL,
	[TratamientosAguaVivienda_ids]	TEXT NOT NULL,
	[TiposSanitarioVivienda_ids]	TEXT NOT NULL,
	[OtroTipoSanitario]	varchar(50) COLLATE NOCASE,
	[TiposCombustibleVivienda_ids]	TEXT NOT NULL,
	[OtroTipoCombustible]	varchar(50) COLLATE NOCASE,
	[FactoresRiesgoVivienda_ids]	TEXT NOT NULL,
	[PresenciaAnimalesVivienda_ids]	TEXT NOT NULL,
	[OtroPresenciaAnimal]	varchar(50) COLLATE NOCASE,
    FOREIGN KEY ([Familia_id])
        REFERENCES [Familia]([Familia_id]),
    FOREIGN KEY ([IluminacionVivienda_id])
        REFERENCES [IluminacionVivienda_DatosVivienda]([IluminacionVivienda_id]),
    FOREIGN KEY ([TenenciaVivienda_id])
        REFERENCES [TenenciasVivienda_DatosVivienda]([TenenciaVivienda_id]),
    FOREIGN KEY ([TipoVivienda_id])
        REFERENCES [TiposVivienda_DatosVivienda]([TipoVivienda_id]),
    FOREIGN KEY ([VentilacionVivienda_id])
        REFERENCES [VentilacionVivienda_DatosVivienda]([VentilacionVivienda_id])
  )''';

  static const CREATE_GRUPO_FAMILIAR = '''
  CREATE TABLE [Asp3_GrupoFamiliar] (
	[GrupoFamiliar_id]	integer NOT NULL,
	[Familia_id]	integer NOT NULL,
	[Afiliado_id]	integer NOT NULL,
	[CursoVida_id]	integer NOT NULL,
	[NivelEducativo_id]	integer NOT NULL,
	[Ocupacion_id]	integer NOT NULL,
	[GrupoRiesgo_id]	integer NOT NULL,
	[OrigenEtnico5602_id]	integer NOT NULL,
	[PuebloIndigena_id]	integer NOT NULL,
	[LenguaManeja_id]	integer NOT NULL,
	[LenguaMaterna_id]	integer NOT NULL,
    FOREIGN KEY ([CursoVida_id])
        REFERENCES [CursoVida_GrupoFamiliar]([CursoVida_id]),
    FOREIGN KEY ([Familia_id])
        REFERENCES [Familia]([Familia_id]),
    FOREIGN KEY ([GrupoRiesgo_id])
        REFERENCES [GrupoRiesgo_GrupoFamiliar]([GrupoRiesgo_id]),
    FOREIGN KEY ([LenguaManeja_id])
        REFERENCES [LenguaManeja_GrupoFamiliar]([LenguaManeja_id]),
    FOREIGN KEY ([NivelEducativo_id])
        REFERENCES [NivelEductativo_GrupoFamiliar]([NivelEducativo_id]),
    FOREIGN KEY ([LenguaMaterna_id])
        REFERENCES [NombreLenguaMaterna_GrupoFamiliar]([LenguaMaterna_id]),
    FOREIGN KEY ([Ocupacion_id])
        REFERENCES [Ocupacion_GrupoFamiliar]([Ocupacion_id]),
    FOREIGN KEY ([PuebloIndigena_id])
        REFERENCES [PueblosIndigenas_GrupoFamiliar]([PuebloIndigena_id])
  )''';

  static const CREATE_FACTORES_RIESGO_VIVIENDA = '''
  CREATE TABLE [FactoresRiesgoVivienda_DatosVivienda] (
  [FactorRiesgoVivienda_id]	integer NOT NULL,
  [Descripcion]	varchar(60) NOT NULL COLLATE NOCASE,
  [Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_ILUMINACION_VIVIENDA = '''
  CREATE TABLE [IluminacionVivienda_DatosVivienda] (
  [IluminacionVivienda_id]	integer NOT NULL,
  [Descripcion]	varchar(10) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_PISOS_VIVIENDA = '''
  CREATE TABLE [PisosVivienda_DatosVivienda] (
  [PisoVivienda_id]	integer NOT NULL,
  [Descripcion]	varchar(40) NOT NULL COLLATE NOCASE,
  [Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_PRESENCIA_ANIMALES_VIVIENDA = '''
  CREATE TABLE [PresenciaAnimalesVivienda_DatosVivienda] (
	[PresenciaAnimalVivienda_id]	integer NOT NULL,
	[Descripcion]	varchar(10) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_SERVICIOS_PUBLICOS_VIVIENDA = '''
  CREATE TABLE [ServiciosPublicosVivienda_DatosVivienda] (
  [ServicioPublicoVivienda_id]	integer NOT NULL,
  [Descripcion]	varchar(20) NOT NULL COLLATE NOCASE,
  [Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_TECHOS_VIVIENDA = '''
  CREATE TABLE [TechosVivienda_DatosVivienda] (
  [TechoVivienda_id]	integer NOT NULL,
  [Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
  [Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_TIPOS_VIVIENDA = '''
  CREATE TABLE [TiposVivienda_DatosVivienda] (
	[TipoVivienda_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_TENENCIAS_VIVIENDA = '''
  CREATE TABLE [TenenciasVivienda_DatosVivienda] (
	[TenenciaVivienda_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_TIPO_COMBUSTIBLE_VIVIENDA = '''
  CREATE TABLE [TiposCombustibleVivienda_DatosVivienda] (
	[TipoCombustibleVivienda_id]	integer NOT NULL,
	[Descripcion]	varchar(20) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_TIPO_SANITARIO_VIVIENDA = '''
  CREATE TABLE [TiposSanitarioVivienda_DatosVivienda] (
	[TipoSanitarioVivienda_id]	integer NOT NULL,
	[Descripcion]	varchar(20) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_TRATAMIENTO_AGUA_VIVIENDA = '''
  CREATE TABLE [TratamientoAguaVivienda_DatosVivienda] (
	[TratamientoAguaVivienda_id]	integer NOT NULL,
	[Descripcion]	varchar(20) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_VENTILACION_VIVIENDA = '''
  CREATE TABLE [VentilacionVivienda_DatosVivienda] (
	[VentilacionVivienda_id]	integer NOT NULL,
	[Descripcion]	varchar(10) NOT NULL COLLATE NOCASE
  )''';
}
