// ignore_for_file: constant_identifier_names

class ConnectionSQL {
  static const CREATE_USUARIO = '''
  CREATE TABLE Usuario (
  Id TEXT NOT NULL,
  UserName TEXT,
  Municipio_id INTEGER,
  Departamento_id INTEGER,
  Password TEXT
  )''';

  static const CREATE_ACTIVIDADES_FISICAS = '''
  CREATE TABLE [ActividadesFisicas_EstilosVidaSaludable] (
    [ActividadFisica_id]	integer NOT NULL,
    [Descripcion]	varchar(50) NOT NULL COLLATE NOCASE
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

  static const CREATE_ALIMENTACION = '''
  CREATE TABLE [Alimentacion_EstilosVidaSaludable] (
	[Alimentacion_id]	integer NOT NULL,
	[Descripcion]	varchar(60) NOT NULL COLLATE NOCASE
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
	[TiempoTarda_id]	integer NOT NULL,
	[MedioUtiliza_id]	integer NOT NULL,
	[CostoDesplazamiento_id]	integer NOT NULL,
	[ExisteMedTradicionalComunidad]	integer NOT NULL,
	[TiempoTardaMedTrad_id]	integer NOT NULL,
	[CostoDesplazamiento_MedTradicional]	numeric NOT NULL,
	[PoseeChagra]	integer NOT NULL,
	[ProduccionMinera]	integer NOT NULL,
	[TipoCalendario_id]	integer NOT NULL,
  [remoteUbicacionId]	integer,
    FOREIGN KEY ([Resguardo_id])
        REFERENCES [Resguardos]([Resguardo_id]),
    FOREIGN KEY ([AutoridadIndigena_id])
        REFERENCES [AutoridadesIndigenas_DatosVivienda]([AutoridadIndigena_id]),
    FOREIGN KEY ([CostoDesplazamiento_id])
        REFERENCES [CostosDesplazamiento_CentroAtencion]([CostoDesplazamiento_id]),
    FOREIGN KEY ([EstadoVia_id])
        REFERENCES [EstadoVias]([EstadoVia_id]),
    FOREIGN KEY ([Familia_id])
        REFERENCES [Familia]([Familia_id]),
    FOREIGN KEY ([MedioUtiliza_id])
        REFERENCES [MediosUtiliza_CentroAtencion]([MedioUtiliza_id]),
    FOREIGN KEY ([PerteneceResguardo])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([ExisteMedTradicionalComunidad])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([PoseeChagra])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([ProduccionMinera])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([TiempoTardaMedTrad_id])
        REFERENCES [TiemposTarda_AccesoMedTradicional]([TiempoTardaMedTrad_id]),
    FOREIGN KEY ([TiempoTarda_id])
        REFERENCES [TiemposTarda_CentroAtencion]([TiempoTarda_id]),
    FOREIGN KEY ([TipoCalendario_id])
        REFERENCES [TiposCalendarios_AspectosSocioEconomicos]([TipoCalendario_id]),
    FOREIGN KEY ([Ubicacion_id])
        REFERENCES [Asp1_Ubicacion]([Ubicacion_id]),
    FOREIGN KEY ([ViaAcceso_id])
        REFERENCES [ViasAcceso]([ViaAcceso_id])
  )''';

  static const CREATE_UBICACION_ACCESO_MED_TRADICIONAL = '''
  CREATE TABLE [Asp1_UbicacionAccesoMedTradicional] (
	[UbicacionAccesoMedTradicional_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Ubicacion_id]	integer NOT NULL,
	[DificultadAccesoMedTrad_id]	integer NOT NULL
  )''';

  static const CREATE_UBICACION_CEREALES = '''
  CREATE TABLE [Asp1_UbicacionCereales] (
	[UbicacionCereal_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Ubicacion_id]	integer NOT NULL,
	[Cereal_id]	integer NOT NULL
  )''';

  static const CREATE_UBICACION_DIFICULTAD_ACCESO = '''
  CREATE TABLE [Asp1_UbicacionDificultadAcceso] (
	[UbicacionDificultadAcceso_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Ubicacion_id]	integer NOT NULL,
	[DificultaAcceso_id]	integer NOT NULL
  )''';

  static const CREATE_UBICACION_ESPECIALIDAD_MED_TRADICIONAL = '''
  CREATE TABLE [Asp1_UbicacionEspecialidadMedTradicional] (
	[UbicacionEspMedTradicional_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Ubicacion_id]	integer NOT NULL,
	[EspecialidadMedTrad_id]	integer NOT NULL
  )''';

  static const CREATE_UBICACION_ESPECIE_ANIMALES_CRIA = '''
  CREATE TABLE [Asp1_UbicacionEspecieAnimalesCria] (
	[UbicacionEspecieAnimal_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Ubicacion_id]	integer NOT NULL,
	[EspecieAnimalCria_id]	integer NOT NULL
  )''';

  static const CREATE_UBICACION_FRUTOS = '''
  CREATE TABLE [Asp1_UbicacionFrutos] (
	[UbicacionFruto_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Ubicacion_id]	integer NOT NULL,
	[Fruto_id]	integer NOT NULL
  )''';

  static const CREATE_UBICACION_HORTALIZAS = '''
  CREATE TABLE [Asp1_UbicacionHortalizas] (
	[UbicacionHortaliza_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Ubicacion_id]	integer NOT NULL,
	[Hortaliza_id]	integer NOT NULL
  )''';

  static const CREATE_UBICACION_LEGUMINOSAS = '''
  CREATE TABLE [Asp1_UbicacionLeguminosas] (
	[UbicacionLeguminosa_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Ubicacion_id]	integer NOT NULL,
	[Leguminosa_id]	integer NOT NULL
  )''';

  static const CREATE_UBICACION_MEDIOS_COMUNICACION = '''
  CREATE TABLE [Asp1_UbicacionMediosComunicacion] (
	[UbicacionMedio_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Ubicacion_id]	integer NOT NULL,
	[MedioComunicacion_id]	integer NOT NULL
  )''';

  static const CREATE_UBICACION_MEDIOS_MED_TRADICIONAL = '''
  CREATE TABLE [Asp1_UbicacionMediosMedTradicional] (
	[UbicacionMediosMedTradicional_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Ubicacion_id]	integer NOT NULL,
	[MedioUtilizaMedTrad_id]	integer NOT NULL
  )''';

  static const CREATE_UBICACION_NOMBRES_MED_TRADICIONAL = '''
  CREATE TABLE [Asp1_UbicacionNombresMedTradicional] (
	[UbicacionNombreMedTradicional_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Ubicacion_id]	integer NOT NULL,
	[NombreMedTradicional]	varchar(500) COLLATE NOCASE
  )''';

  static const CREATE_UBICACION_TUBERCULOS_PLATANOS = '''
  CREATE TABLE [Asp1_UbicacionTuberculosPlatanos] (
	[UbicacionTuberculoPlatano_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Ubicacion_id]	integer NOT NULL,
	[TuberculoPlatano_id]	integer NOT NULL
  )''';

  static const CREATE_UBICACION_VERDURAS = '''
  CREATE TABLE [Asp1_UbicacionVerduras] (
	[UbicacionVerdura_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Ubicacion_id]	integer NOT NULL,
	[Verdura_id]	integer NOT NULL
  )''';

  static const CREATE_DATOS_VIVIENDA = '''
  CREATE TABLE [Asp2_DatosVivienda] (
	[DatoVivienda_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Familia_id]	integer NOT NULL,
	[TipoVivienda_id]	integer NOT NULL,
	[TenenciaVivienda_id]	integer NOT NULL,
	[PisoVivienda_id]	integer NOT NULL,
	[OtroTipoPiso]	varchar(50) COLLATE NOCASE,
	[VentilacionVivienda_id]	integer NOT NULL,
  [remoteViviendaId]	integer
  )''';

  static const CREATE_DATOS_VIVIENDA_FACTORES_RIESGO = '''
  CREATE TABLE [Asp2_DatosViviendaFactoresRiesgo] (
	[ViviendaFactorRiesgo_id]	integer PRIMARY KEY AUTOINCREMENT,
	[DatoVivienda_id]	integer NOT NULL,
	[FactorRiesgoVivienda_id]	integer NOT NULL
  )''';

  static const CREATE_DATOS_VIVIENDA_SERVICIOS_PUBLICOS = '''
  CREATE TABLE [Asp2_DatosViviendaServiciosPublicos] (
	[ViviendaServicioPublico_id]	integer PRIMARY KEY AUTOINCREMENT,
	[DatoVivienda_id]	integer NOT NULL,
	[ServicioPublicoVivienda_id]	integer NOT NULL
  )''';

  static const CREATE_DATOS_VIVIENDA_TECHOS = '''
  CREATE TABLE [Asp2_DatosViviendaTechos] (
	[ViviendaTecho_id]	integer PRIMARY KEY AUTOINCREMENT,
	[DatoVivienda_id]	integer NOT NULL,
	[TechoVivienda_id]	integer,
	[OtroTipoTecho]	varchar(150) COLLATE NOCASE
  )''';

  static const CREATE_DATOS_VIVIENDA_TIPOS_COMBUSTIBLE = '''
  CREATE TABLE [Asp2_DatosViviendaTiposCombustible] (
	[ViviendaTipoCombustible_id]	integer PRIMARY KEY AUTOINCREMENT,
	[DatoVivienda_id]	integer NOT NULL,
	[TipoCombustibleVivienda_id]	integer,
	[OtroTipoCombustible]	varchar(150) COLLATE NOCASE
  )''';

  static const CREATE_DATOS_VIVIENDA_TIPOS_SANITARIO = '''
  CREATE TABLE [Asp2_DatosViviendaTiposSanitario] (
	[ViviendaTipoSanitario_id]	integer PRIMARY KEY AUTOINCREMENT,
	[DatoVivienda_id]	integer NOT NULL,
	[TipoSanitarioVivienda_id]	integer,
	[OtroTipoSanitario]	varchar(150) COLLATE NOCASE
  )''';

  static const CREATE_DATOS_VIVIENDA_TRATAMIENTOS_AGUA = '''
  CREATE TABLE [Asp2_DatosViviendaTratamientosAgua] (
	[ViviendaTmtoAgua_id]	integer PRIMARY KEY AUTOINCREMENT,
	[DatoVivienda_id]	integer NOT NULL,
	[TratamientoAguaVivienda_id]	integer NOT NULL
  )''';

  static const CREATE_GRUPO_FAMILIAR = '''
  CREATE TABLE [Asp3_GrupoFamiliar] (
	[GrupoFamiliar_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Familia_id]	integer NOT NULL,
	[Afiliado_id]	integer NOT NULL,
	[CursoVida_id]	integer NOT NULL,
	[Parentesco_id]	integer NOT NULL,
	[TipoRegimen_id]	integer NOT NULL,
	[NivelEducativo_id]	integer NOT NULL,
	[Ocupacion_id]	integer NOT NULL,
	[GrupoRiesgo_id]	integer NOT NULL,
	[OrigenEtnico5602_id]	integer NOT NULL,
	[PuebloIndigena_id]	integer,
	[LenguaManeja_id]	integer,
	[LenguaMaterna_id]	integer,
	[remoteGrupoFamiliar_id]	integer,
    FOREIGN KEY ([Afiliado_id])
        REFERENCES [Afiliado]([Afiliado_id]),
    FOREIGN KEY ([OrigenEtnico5602_id])
        REFERENCES [OrigenEtnico5602]([OrigenEtnico5602_id]),
    FOREIGN KEY ([CursoVida_id])
        REFERENCES [CursoVida_GrupoFamiliar]([CursoVida_id]),
    FOREIGN KEY ([Parentesco_id])
        REFERENCES [Parentesco_GrupoFamiliar]([Parentesco_id]),
    FOREIGN KEY ([TipoRegimen_id])
        REFERENCES [Regimenes_GrupoFamiliar]([TipoRegimen_id]),
    FOREIGN KEY ([Familia_id])
        REFERENCES [Familia]([Familia_id]),
    FOREIGN KEY ([GrupoRiesgo_id])
        REFERENCES [GrupoRiesgo_GrupoFamiliar]([GrupoRiesgo_id]),
    FOREIGN KEY ([LenguaManeja_id])
        REFERENCES [LenguaManeja_GrupoFamiliar]([LenguaManeja_id]),
    FOREIGN KEY ([NivelEducativo_id])
        REFERENCES [NivelEducativo_GrupoFamiliar]([NivelEducativo_id]),
    FOREIGN KEY ([LenguaMaterna_id])
        REFERENCES [NombreLenguaMaterna_GrupoFamiliar]([LenguaMaterna_id]),
    FOREIGN KEY ([Ocupacion_id])
        REFERENCES [Ocupacion_GrupoFamiliar]([Ocupacion_id]),
    FOREIGN KEY ([PuebloIndigena_id])
        REFERENCES [PueblosIndigenas_GrupoFamiliar]([PuebloIndigena_id])
  )''';

  static const CREATE_ESTILOS_VIDA_SALUDABLE = '''
  CREATE TABLE [Asp4_EstilosVidaSaludable] (
	[EstilosVida_id]	integer NOT NULL,
	[Afiliado_id]	integer NOT NULL,
	[ActividadFisica_id]	integer NOT NULL,
	[Alimentacion_id]	integer NOT NULL,
	[ConsumeCigarrillo]	integer NOT NULL,
	[NumeroCigarrilloDia_id]	integer NOT NULL,
	[ConsumoSustanciasPsicoactivas]	integer NOT NULL,
    FOREIGN KEY ([ActividadFisica_id])
        REFERENCES [ActividadesFisicas_EstilosVidaSaludable]([ActividadFisica_id]),
    FOREIGN KEY ([Alimentacion_id])
        REFERENCES [Alimentacion_EstilosVidaSaludable]([Alimentacion_id]),
    FOREIGN KEY ([Afiliado_id])
        REFERENCES [Familia]([Familia_id]),
    FOREIGN KEY ([NumeroCigarrilloDia_id])
        REFERENCES [NumeroCigarrilosDia_EstilosVidaSaludable]([NumeroCigarrilloDia_id]),
    FOREIGN KEY ([ConsumeCigarrillo])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([ConsumoSustanciasPsicoactivas])
        REFERENCES [OpcionesSi_No]([Opcion_id])
  )''';

  static const CREATE_CUIDADO_SALUD_COND_RIESGO = '''
  CREATE TABLE [Asp5_CuidadoSaludCondRiesgo] (
	[DatoVivienda_id]	integer NOT NULL,
	[Afiliado_id]	integer NOT NULL,
	[UltimaVezInstSalud_id]	integer NOT NULL,
	[ServicioSolicitado_id]	integer NOT NULL,
	[DxEnfermedadPermanente_id]	integer NOT NULL,
	[NombreEnfermedad_id]	integer NOT NULL,
	[SeguimientoEnfermedad_id]	integer NOT NULL,
	[CondicionNutricional_id]	integer NOT NULL,
	[TosFlema_id]	integer NOT NULL,
	[ManchasPiel_id]	integer NOT NULL,
	[CarnetVacunacion_id]	integer NOT NULL,
	[EsquemaVacunacion_id]	integer NOT NULL,
	[LugarVacunacion_id]	integer NOT NULL,
	[UtilizaMetodoPlanificacion_id]	integer NOT NULL,
	[MetodoPlanificacion_id]	integer NOT NULL,
	[ConductaSeguir_id]	integer NOT NULL,
    FOREIGN KEY ([Afiliado_id])
        REFERENCES [Afiliado]([Afiliado_id]),
    FOREIGN KEY ([CondicionNutricional_id])
        REFERENCES [CondicionesNutricionales_CuidadoSaludCondRiesgo]([CondicionNutricional_id]),
    FOREIGN KEY ([ConductaSeguir_id])
        REFERENCES [ConductasSeguir_CuidadoSaludCondRiesgo]([ConductaSeguir_id]),
    FOREIGN KEY ([EsquemaVacunacion_id])
        REFERENCES [EsquemasVacunacion_CuidadoSaludCondRiesgo]([EsquemaVacunacion_id]),
    FOREIGN KEY ([LugarVacunacion_id])
        REFERENCES [LugaresVacunacion_CuidadoSaludCondRiesgo]([LugarVacunacion_id]),
    FOREIGN KEY ([MetodoPlanificacion_id])
        REFERENCES [MetodosPlanificacion_CuidadoSaludCondRiesgo]([MetodoPlanificacion_id]),
    FOREIGN KEY ([DxEnfermedadPermanente_id])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([TosFlema_id])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([ManchasPiel_id])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([CarnetVacunacion_id])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([UtilizaMetodoPlanificacion_id])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([SeguimientoEnfermedad_id])
        REFERENCES [SeguimientoEnfermedades_CuidadoSaludCondRiesgo]([SeguimientoEnfermedad_id]),
    FOREIGN KEY ([ServicioSolicitado_id])
        REFERENCES [ServiciosSolicitados_CuidadoSaludCondRiesgo]([ServicioSolicitado_id]),
    FOREIGN KEY ([UltimaVezInstSalud_id])
        REFERENCES [UltimaVezInstSalud_CuidadoSaludCondRiesgo]([UltimaVezInstSalud_id])
  )''';

  static const CREATE_DIM_SOCIO_CULTURAL_PUEBLOS_INDIGENAS = '''
  CREATE TABLE [Asp6_DimSocioCulturalPueblosIndigenas] (
	[DatoVivienda_id]	integer NOT NULL,
	[Afiliado_id]	integer NOT NULL,
	[ReligionProfesa_id]	integer NOT NULL,
	[ConoceUsosCostumbres_id]	integer NOT NULL,
	[Cuales_UsosCostumbres]	varchar(150) COLLATE NOCASE,
	[ParticipaCostumbres_id]	integer NOT NULL,
	[EventoCostumbreParticipo_id]	integer NOT NULL,
	[CostumbrePractica_id]	integer NOT NULL,
	[SancionJusticia_id]	integer NOT NULL,
	[SitiosSagrados_id]	integer NOT NULL,
	[Cuales_SitiosSagrados]	varchar(150) COLLATE NOCASE,
    FOREIGN KEY ([Afiliado_id])
        REFERENCES [Afiliado]([Afiliado_id]),
    FOREIGN KEY ([CostumbrePractica_id])
        REFERENCES [CostumbresPractican_DimSocioCulturalPueblosIndigenas]([CostumbrePractica_id]),
    FOREIGN KEY ([EventoCostumbreParticipo_id])
        REFERENCES [EventosCostumbresParticipo_DimSocioCulturalPueblosIndigenas]([EventoCostumbreParticipo_id]),
    FOREIGN KEY ([ConoceUsosCostumbres_id])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([ParticipaCostumbres_id])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([SitiosSagrados_id])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([ReligionProfesa_id])
        REFERENCES [ReligionesProfesa_DimSocioCulturalPueblosIndigenas]([ReligionProfesa_id]),
    FOREIGN KEY ([SancionJusticia_id])
        REFERENCES [SancionesJusticia_DimSocioCulturalPueblosIndigenas]([SancionJusticia_id])
  )''';

  static const CREATE_ATENCION_SALUD = '''
  CREATE TABLE [Asp7_AtencionSalud] (
	[DatoVivienda_id]	integer NOT NULL,
	[Afiliado_id]	integer NOT NULL,
	[EnfermedadAcude_id]	integer NOT NULL,
	[RecibioAtencionMedTradicional_id]	integer NOT NULL,
	[EspecialidadMedTrad_id]	integer NOT NULL,
	[EnfermedadTradicional_id]	integer NOT NULL,
	[LugarAtencionMedico_id]	integer NOT NULL,
	[EnfermedadTratamiento_id]	integer NOT NULL,
	[UtilizaPlantasMed_id]	integer NOT NULL,
	[LugarPlantaMedicinal_id]	integer NOT NULL,
	[PlantaMedicinal_id]	integer NOT NULL,
    FOREIGN KEY ([Afiliado_id])
        REFERENCES [Afiliado]([Afiliado_id]),
    FOREIGN KEY ([EnfermedadAcude_id])
        REFERENCES [EnfermedadesAcude_AtencionSalud]([EnfermedadAcude_id]),
    FOREIGN KEY ([EnfermedadTradicional_id])
        REFERENCES [EnfermedadesTradicionales_AtencionSalud]([EnfermedadTradicional_id]),
    FOREIGN KEY ([EnfermedadTratamiento_id])
        REFERENCES [EnfermedadesTratamientos_AtencionSalud]([EnfermedadTratamiento_id]),
    FOREIGN KEY ([EspecialidadMedTrad_id])
        REFERENCES [EspecialidadesMedTrad_AccesoMedTradicional]([EspecialidadMedTrad_id]),
    FOREIGN KEY ([LugarAtencionMedico_id])
        REFERENCES [LugaresAtencionMedico_AtencionSalud]([LugarAtencionMedico_id]),
    FOREIGN KEY ([LugarPlantaMedicinal_id])
        REFERENCES [LugaresPlantasMedicinales_AtencionSalud]([LugarPlantaMedicinal_id]),
    FOREIGN KEY ([RecibioAtencionMedTradicional_id])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([UtilizaPlantasMed_id])
        REFERENCES [OpcionesSi_No]([Opcion_id]),
    FOREIGN KEY ([PlantaMedicinal_id])
        REFERENCES [PlantasMedicinales_AtencionSalud]([PlantaMedicinal_id])
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

  static const CREATE_CONDICIONES_NUTRICIONALES = '''
  CREATE TABLE [CondicionesNutricionales_CuidadoSaludCondRiesgo] (
	[CondicionNutricional_id]	integer NOT NULL,
	[Descripcion]	varchar(50) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_CONDUCTAS_SEGUIR = '''
  CREATE TABLE [ConductasSeguir_CuidadoSaludCondRiesgo] (
	[ConductaSeguir_id]	integer NOT NULL,
	[Descripcion]	varchar(100) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_COSTOS_DESPLAZAMIENTO_CENTRO_ATENCION = '''
  CREATE TABLE [CostosDesplazamiento_CentroAtencion] (
	[CostoDesplazamiento_id]	integer NOT NULL,
	[Descripcion]	varchar(100) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_COSTUMBRES_PRACTICAN = '''
  CREATE TABLE [CostumbresPractican_DimSocioCulturalPueblosIndigenas] (
	[CostumbrePractica_id]	integer NOT NULL,
	[Descripcion]	varchar(150) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_CURSO_VIDA = '''
  CREATE TABLE [CursoVida_GrupoFamiliar] (
	[CursoVida_id]	integer NOT NULL,
	[Descripcion]	varchar(25) NOT NULL COLLATE NOCASE,
	[Rango]	varchar(15) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_DIFICULTADES_ACCESO_MED_TRADICIONAL = '''
  CREATE TABLE [DificultadesAcceso_AccesoMedTradicional] (
	[DificultadAccesoMedTrad_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_DIFICULTADES_ACCESO_CENTRO_ATENCION = '''
  CREATE TABLE [DificultadesAcceso_CentroAtencion] (
	[DificultaAcceso_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_ENFERMEDADES_ACUDE = '''
  CREATE TABLE [EnfermedadesAcude_AtencionSalud] (
	[EnfermedadAcude_id]	integer NOT NULL,
	[Descripcion]	varchar(100) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_ENFERMEDADES_TRADICIONALES = '''
  CREATE TABLE [EnfermedadesTradicionales_AtencionSalud] (
	[EnfermedadTradicional_id]	integer NOT NULL,
	[Descripcion]	varchar(550) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_ENFERMEDADES_TRATAMIENTOS = '''
  CREATE TABLE [EnfermedadesTratamientos_AtencionSalud] (
	[EnfermedadTratamiento_id]	integer NOT NULL,
	[Descripcion]	varchar(100) NOT NULL COLLATE NOCASE
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

  static const CREATE_ESQUEMAS_VACUNACION = '''
  CREATE TABLE [EsquemasVacunacion_CuidadoSaludCondRiesgo] (
	[EsquemaVacunacion_id]	integer NOT NULL,
	[Descripcion]	varchar(20) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_ESTADOS_VIAS = '''
  CREATE TABLE [EstadoVias] (
	[EstadoVia_id]	integer NOT NULL,
	[Descripcion]	varchar(15) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_EVENTOS_COSTUMBRES_PARTICIPO = '''
  CREATE TABLE [EventosCostumbresParticipo_DimSocioCulturalPueblosIndigenas] (
	[EventoCostumbreParticipo_id]	integer NOT NULL,
	[Descripcion]	varchar(100) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_FACTORES_RIESGO_VIVIENDA = '''
  CREATE TABLE [FactoresRiesgoVivienda_DatosVivienda] (
  [FactorRiesgoVivienda_id]	integer NOT NULL,
  [Descripcion]	varchar(60) NOT NULL COLLATE NOCASE,
  [Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_FAMILIA = '''
  CREATE TABLE [Familia] (
	[Familia_id]	integer PRIMARY KEY AUTOINCREMENT,
	[Ficha_id]	integer NOT NULL,
	[ApellidosFlia]	varchar(150) NOT NULL COLLATE NOCASE,
	[Afiliado_id]	integer NOT NULL,
  [remoteFamiliaId]	integer
  )''';

  static const CREATE_FICHA = '''
  CREATE TABLE [Ficha] (
	[Ficha_id]	integer PRIMARY KEY AUTOINCREMENT,
	[FechaCreacion]	datetime NOT NULL,
	[NumFicha]	varchar(30) NOT NULL COLLATE NOCASE,
	[UserName]	varchar(20) NOT NULL COLLATE NOCASE,
	[UltimaActualizacion]	datetime NOT NULL,
	[remoteFichaId]	integer
  )''';

  static const CREATE_FRUTOS = '''
  CREATE TABLE [Frutos_AspectosSocioEconomicos] (
	[Fruto_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_GRUPO_RIESGO = '''
  CREATE TABLE [GrupoRiesgo_GrupoFamiliar] (
	[GrupoRiesgo_id]	integer NOT NULL,
	[Descripcion]	varchar(150) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_HORTALIZAS = '''
  CREATE TABLE [Hortalizas_AspectosSocioEconomicos] (
	[Hortaliza_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_ILUMINACION_VIVIENDA = '''
  CREATE TABLE [IluminacionVivienda_DatosVivienda] (
  [IluminacionVivienda_id]	integer NOT NULL,
  [Descripcion]	varchar(10) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_LEGUMINOSAS = '''
  CREATE TABLE [Leguminosas_AspectosSocioEconomicos] (
	[Leguminosa_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_LENGUA_MANEJA = '''
  CREATE TABLE [LenguaManeja_GrupoFamiliar] (
	[LenguaManeja_id]	integer NOT NULL,
	[Descripcion]	varchar(150) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_LUGARES_ATENCION_MEDICO = '''
  CREATE TABLE [LugaresAtencionMedico_AtencionSalud] (
	[LugarAtencionMedico_id]	integer NOT NULL,
	[Descripcion]	varchar(100) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_LUGARES_PLANTAS_MEDICINALES = '''
  CREATE TABLE [LugaresPlantasMedicinales_AtencionSalud] (
	[LugarPlantaMedicinal_id]	integer NOT NULL,
	[Descripcion]	varchar(50) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_LUGARES_VACUNACION = '''
  CREATE TABLE [LugaresVacunacion_CuidadoSaludCondRiesgo] (
	[LugarVacunacion_id]	integer NOT NULL,
	[Descripcion]	varchar(50) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_MEDIOS_COMUNICACION = '''
  CREATE TABLE [MediosComunicacion] (
	[MedioComunicacion_id]	integer NOT NULL,
	[Descripcion]	varchar(150) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_MEDIOS_UTILIZA_MED_TRADICIONAL = '''
  CREATE TABLE [MediosUtiliza_AccesoMedTradicional] (
	[MedioUtilizaMedTrad_id]	integer NOT NULL,
	[Descripcion]	varchar(20) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_MEDIOS_UTILIZA_CENTRO_ATENCION = '''
  CREATE TABLE [MediosUtiliza_CentroAtencion] (
	[MedioUtiliza_id]	integer NOT NULL,
	[Descripcion]	varchar(20) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_METODOS_PLANIFICACION = '''
  CREATE TABLE [MetodosPlanificacion_CuidadoSaludCondRiesgo] (
	[MetodoPlanificacion_id]	integer NOT NULL,
	[Descripcion]	varchar(50) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_NIVEL_EDUCATIVO = '''
  CREATE TABLE [NivelEducativo_GrupoFamiliar] (
	[NivelEducativo_id]	integer NOT NULL,
	[Descripcion]	varchar(50) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_NOMBRE_LENGUA_MATERNA = '''
  CREATE TABLE [NombreLenguaMaterna_GrupoFamiliar] (
	[LenguaMaterna_id]	integer NOT NULL,
	[Descripcion]	varchar(150) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_NOMBRES_ENFERMEDAD = '''
  CREATE TABLE [NombresEnfermedad_CuidadoSaludCondRiesgo] (
	[NombreEnfermedad_id]	integer NOT NULL,
	[Descripcion]	varchar(150) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_NUMERO_CIGARRILLOS_DIA = '''
  CREATE TABLE [NumeroCigarrilosDia_EstilosVidaSaludable] (
	[NumeroCigarrilloDia_id]	integer NOT NULL,
	[Descripcion]	varchar(10) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_OCUPACION = '''
  CREATE TABLE [Ocupacion_GrupoFamiliar] (
	[Ocupacion_id]	integer NOT NULL,
	[Descripcion]	varchar(150) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_OPCIONES_SI_NO = '''
  CREATE TABLE [OpcionesSi_No] (
	[Opcion_id]	integer NOT NULL,
	[Descripcion]	varchar(3) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_ORIGEN_ETNICO_5602 = '''
  CREATE TABLE [OrigenEtnico5602] (
	[OrigenEtnico5602_id]	integer NOT NULL,
	[codigo]	varchar(2) NOT NULL COLLATE NOCASE,
	[descripcion]	varchar(250) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_PISOS_VIVIENDA = '''
  CREATE TABLE [PisosVivienda_DatosVivienda] (
  [PisoVivienda_id]	integer NOT NULL,
  [Descripcion]	varchar(40) NOT NULL COLLATE NOCASE,
  [Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_PLANTAS_MEDICINALES = '''
  CREATE TABLE [PlantasMedicinales_AtencionSalud] (
	[PlantaMedicinal_id]	integer NOT NULL,
	[Descripcion]	varchar(100) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_PRESENCIA_ANIMALES_VIVIENDA = '''
  CREATE TABLE [PresenciaAnimalesVivienda_DatosVivienda] (
	[PresenciaAnimalVivienda_id]	integer NOT NULL,
	[Descripcion]	varchar(10) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_DATOS_VIVIENDA_PRESENCIA_ANIMALES = '''
  CREATE TABLE [Asp2_DatosViviendaPresenciaAnimales] (
	[ViviendaPresenciaAnimal_id]	integer PRIMARY KEY AUTOINCREMENT,
	[DatoVivienda_id]	integer NOT NULL,
	[PresenciaAnimalVivienda_id]	integer,
	[OtroPresenciaAnimal]	varchar(150) COLLATE NOCASE
  )''';

  static const CREATE_PUEBLOS_INDIGENAS = '''
  CREATE TABLE [PueblosIndigenas_GrupoFamiliar] (
	[PuebloIndigena_id]	integer NOT NULL,
	[Descripcion]	varchar(150) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_RELIGIONES_PROFESA = '''
  CREATE TABLE [ReligionesProfesa_DimSocioCulturalPueblosIndigenas] (
	[ReligionProfesa_id]	integer NOT NULL,
	[Descripcion]	varchar(50) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_RESGUARDOS = '''
  CREATE TABLE [Resguardos] (
	[Resguardo_id]	integer NOT NULL,
	[Departamento_Ide]	integer NOT NULL,
	[Municipio_ide]	integer NOT NULL,
	[CodaneResguardo]	varchar(9) COLLATE NOCASE,
	[NombreResguardo]	varchar NOT NULL COLLATE NOCASE,
	[Tipoorganizacion_id]	integer NOT NULL,
	[PuebloIndigena_id]	integer
  )''';

  static const CREATE_SANCIONES_JUSTICIA = '''
  CREATE TABLE [SancionesJusticia_DimSocioCulturalPueblosIndigenas] (
	[SancionJusticia_id]	integer NOT NULL,
	[Descripcion]	varchar(50) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_SEGUIMIENTO_ENFERMEDADES = '''
  CREATE TABLE [SeguimientoEnfermedades_CuidadoSaludCondRiesgo] (
	[SeguimientoEnfermedad_id]	integer NOT NULL,
	[Descripcion]	varchar(150) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_SERVICIOS_PUBLICOS_VIVIENDA = '''
  CREATE TABLE [ServiciosPublicosVivienda_DatosVivienda] (
  [ServicioPublicoVivienda_id]	integer NOT NULL,
  [Descripcion]	varchar(20) NOT NULL COLLATE NOCASE,
  [Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_SERVICIOS_SOLICITADOS = '''
  CREATE TABLE [ServiciosSolicitados_CuidadoSaludCondRiesgo] (
	[ServicioSolicitado_id]	integer NOT NULL,
	[Descripcion]	varchar(50) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_TECHOS_VIVIENDA = '''
  CREATE TABLE [TechosVivienda_DatosVivienda] (
  [TechoVivienda_id]	integer NOT NULL,
  [Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
  [Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_TENENCIAS_VIVIENDA = '''
  CREATE TABLE [TenenciasVivienda_DatosVivienda] (
	[TenenciaVivienda_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_TIEMPOS_TARDA_MED_TRADICIONAL = '''
  CREATE TABLE [TiemposTarda_AccesoMedTradicional] (
	[TiempoTardaMedTrad_id]	integer NOT NULL,
	[Descripcion]	varchar(20) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_TIEMPOS_TARDA_CENTRO_ATENCION = '''
  CREATE TABLE [TiemposTarda_CentroAtencion] (
	[TiempoTarda_id]	integer NOT NULL,
	[Descripcion]	varchar(20) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_TIPOS_CALENDARIOS = '''
  CREATE TABLE [TiposCalendarios_AspectosSocioEconomicos] (
	[TipoCalendario_id]	integer NOT NULL,
	[Descripcion]	varchar(50) NOT NULL COLLATE NOCASE
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

  static const CREATE_TIPOS_VIVIENDA = '''
  CREATE TABLE [TiposVivienda_DatosVivienda] (
	[TipoVivienda_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_TRATAMIENTO_AGUA_VIVIENDA = '''
  CREATE TABLE [TratamientoAguaVivienda_DatosVivienda] (
	[TratamientoAguaVivienda_id]	integer NOT NULL,
	[Descripcion]	varchar(20) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer NOT NULL
  )''';

  static const CREATE_TUBERCULOS_PLATANOS = '''
  CREATE TABLE [TuberculosPlatanos_AspectosSocioEconomicos] (
	[TuberculoPlatano_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_ULTIMA_VEZ_INST_SALUD = '''
  CREATE TABLE [UltimaVezInstSalud_CuidadoSaludCondRiesgo] (
	[UltimaVezInstSalud_id]	integer NOT NULL,
	[Descripcion]	varchar(50) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_VENTILACION_VIVIENDA = '''
  CREATE TABLE [VentilacionVivienda_DatosVivienda] (
	[VentilacionVivienda_id]	integer NOT NULL,
	[Descripcion]	varchar(10) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_VERDURAS = '''
  CREATE TABLE [Verduras_AspectosSocioEconomicos] (
	[Verdura_id]	integer NOT NULL,
	[Descripcion]	varchar(30) NOT NULL COLLATE NOCASE,
	[Departamento_Ide]	integer
  )''';

  static const CREATE_VIAS_ACCESO = '''
  CREATE TABLE [ViasAcceso] (
	[ViaAcceso_id]	integer NOT NULL,
	[Descripcion]	varchar(10) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_ETNIA = '''
  CREATE TABLE [Etnia_GrupoFamiliar] (
	[Etnia_id]	integer NOT NULL,
	[Descripcion]	varchar(25) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_GENERO = '''
  CREATE TABLE [Genero_GrupoFamiliar] (
	[Genero_id]	integer NOT NULL,
  [Tipo]	varchar(15) NOT NULL COLLATE NOCASE,
	[Descripcion]	varchar(25) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_PARENTESCO = '''
  CREATE TABLE [Parentesco_GrupoFamiliar] (
	[Parentesco_id]	integer NOT NULL,
	[Descripcion]	varchar NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_REGIMEN = '''
  CREATE TABLE [Regimenes_GrupoFamiliar] (
	[TipoRegimen_id]	integer NOT NULL,
	[Tipo]	varchar(15) NOT NULL COLLATE NOCASE,
	[Descripcion]	varchar(150) NOT NULL COLLATE NOCASE
  )''';

  static const CREATE_TIPOS_DOCUMENTO = '''
  CREATE TABLE [TiposDocumento_GrupoFamiliar] (
	[TipoDocumento_id]	integer NOT NULL,
	[Tipo]	varchar(15) NOT NULL COLLATE NOCASE,
	[Descripcion]	varchar(150) NOT NULL COLLATE NOCASE
  )''';
}
