import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../core/error/failure.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/ficha_model.dart';

abstract class FichaRemoteDataSource {
  Future<List<dynamic>> createFicha();
  Future<List<FichaModel>> getFichas(String userName);
}

class FichaRemoteDataSourceImpl implements FichaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  FichaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<FichaModel>> getFichas(userName) async {
    try {
      final uri = Uri.parse('${Constants.syncUrl}/ficha/by-username/$userName');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = fichasFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  @override
  Future<List<dynamic>> createFicha() async {
    try {
      final db = await ConnectionSQLiteService.db;

      // Fichas
      final resFichas = await db.rawQuery('''
      	   SELECT
      Ficha_id,
      FechaCreacion as fechaCreacion,
      NumFicha as numFicha,
      UserName_Creacion as userNameCreacion,
      UserName_Actualizacion as ultimaActualizacion
      FROM Ficha 
	  WHERE NumFicha = '' AND Ficha.Ficha_id Not In(
	  SELECT FichasIncompletas.Ficha_id FROM Ficha as FichasIncompletas
      inner join Familia ON (Familia.Ficha_id  =  FichasIncompletas.Ficha_id)
      left join Asp3_GrupoFamiliar on (Familia.Familia_id = Asp3_GrupoFamiliar.Familia_id)
      WHERE (Asp3_GrupoFamiliar.isComplete=0 OR Asp3_GrupoFamiliar.isComplete IS NULL) AND NumFicha = '' AND Ficha_id_remote IS NULL
	  )
      ''');
      // final resFichas = await db.rawQuery('''
      // SELECT
      // Ficha_id,
      // FechaCreacion as fechaCreacion,
      // NumFicha as numFicha,
      // UserName_Creacion as userNameCreacion,
      // UserName_Actualizacion as ultimaActualizacion
      // FROM Ficha WHERE NumFicha = ''
      // ''');

      if (resFichas.isEmpty) {
        throw const ServerFailure(
            ['No existen nuevas fichas para sincronizar']);
      }

      // Almacena un array de objetos de fichas
      var lstFichas = [];

      for (final ficha in resFichas) {
        final resultMapFicha = {for (var e in ficha.entries) e.key: e.value};
        final fichaId = resultMapFicha['Ficha_id'];

        // Inicializar id en 0 para nuevas fichas en sincronizacion
        // resultMapFicha['Ficha_id'] = 0;

        // Familia
        final resFamilia = await db.rawQuery('''
          SELECT
          Familia_id AS Familia_id,
          Ficha_id AS fichaId,
          ApellidosFlia AS apellidosFlia,
          FK_Afiliado_id AS afiliadoId
          FROM Familia
          WHERE Ficha_id = $fichaId
          ''');

        if (resFamilia.isEmpty) {
          // throw const ServerFailure(
          //     ['Error al subir ficha, datos insuficientes']);
          continue;
        }

        final resultMapFamilia = {
          for (var e in resFamilia[0].entries) e.key: e.value
        };
        final familiaId = resultMapFamilia['Familia_id'];

        // Vivienda
        final resVivienda = await db.rawQuery('''
          SELECT
          DatoVivienda_id AS datoViviendaId,
          Familia_id AS familiaId,
          TipoVivienda_id AS tipoViviendaId,
          TenenciaVivienda_id AS tenenciaViviendaId,
          VentilacionVivienda_id AS ventilacionViviendaId,
          IluminacionVivienda_id AS iluminacionViviendaId,
          NroCuartosVivienda_id AS nroCuartosViviendaId
          FROM Asp2_DatosVivienda
          WHERE Familia_id = $familiaId
          ''');

        if (resVivienda.isEmpty) {
          continue;
          // throw const ServerFailure(
          //     ['Error al subir ficha, datos insuficientes']);
        }

        final resultMapVivienda = {
          for (var e in resVivienda[0].entries) e.key: e.value
        };
        final datoViviendaId = resultMapVivienda['datoViviendaId'];

        // Techos
        final resTechos = await db.rawQuery('''
          SELECT
          -- ViviendaTecho_id AS viviendaTechoId,
          DatoVivienda_id AS datoViviendaId,
          TechoVivienda_id AS techoViviendaId,
          OtroTipoTecho AS otroTipoTecho
          FROM Asp2_DatosViviendaTechos
          WHERE DatoVivienda_id = $datoViviendaId
          ''');

        var ltTechos = [];
        for (final techo in resTechos) {
          final resultMapTechos = {for (var e in techo.entries) e.key: e.value};
          ltTechos.add(resultMapTechos);
        }

        // ServPublicos
        final resServiciosPublicos = await db.rawQuery('''
          SELECT
          -- ViviendaServicioPublico_id AS viviendaServicioPublicoId,
          ServicioPublicoVivienda_id AS servicioPublicoViviendaId,
          DatoVivienda_id AS datoViviendaId,
          ServicioPublicoVivienda_id AS servicioPublicoViviendaId
          FROM Asp2_DatosViviendaServiciosPublicos
          WHERE DatoVivienda_id = $datoViviendaId
          ''');

        var ltServiciosPublicos = [];
        for (final servicio in resServiciosPublicos) {
          final resultMapServiciosPublicos = {
            for (var e in servicio.entries) e.key: e.value
          };
          ltServiciosPublicos.add(resultMapServiciosPublicos);
        }

        // TratamientosAgua
        final resTratamientosAgua = await db.rawQuery('''
          SELECT
          -- ViviendaTmtoAgua_id AS viviendaTmtoAguaId,
          DatoVivienda_id AS datoViviendaId,
          TratamientoAguaVivienda_id AS tratamientoAguaViviendaId,
          OtroTratamientoAgua AS otroTratamientoAgua
          FROM Asp2_DatosViviendaTratamientosAgua
          WHERE DatoVivienda_id = $datoViviendaId
          ''');

        var ltTratamientosAgua = [];
        for (final servicio in resTratamientosAgua) {
          final resultMapTratamientosAgua = {
            for (var e in servicio.entries) e.key: e.value
          };
          ltTratamientosAgua.add(resultMapTratamientosAgua);
        }

        // FactoresRieso
        final resFactoresRiesgo = await db.rawQuery('''
          SELECT
          -- ViviendaFactorRiesgo_id AS viviendaFactorRiesgoId,
          DatoVivienda_id AS datoViviendaId,
          FactorRiesgoVivienda_id AS factorRiesgoViviendaId,
          OtroFactorRiesgo AS otroFactorRiesgo
          FROM Asp2_DatosViviendaFactoresRiesgo
          WHERE DatoVivienda_id = $datoViviendaId
          ''');

        var ltFactoresRiesgo = [];
        for (final riesgo in resFactoresRiesgo) {
          final resultMapFactoresRiesgo = {
            for (var e in riesgo.entries) e.key: e.value
          };
          ltFactoresRiesgo.add(resultMapFactoresRiesgo);
        }

        // TiposSanitario
        final resTiposSanitario = await db.rawQuery('''
          SELECT
          -- ViviendaTipoSanitario_id AS viviendaTipoSanitarioId,
          DatoVivienda_id AS datoViviendaId,
          TipoSanitarioVivienda_id AS tipoSanitarioViviendaId,
          OtroTipoSanitario AS otroTipoSanitario
          FROM Asp2_DatosViviendaTiposSanitario
          WHERE DatoVivienda_id = $datoViviendaId
          ''');

        var ltTiposSanitario = [];
        for (final sanitario in resTiposSanitario) {
          final resultMapTiposSanitario = {
            for (var e in sanitario.entries) e.key: e.value
          };
          ltTiposSanitario.add(resultMapTiposSanitario);
        }

        // TiposCombustible
        final resTiposCombustible = await db.rawQuery('''
          SELECT
          -- ViviendaTipoCombustible_id AS viviendaTipoCombustibleId,
          DatoVivienda_id AS datoViviendaId,
          TipoCombustibleVivienda_id AS tipoCombustibleViviendaId,
          OtroTipoCombustible AS otroTipoCombustible
          FROM Asp2_DatosViviendaTiposCombustible
          WHERE DatoVivienda_id = $datoViviendaId
          ''');

        var ltTiposCombustible = [];
        for (final combustible in resTiposCombustible) {
          final resultMapTiposCombustible = {
            for (var e in combustible.entries) e.key: e.value
          };
          ltTiposCombustible.add(resultMapTiposCombustible);
        }

        // PresenciaAnimales
        final resPresenciaAnimales = await db.rawQuery('''
          SELECT
          -- ViviendaPresenciaAnimal_id AS viviendaPresenciaAnimalId,
          DatoVivienda_id AS datoViviendaId,
          PresenciaAnimalVivienda_id AS presenciaAnimalViviendaId,
          OtroPresenciaAnimal AS otroPresenciaAnimal
          FROM Asp2_DatosViviendaPresenciaAnimales
          WHERE DatoVivienda_id = $datoViviendaId
          ''');

        var ltPresenciaAnimales = [];
        for (final animal in resPresenciaAnimales) {
          final resultMapPresenciaAnimales = {
            for (var e in animal.entries) e.key: e.value
          };
          ltPresenciaAnimales.add(resultMapPresenciaAnimales);
        }

        // Pisos
        final resPisos = await db.rawQuery('''
          SELECT
          -- ViviendaPisos_id AS viviendaPisosId,
          DatoVivienda_id AS datoViviendaId,
          PisoVivienda_id AS pisoViviendaId,
          OtroTipoPiso AS otroTipoPiso
          FROM Asp2_DatosViviendaPisos AS TC
          WHERE DatoVivienda_id = $datoViviendaId
          ''');

        var ltPisos = [];
        for (final piso in resPisos) {
          final resultMapPisos = {for (var e in piso.entries) e.key: e.value};
          ltPisos.add(resultMapPisos);
        }

        Map<String, dynamic> resultVivienda = {
          ...resultMapVivienda,
          "lstTechos": ltTechos,
          "lstServPublicos": ltServiciosPublicos,
          "lstTmtoAguas": ltTratamientosAgua,
          "lstFactoresRiesgo": ltFactoresRiesgo,
          "lstTiposSanitario": ltTiposSanitario,
          "lstTiposCombustible": ltTiposCombustible,
          "lstPresenciaAnimales": ltPresenciaAnimales,
          "lstPisos": ltPisos
        };

        // Ubicacion

        final resUbicacion = await db.rawQuery('''
            SELECT
            Ubicacion_id AS ubicacionId,
            Familia_id AS familiaId,
            NombreRecibeVisita AS nombreRecibeVisita,
            TipoDoc_RecibeVisita AS tipoDocRecibeVisita,
            Documento_RecibeVisita AS documentoRecibeVisita,
            PerteneceResguardo AS perteneceResguardo,
            ViaAcceso_id AS viaAccesoId,

            (CASE WHEN Resguardo_id == 0 THEN
            null
            ELSE
              Resguardo_id
            END) as resguardoId,

            AutoridadIndigena_id AS autoridadIndigenaId,
            EstadoVia_id AS estadoViaId,

            (CASE WHEN TiempoTarda_id == 0 THEN
            null
            ELSE
              TiempoTarda_id
            END) as tiempoTardaId,

            CostoDesplazamiento_id AS costoDesplazamientoId,
            ExisteMedTradicionalComunidad AS existeMedTradicionalComunidad,

            (CASE WHEN TiempoTardaMedTrad_id == 0 THEN
            null
            ELSE
              TiempoTardaMedTrad_id
            END) as tiempoTardaMedTradId,

            CostoDesplazamiento_MedTradicional AS costoDesplazamientoMedTradicional,
            PoseeChagra AS poseeChagra,
            ProduccionMinera AS produccionMinera,
            TipoCalendario_id AS tipoCalendarioId
            FROM Asp1_Ubicacion
            WHERE Familia_id = $familiaId
            ''');

        if (resUbicacion.isEmpty) {
          continue;
        }

        final resultMapUbicacion = {
          for (var e in resUbicacion[0].entries) e.key: e.value
        };
        final ubicacionId = resultMapUbicacion['ubicacionId'];

        // DificultadAccesoMedTradicional
        final resDificultadAccesoMedTradicional = await db.rawQuery('''
          SELECT
          DificultadAccesoMedTrad_id AS dificultadAccesoMedTradId
          FROM Asp1_UbicacionAccesoMedTradicional AS AMT
          WHERE Ubicacion_id = $ubicacionId
          ''');

        var ltDificultadAccesoMedTradicional = [];

        for (final acceso in resDificultadAccesoMedTradicional) {
          final resultMapDificultadAccesoMedTradicional = {
            for (var e in acceso.entries) e.key: e.value
          };
          ltDificultadAccesoMedTradicional
              .add(resultMapDificultadAccesoMedTradicional);
        }

        // Cereales
        final resCereales = await db.rawQuery('''
          SELECT
          Cereal_id AS cerealId,
          OtroCereal AS otroCereal
          FROM Asp1_UbicacionCereales
          WHERE Ubicacion_id = $ubicacionId
          ''');

        var ltCereales = [];
        for (final acceso in resCereales) {
          final resultMapCereales = {
            for (var e in acceso.entries) e.key: e.value
          };
          ltCereales.add(resultMapCereales);
        }

        // DificultadAcceso
        final resDificultadAcceso = await db.rawQuery('''
          SELECT
          DificultaAcceso_id AS dificultaAccesoId
          FROM Asp1_UbicacionDificultadAcceso
          WHERE Ubicacion_id = $ubicacionId
          ''');

        var ltDificultadAcceso = [];
        for (final dificultad in resDificultadAcceso) {
          final resultMapDificultadAcceso = {
            for (var e in dificultad.entries) e.key: e.value
          };
          ltDificultadAcceso.add(resultMapDificultadAcceso);
        }

        // EspecialidadMedTradicional
        final resEspecialidadMedTradicional = await db.rawQuery('''
          SELECT
          EspecialidadMedTrad_id AS especialidadMedTradId
          FROM Asp1_UbicacionEspecialidadMedTradicional
          WHERE Ubicacion_id = $ubicacionId
          ''');

        var ltEspecialidadMedTradicional = [];
        for (final especialidad in resEspecialidadMedTradicional) {
          final resultMapEspecialidadMedTradicional = {
            for (var e in especialidad.entries) e.key: e.value
          };
          ltEspecialidadMedTradicional.add(resultMapEspecialidadMedTradicional);
        }

        // EspecieAnimalesCria
        final resEspecieAnimalesCria = await db.rawQuery('''
          SELECT
          EspecieAnimalCria_id AS especieAnimalCriaId
          FROM Asp1_UbicacionEspecieAnimalesCria
          WHERE Ubicacion_id = $ubicacionId
          ''');

        var ltEspecieAnimalesCria = [];
        for (final animales in resEspecieAnimalesCria) {
          final resultMapEspecieAnimalesCria = {
            for (var e in animales.entries) e.key: e.value
          };
          ltEspecieAnimalesCria.add(resultMapEspecieAnimalesCria);
        }

        // Frutos
        final resFrutos = await db.rawQuery('''
          SELECT
          Fruto_id AS frutoId
          FROM Asp1_UbicacionFrutos
          WHERE Ubicacion_id = $ubicacionId
          ''');

        var ltFrutos = [];
        for (final fruto in resFrutos) {
          final resultMapFrutos = {for (var e in fruto.entries) e.key: e.value};
          ltFrutos.add(resultMapFrutos);
        }

        // Hortalizas
        final resHortalizas = await db.rawQuery('''
          SELECT
          Hortaliza_id AS hortalizaId,
          OtroHortaliza AS otroHortaliza
          FROM Asp1_UbicacionHortalizas
          WHERE Ubicacion_id = $ubicacionId
          ''');

        var ltHortalizas = [];
        for (final hortaliza in resHortalizas) {
          final resultMapHortalizas = {
            for (var e in hortaliza.entries) e.key: e.value
          };
          ltHortalizas.add(resultMapHortalizas);
        }

        // Leguminosas
        final resLeguminosas = await db.rawQuery('''
          SELECT
          Leguminosa_id AS leguminosaId
          FROM Asp1_UbicacionLeguminosas
          WHERE Ubicacion_id = $ubicacionId
          ''');

        var ltLeguminosas = [];
        for (final leguminosa in resLeguminosas) {
          final resultMapLeguminosas = {
            for (var e in leguminosa.entries) e.key: e.value
          };
          ltLeguminosas.add(resultMapLeguminosas);
        }

        // MediosComunicacion
        final resMediosComunicacion = await db.rawQuery('''
          SELECT
          MedioComunicacion_id AS medioComunicacionId
          FROM Asp1_UbicacionMediosComunicacion
          WHERE Ubicacion_id = $ubicacionId
          ''');

        var ltMediosComunicacion = [];
        for (final medio in resMediosComunicacion) {
          final resultMapMediosComunicacion = {
            for (var e in medio.entries) e.key: e.value
          };
          ltMediosComunicacion.add(resultMapMediosComunicacion);
        }

        // MediosMedTradicional
        final resMediosMedTradicional = await db.rawQuery('''
          SELECT
          MedioUtilizaMedTrad_id AS medioUtilizaMedTradId
          FROM Asp1_UbicacionMediosMedTradicional
          WHERE Ubicacion_id = $ubicacionId
          ''');

        var ltMediosMedTradicional = [];
        for (final medio in resMediosMedTradicional) {
          final resultMapMediosMedTradicional = {
            for (var e in medio.entries) e.key: e.value
          };
          ltMediosMedTradicional.add(resultMapMediosMedTradicional);
        }

        // NombresMedTradicional
        final resNombresMedTradicional = await db.rawQuery('''
          SELECT
          NombreMedTradicional AS nombreMedTradicional
          FROM Asp1_UbicacionNombresMedTradicional
          WHERE Ubicacion_id = $ubicacionId
          ''');

        var ltNombresMedTradicional = [];
        for (final nombre in resNombresMedTradicional) {
          final resultMapNombresMedTradicional = {
            for (var e in nombre.entries) e.key: e.value
          };
          ltNombresMedTradicional.add(resultMapNombresMedTradicional);
        }

        // TuberculosPlatanos
        final resTuberculosPlatanos = await db.rawQuery('''
          SELECT
          TuberculoPlatano_id AS tuberculoPlatanoId,
          OtroTuberculoPlatano AS otroTuberculoPlatano
          FROM Asp1_UbicacionTuberculosPlatanos
          WHERE Ubicacion_id = $ubicacionId
          ''');

        var ltTuberculosPlatanos = [];
        for (final tuberculo in resTuberculosPlatanos) {
          final resultMapTuberculosPlatanos = {
            for (var e in tuberculo.entries) e.key: e.value
          };
          ltTuberculosPlatanos.add(resultMapTuberculosPlatanos);
        }

        // Verduras
        final resVerduras = await db.rawQuery('''
          SELECT
          Verdura_id AS verduraId,
          OtroVerdura AS otroVerdura
          FROM Asp1_UbicacionVerduras
          WHERE Ubicacion_id = $ubicacionId
          ''');

        var ltVerduras = [];
        for (final verdura in resVerduras) {
          final resultMapVerduras = {
            for (var e in verdura.entries) e.key: e.value
          };
          ltVerduras.add(resultMapVerduras);
        }

        // MediosCentroAtencion
        final resMediosCentroAtencion = await db.rawQuery('''
          SELECT
          MedioUtiliza_id AS medioUtilizaId
          FROM Asp1_UbicacionMediosCentroAtencion
          WHERE Ubicacion_id = $ubicacionId
          ''');

        var ltMediosCentroAtencion = [];
        for (final medio in resMediosCentroAtencion) {
          final resultMapMediosCentroAtencion = {
            for (var e in medio.entries) e.key: e.value
          };
          ltMediosCentroAtencion.add(resultMapMediosCentroAtencion);
        }

        Map<String, dynamic> resultUbicacion = {
          ...resultMapUbicacion,
          "lstDificultadAccesoMedTradicional": ltDificultadAccesoMedTradicional,
          "lstCereales": ltCereales,
          "lstDificultadAccesoAtencion": ltDificultadAcceso,
          "lstEspMedTradicional": ltEspecialidadMedTradicional,
          "lstAnimalCria": ltEspecieAnimalesCria,
          "lstFrutos": ltFrutos,
          "lstHortalizas": ltHortalizas,
          "lstLeguminosas": ltLeguminosas,
          "lstMediosComunica": ltMediosComunicacion,
          "lstMediosMedTradicional": ltMediosMedTradicional,
          "lstNombreMedtradicional": ltNombresMedTradicional,
          "lstTuberculos": ltTuberculosPlatanos,
          "lstVerduras": ltVerduras,
          "lstMediosCentroAtencion": ltMediosCentroAtencion,
        };

        // GrupoFamiliar
        final resGrupoFamiliar = await db.rawQuery('''
          SELECT
          Familia_id AS familiaId,
          Afiliado_id AS afiliadoId,
          TipoDocumento_id AS tipoDocumentoId,
          Documento AS documento,
          Genero_id AS generoId,
          FechaNacimiento AS fechaNacimiento,
          Edad AS edad,
          TipoRegimen_id AS tipoRegimenId,
          Parentesco_id AS parentescoId,
          Etnia_id AS etniaId,
          CursoVida_id AS cursoVidaId,
          NivelEducativo_id AS nivelEducativoId,
          Ocupacion_id AS ocupacionId,
          OtroOcupacion AS otroOcupacion,
          GrupoRiesgo_id AS grupoRiesgoId,
          OrigenEtnico5602_id AS origenEtnico5602Id,


          (CASE WHEN PuebloIndigena_id == 0 THEN 
              null 
          ELSE 
            PuebloIndigena_id 
          END) as puebloIndigenaId,

          (CASE WHEN LenguaManeja_id == 0 THEN 
              null 
          ELSE 
            LenguaManeja_id 
          END) as lenguaManejaId,

          (CASE WHEN LenguaMaterna_id == 0 THEN 
          null 
          ELSE 
            LenguaMaterna_id 
          END) as lenguaMaternaId

          FROM Asp3_GrupoFamiliar
          WHERE Familia_id = $familiaId
          ''');

        if (resGrupoFamiliar.isEmpty) {
          continue;
        }

        var ltGrupoFamiliar = [];
        for (final familia in resGrupoFamiliar) {
          final resultMapGrupoFamiliar = {
            for (var e in familia.entries) e.key: e.value
          };
          ltGrupoFamiliar.add(resultMapGrupoFamiliar);
        }

        // EstilosVidaSaludable
        final resEstilosVidaSaludable = await db.rawQuery('''
          SELECT
          Afiliado_id AS afiliadoId,
          Familia_id AS familiaId,
          ActividadFisica_id AS actividadFisicaId,
          Alimentacion_id AS alimentacionId,
          ConsumoAlcohol_id AS consumoAlcoholId,
          ConsumeCigarrillo AS consumeCigarrillo,
          (CASE WHEN NumeroCigarrilloDia_id == 0 THEN
          null
          ELSE
            NumeroCigarrilloDia_id
          END) as numeroCigarrilloDiaId,
          ConsumoSustanciasPsicoactivas AS consumoSustanciasPsicoactivas
          FROM Asp4_EstilosVidaSaludable
          WHERE Familia_id = $familiaId
          ''');

        if (resEstilosVidaSaludable.isEmpty) {
          continue;
        }

        var ltEstilosVidaSaludable = [];
        for (final estilo in resEstilosVidaSaludable) {
          final resultMapEstilosVidaSaludable = {
            for (var e in estilo.entries) e.key: e.value
          };
          ltEstilosVidaSaludable.add(resultMapEstilosVidaSaludable);
        }

        // CuidadoSaludCondRiesgo
        final resCuidadoSaludCondRiesgo = await db.rawQuery('''
          SELECT
          CuidadoSaludCondRiesgo_id AS cuidadoSaludCondRiesgoId,
          Afiliado_id AS afiliadoId,
          Familia_id AS familiaId,
          UltimaVezInstSalud_id AS ultimaVezInstSaludId,

          (CASE WHEN SeguimientoEnfermedad_id == 0 THEN
              null
          ELSE
            SeguimientoEnfermedad_id
          END) as seguimientoEnfermedadId,

          CondicionNutricional_id AS condicionNutricionalId,
          TosFlema_id AS tosFlemaId,
          ManchasPiel_id AS manchasPielId,
          CarnetVacunacion_id AS carnetVacunacionId,

          (CASE WHEN EsquemaVacunacion_id == 0 THEN
              null
          ELSE
            EsquemaVacunacion_id
          END) as esquemaVacunacionId,

          (CASE WHEN LugarVacunacion_id == 0 THEN
              null
          ELSE
            LugarVacunacion_id
          END) as lugarVacunacionId,

          UtilizaMetodoPlanificacion_id AS utilizaMetodoPlanificacionId,

          (CASE WHEN MetodoPlanificacion_id == 0 THEN
              null
          ELSE
            MetodoPlanificacion_id
          END) as metodoPlanificacionId,

          (CASE WHEN ConductaSeguir_id == 0 THEN
              null
          ELSE
            ConductaSeguir_id
          END) as conductaSeguirId

          FROM Asp5_CuidadoSaludCondRiesgo
          WHERE Familia_id = $familiaId
          ''');

        if (resCuidadoSaludCondRiesgo.isEmpty) {
          continue;
        }

        var ltCuidadoSaludCondRiesgo = [];
        for (final cuidado in resCuidadoSaludCondRiesgo) {
          final resultMapCuidadoSaludCondRiesgo = {
            for (var e in cuidado.entries) e.key: e.value
          };
          final cuidadoSaludConRiesgoId =
              resultMapCuidadoSaludCondRiesgo['cuidadoSaludCondRiesgoId'];

          // ServiciosSolicita
          final resServiciosSolicita = await db.rawQuery('''
            SELECT
            CuidadoSaludCondRiesgo_id AS cuidadoSaludCondRiesgoId,
            ServicioSolicitado_id AS servicioSolicitadoId
            FROM Asp5_CuidadoSaludCondRiesgoServiciosSolicita
            WHERE CuidadoSaludCondRiesgo_id = $cuidadoSaludConRiesgoId
            ''');

          var ltServiciosSolicita = [];
          for (final servicio in resServiciosSolicita) {
            final resultMapServiciosSolicita = {
              for (var e in servicio.entries) e.key: e.value
            };
            ltServiciosSolicita.add(resultMapServiciosSolicita);
          }

          // NombresEnfermedad
          final resNombresEnfermedad = await db.rawQuery('''
            SELECT
            CuidadoSaludCondRiesgo_id AS cuidadoSaludCondRiesgoId,
            NombreEnfermedad_id AS nombreEnfermedadId
            FROM Asp5_CuidadoSaludCondRiesgoNombresEnfermedad
            WHERE CuidadoSaludCondRiesgo_id = $cuidadoSaludConRiesgoId
            ''');

          var ltNombresEnfermedad = [];
          for (final enfermedad in resNombresEnfermedad) {
            final resultMapNombresEnfermedad = {
              for (var e in enfermedad.entries) e.key: e.value
            };
            ltNombresEnfermedad.add(resultMapNombresEnfermedad);
          }

          Map<String, dynamic> resultCuidadoSaludCondRiesgo = {
            ...resultMapCuidadoSaludCondRiesgo,
            "lstServiciosSolicita": ltServiciosSolicita,
            "lstNombreEnfermedad": ltNombresEnfermedad,
          };

          ltCuidadoSaludCondRiesgo.add(resultCuidadoSaludCondRiesgo);
        }

        // SocioCulturalPueblosIndigenas
        final resSocioCulturalPueblosIndigenas = await db.rawQuery('''
          SELECT
          DimSocioCulturalPueblosIndigenas_id AS dimSocioCulturalPueblosIndigenasId,
          Familia_id AS familiaId,
          Afiliado_id AS afiliadoId,
          ReligionProfesa_id AS religionProfesaId,
          ConoceUsosCostumbres_id AS conoceUsosCostumbresId,
          Cuales_UsosCostumbres AS cualesUsosCostumbres,

          (CASE WHEN ParticipaCostumbres_id == 0 THEN
              null
          ELSE
            ParticipaCostumbres_id
          END) as participaCostumbresId,

          (CASE WHEN CostumbrePractica_id == 0 THEN
              null
          ELSE
            CostumbrePractica_id
          END) as costumbrePracticaId,

          (CASE WHEN SancionJusticia_id == 0 THEN
              null
          ELSE
            SancionJusticia_id
          END) as sancionJusticiaId,

          SitiosSagrados_id AS sitiosSagradosId,
          Cuales_SitiosSagrados AS cualesSitiosSagrados
          FROM Asp6_DimSocioCulturalPueblosIndigenas
          WHERE Familia_id = $familiaId
          ''');

        if (resSocioCulturalPueblosIndigenas.isEmpty) {
          continue;
        }

        var ltSocioCulturalPueblosIndigenas = [];
        for (final pueblo in resSocioCulturalPueblosIndigenas) {
          final resultMapSocioCulturalPueblosIndigenas = {
            for (var e in pueblo.entries) e.key: e.value
          };
          final dimSocioCulturalPueblosIndigenasId =
              resultMapSocioCulturalPueblosIndigenas[
                  'dimSocioCulturalPueblosIndigenasId'];

          // EventosCostumbresParticipa
          final resEventosCostumbresParticipa = await db.rawQuery('''
            SELECT
            DimSocioCulturalPueblosIndigenas_id AS dimSocioCulturalPueblosIndigenasId,
            EventoCostumbreParticipo_id AS eventoCostumbreParticipoId
            FROM Asp6_DimSocioCulturalEventosCostumbresParticipo
            WHERE DimSocioCulturalPueblosIndigenas_id = $dimSocioCulturalPueblosIndigenasId
            ''');

          var ltEventosCostumbresParticipa = [];
          for (final servicio in resEventosCostumbresParticipa) {
            final resultMapEventosCostumbresParticipa = {
              for (var e in servicio.entries) e.key: e.value
            };
            ltEventosCostumbresParticipa
                .add(resultMapEventosCostumbresParticipa);
          }

          Map<String, dynamic> resultSocioCulturalPueblosIndigenas = {
            ...resultMapSocioCulturalPueblosIndigenas,
            "lstEventosCostumbresParticipa": ltEventosCostumbresParticipa,
          };

          ltSocioCulturalPueblosIndigenas
              .add(resultSocioCulturalPueblosIndigenas);
        }

        // AtencionSalud
        final resAtencionSalud = await db.rawQuery('''
          SELECT
          AtencionSalud_id AS atencionSaludId,
          Afiliado_id AS afiliadoId,
          Familia_id AS familiaId,
          EnfermedadAcude_id AS enfermedadAcudeId,
          RecibioAtencionMedTradicional_id AS recibioAtencionMedTradicionalId,
          EnfermedadTratamiento_id AS enfermedadTratamientoId,
          UtilizaPlantasMed_id AS utilizaPlantasMedId,

          (CASE WHEN LugarPlantaMedicinal_id == 0 THEN
              null
          ELSE
            LugarPlantaMedicinal_id
          END) as lugarPlantaMedicinalId

          FROM Asp7_AtencionSalud
          WHERE Familia_id = $familiaId
          ''');

        if (resAtencionSalud.isEmpty) {
          continue;
        }

        var ltAtencionSalud = [];
        for (final atencion in resAtencionSalud) {
          final resultMapAtencionSalud = {
            for (var e in atencion.entries) e.key: e.value
          };
          final atencionSaludId = resultMapAtencionSalud['atencionSaludId'];

          // EnfermedadesTRadicionales
          final resEnfermedadesTradicionales = await db.rawQuery('''
            SELECT
            AtencionSalud_id AS atencionSaludId,
            EnfermedadTradicional_id AS enfermedadTradicionalId
            FROM Asp7_EnfermedadesTradicionales_AtencionSalud
            WHERE AtencionSalud_id = $atencionSaludId
            ''');

          var ltEnfermedadesTradicionales = [];
          for (final enfermedad in resEnfermedadesTradicionales) {
            final resultMapEnfermedadesTradicionales = {
              for (var e in enfermedad.entries) e.key: e.value
            };
            ltEnfermedadesTradicionales.add(resultMapEnfermedadesTradicionales);
          }

          // EnfermedadesTRadicionales
          final resEspecialidadesMedTradAtencionSalud = await db.rawQuery('''
            SELECT
            AtencionSalud_id AS atencionSaludId,
            EspecialidadMedTrad_id AS especialidadMedTradId
            FROM Asp7_EspecialidadesMedTradAtencionSalud
            WHERE AtencionSalud_id = $atencionSaludId
            ''');

          var ltEspecialidadesMedTradAtencionSalud = [];
          for (final especialidad in resEspecialidadesMedTradAtencionSalud) {
            final resultMapEspecialidadesMedTradAtencionSalud = {
              for (var e in especialidad.entries) e.key: e.value
            };
            ltEspecialidadesMedTradAtencionSalud
                .add(resultMapEspecialidadesMedTradAtencionSalud);
          }

          // Lugaresatencion
          final resLugaresAtencionSalud = await db.rawQuery('''
            SELECT
            AtencionSalud_id AS atencionSaludId,
            LugarAtencionMedico_id AS lugarAtencionMedicoId
            FROM Asp7_LugaresAtencionAtencionSalud
            WHERE AtencionSalud_id = $atencionSaludId
            ''');

          var ltLugaresAtencionSalud = [];
          for (final lugar in resLugaresAtencionSalud) {
            final resultMapLugaresAtencionSalud = {
              for (var e in lugar.entries) e.key: e.value
            };
            ltLugaresAtencionSalud.add(resultMapLugaresAtencionSalud);
          }

          // PlantasMedicinales
          final resPlantasMedicinales = await db.rawQuery('''
            SELECT
            AtencionSalud_id AS atencionSaludId,
            PlantaMedicinal_id AS plantaMedicinalId
            FROM Asp7_PlantasMedicinales_AtencionSalud
            WHERE AtencionSalud_id = $atencionSaludId
            ''');

          var ltPlantasMedicinales = [];
          for (final lugar in resPlantasMedicinales) {
            final resultMapPlantasMedicinales = {
              for (var e in lugar.entries) e.key: e.value
            };
            ltPlantasMedicinales.add(resultMapPlantasMedicinales);
          }

          Map<String, dynamic> resultAtencionSalud = {
            ...resultMapAtencionSalud,
            "lstEnfermedadesTRadicionales": ltEnfermedadesTradicionales,
            "lstEpecialidadesMedTradicional":
                ltEspecialidadesMedTradAtencionSalud,
            "lstLugaresatencion": ltLugaresAtencionSalud,
            "lstPlantasMedicinales": ltPlantasMedicinales,
          };

          ltAtencionSalud.add(resultAtencionSalud);
        }

        Map<String, dynamic> resultFamilia = {
          ...resultMapFamilia,
          "vivienda": resultVivienda,
          "ubicacion": resultUbicacion,
          "grupoFamiliar": ltGrupoFamiliar,
          "estilosVidaSaludable": ltEstilosVidaSaludable,
          "cuidadoSaludCondRiesgo": ltCuidadoSaludCondRiesgo,
          "socioCulturalPueblosIndigenas": ltSocioCulturalPueblosIndigenas,
          "atencionSalud": ltAtencionSalud
        };

        // Crear Objeto
        Map<String, dynamic> result = {
          ...resultMapFicha,
          "familia": resultFamilia,
        };

        lstFichas.add(result);
      }
      if (lstFichas.isEmpty) {
        throw const ServerFailure(
            ['No existen nuevas fichas completas para sincronizar']);
      }
      return lstFichas;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
