import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/app_config.dart';
import '../../../core/constants.dart';
import '../../../core/error/failure.dart';

import '../../../services/shared_preferences_service.dart';
import '../../models/ficha.dart';

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
      final uri =
          Uri.parse('${AppConfig.syncPublica}/ficha/by-username/$userName');

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
        throw const ServerFailure([unexpectedErrorMessage]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  @override
  Future<List<dynamic>> createFicha() async {
    try {
      // Fichas
      // Fetch the IDs that should be excluded
      final excludedFichas = await supabase
          .from('Ficha')
          .select('Ficha_id')
          .eq('NumFicha', '')
          .in_(
              'Ficha.Ficha_id',
              (await supabase
                  .from('Familia')
                  .select('Ficha_id, Asp3_GrupoFamiliar!inner(Familia_id)')
                  .is_('Asp3_GrupoFamiliar.isComplete', null)
                  .or('Asp3_GrupoFamiliar.isComplete.eq.false, Asp3_GrupoFamiliar.isComplete.is.null')
                  .is_('Ficha_id_remote', null)));

      final fichaIdsToExclude =
          excludedFichas.data.map((e) => e['Ficha_id']).toList();

// Main query excluding the fetched IDs
      final resFichas = await supabase
          .from('Ficha')
          .select(
              'Ficha_id, FechaCreacion as fechaCreacion, NumFicha as numFicha, UserName_Creacion as userNameCreacion, UserName_Actualizacion as ultimaActualizacion')
          .eq('NumFicha', '')
          .not('Ficha_id', 'in', fichaIdsToExclude);

// Process the result
      final result =
          resFichas.data.map((ficha) => FichaModel.fromJson(ficha)).toList();

      if (result.isEmpty) {
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
        final resFamilia = await supabase
            .from('Familia')
            .select('Familia_id, Ficha_id, ApellidosFlia, FK_Afiliado_id')
            .eq('Ficha_id', fichaId);

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
        // Query to fetch Asp2_DatosVivienda records based on Familia_id
        final resVivienda = await supabase
            .from('Asp2_DatosVivienda')
            .select(
                'DatoVivienda_id, Familia_id, TipoVivienda_id, TenenciaVivienda_id, VentilacionVivienda_id, IluminacionVivienda_id, NroCuartosVivienda_id')
            .eq('Familia_id', familiaId);

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
        final resTechos = await supabase
            .from('Asp2_DatosViviendaTechos')
            .select('DatoVivienda_id, TechoVivienda_id, OtroTipoTecho')
            .eq('DatoVivienda_id', datoViviendaId);

        var ltTechos = [];
        for (final techo in resTechos) {
          final resultMapTechos = {for (var e in techo.entries) e.key: e.value};
          ltTechos.add(resultMapTechos);
        }

        // ServPublicos
        final resServiciosPublicos = await supabase
            .from('Asp2_DatosViviendaServiciosPublicos')
            .select(
                'ServicioPublicoVivienda_id, DatoVivienda_id, ServicioPublicoVivienda_id')
            .eq('DatoVivienda_id', datoViviendaId);

        var ltServiciosPublicos = [];
        for (final servicio in resServiciosPublicos) {
          final resultMapServiciosPublicos = {
            for (var e in servicio.entries) e.key: e.value
          };
          ltServiciosPublicos.add(resultMapServiciosPublicos);
        }

        final resTratamientosAgua = await supabase
            .from('Asp2_DatosViviendaTratamientosAgua')
            .select(
                'DatoVivienda_id, TratamientoAguaVivienda_id, OtroTratamientoAgua')
            .eq('DatoVivienda_id', datoViviendaId);

        var ltTratamientosAgua = [];
        for (final servicio in resTratamientosAgua) {
          final resultMapTratamientosAgua = {
            for (var e in servicio.entries) e.key: e.value
          };
          ltTratamientosAgua.add(resultMapTratamientosAgua);
        }

        // FactoresRieso
        final resFactoresRiesgo = await supabase
            .from('Asp2_DatosViviendaFactoresRiesgo')
            .select(
                'DatoVivienda_id, FactorRiesgoVivienda_id, OtroFactorRiesgo')
            .eq('DatoVivienda_id', datoViviendaId);

        var ltFactoresRiesgo = [];
        for (final riesgo in resFactoresRiesgo) {
          final resultMapFactoresRiesgo = {
            for (var e in riesgo.entries) e.key: e.value
          };
          ltFactoresRiesgo.add(resultMapFactoresRiesgo);
        }

        // TiposSanitario
        final resTiposSanitario = await supabase
            .from('Asp2_DatosViviendaTiposSanitario')
            .select(
                'DatoVivienda_id, TipoSanitarioVivienda_id, OtroTipoSanitario')
            .eq('DatoVivienda_id', datoViviendaId);

        var ltTiposSanitario = [];
        for (final sanitario in resTiposSanitario) {
          final resultMapTiposSanitario = {
            for (var e in sanitario.entries) e.key: e.value
          };
          ltTiposSanitario.add(resultMapTiposSanitario);
        }

        // TiposCombustible
        final resTiposCombustible = await supabase
            .from('Asp2_DatosViviendaTiposCombustible')
            .select(
                'DatoVivienda_id, TipoCombustibleVivienda_id, OtroTipoCombustible')
            .eq('DatoVivienda_id', datoViviendaId);

        var ltTiposCombustible = [];
        for (final combustible in resTiposCombustible) {
          final resultMapTiposCombustible = {
            for (var e in combustible.entries) e.key: e.value
          };
          ltTiposCombustible.add(resultMapTiposCombustible);
        }

        // PresenciaAnimales
        final resPresenciaAnimales = await supabase
            .from('Asp2_DatosViviendaPresenciaAnimales')
            .select(
                'DatoVivienda_id, PresenciaAnimalVivienda_id, OtroPresenciaAnimal')
            .eq('DatoVivienda_id', datoViviendaId);

        var ltPresenciaAnimales = [];
        for (final animal in resPresenciaAnimales) {
          final resultMapPresenciaAnimales = {
            for (var e in animal.entries) e.key: e.value
          };
          ltPresenciaAnimales.add(resultMapPresenciaAnimales);
        }

        // Pisos
        final resPisos = await supabase
            .from('Asp2_DatosViviendaPisos')
            .select('DatoVivienda_id, PisoVivienda_id, OtroTipoPiso')
            .eq('DatoVivienda_id', datoViviendaId);

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

        // Query to fetch Asp1_Ubicacion records based on Familia_id
        final resUbicacion = await supabase.from('Asp1_Ubicacion').select('''
      Ubicacion_id, 
      Familia_id, 
      NombreRecibeVisita, 
      TipoDoc_RecibeVisita, 
      Documento_RecibeVisita, 
      PerteneceResguardo, 
      ViaAcceso_id, 
      CASE 
        WHEN Resguardo_id = 0 THEN null 
        ELSE Resguardo_id 
      END as resguardoId, 
      AutoridadIndigena_id, 
      EstadoVia_id, 
      CASE 
        WHEN TiempoTarda_id = 0 THEN null 
        ELSE TiempoTarda_id 
      END as tiempoTardaId, 
      CostoDesplazamiento_id, 
      ExisteMedTradicionalComunidad, 
      CASE 
        WHEN TiempoTardaMedTrad_id = 0 THEN null 
        ELSE TiempoTardaMedTrad_id 
      END as tiempoTardaMedTradId, 
      CostoDesplazamiento_MedTradicional, 
      PoseeChagra, 
      ProduccionMinera, 
      TipoCalendario_id
    ''').eq('Familia_id', familiaId);

        if (resUbicacion.isEmpty) {
          continue;
        }

        final resultMapUbicacion = {
          for (var e in resUbicacion[0].entries) e.key: e.value
        };
        final ubicacionId = resultMapUbicacion['ubicacionId'];

        // DificultadAccesoMedTradicional
        final resDificultadAccesoMedTradicional = await supabase
            .from('Asp1_UbicacionAccesoMedTradicional')
            .select('DificultadAccesoMedTrad_id')
            .eq('Ubicacion_id', ubicacionId);

        var ltDificultadAccesoMedTradicional = [];

        for (final acceso in resDificultadAccesoMedTradicional) {
          final resultMapDificultadAccesoMedTradicional = {
            for (var e in acceso.entries) e.key: e.value
          };
          ltDificultadAccesoMedTradicional
              .add(resultMapDificultadAccesoMedTradicional);
        }

        // Cereales
        final resCereales = await supabase
            .from('Asp1_UbicacionCereales')
            .select('Cereal_id, OtroCereal')
            .eq('Ubicacion_id', ubicacionId);

        var ltCereales = [];
        for (final acceso in resCereales) {
          final resultMapCereales = {
            for (var e in acceso.entries) e.key: e.value
          };
          ltCereales.add(resultMapCereales);
        }

        // DificultadAcceso
        final resDificultadAcceso = await supabase
            .from('Asp1_UbicacionDificultadAcceso')
            .select('DificultaAcceso_id')
            .eq('Ubicacion_id', ubicacionId);

        var ltDificultadAcceso = [];
        for (final dificultad in resDificultadAcceso) {
          final resultMapDificultadAcceso = {
            for (var e in dificultad.entries) e.key: e.value
          };
          ltDificultadAcceso.add(resultMapDificultadAcceso);
        }

        // EspecialidadMedTradicional
        final resEspecialidadMedTradicional = await supabase
            .from('Asp1_UbicacionEspecialidadMedTradicional')
            .select('EspecialidadMedTrad_id')
            .eq('Ubicacion_id', ubicacionId);

        var ltEspecialidadMedTradicional = [];
        for (final especialidad in resEspecialidadMedTradicional) {
          final resultMapEspecialidadMedTradicional = {
            for (var e in especialidad.entries) e.key: e.value
          };
          ltEspecialidadMedTradicional.add(resultMapEspecialidadMedTradicional);
        }

        // EspecieAnimalesCria
        final resEspecieAnimalesCria = await supabase
            .from('Asp1_UbicacionEspecieAnimalesCria')
            .select('EspecieAnimalCria_id')
            .eq('Ubicacion_id', ubicacionId);

        var ltEspecieAnimalesCria = [];
        for (final animales in resEspecieAnimalesCria) {
          final resultMapEspecieAnimalesCria = {
            for (var e in animales.entries) e.key: e.value
          };
          ltEspecieAnimalesCria.add(resultMapEspecieAnimalesCria);
        }

        // Frutos
        final resFrutos = await supabase
            .from('Asp1_UbicacionFrutos')
            .select('Fruto_id')
            .eq('Ubicacion_id', ubicacionId);

        var ltFrutos = [];
        for (final fruto in resFrutos) {
          final resultMapFrutos = {for (var e in fruto.entries) e.key: e.value};
          ltFrutos.add(resultMapFrutos);
        }

        // Hortalizas
        final resHortalizas = await supabase
            .from('Asp1_UbicacionHortalizas')
            .select('Hortaliza_id, OtroHortaliza')
            .eq('Ubicacion_id', ubicacionId);

        var ltHortalizas = [];
        for (final hortaliza in resHortalizas) {
          final resultMapHortalizas = {
            for (var e in hortaliza.entries) e.key: e.value
          };
          ltHortalizas.add(resultMapHortalizas);
        }

        // Leguminosas
        final resLeguminosas = await supabase
            .from('Asp1_UbicacionLeguminosas')
            .select('Leguminosa_id')
            .eq('Ubicacion_id', ubicacionId);

        var ltLeguminosas = [];
        for (final leguminosa in resLeguminosas) {
          final resultMapLeguminosas = {
            for (var e in leguminosa.entries) e.key: e.value
          };
          ltLeguminosas.add(resultMapLeguminosas);
        }

        // MediosComunicacion
        final resMediosComunicacion = await supabase
            .from('Asp1_UbicacionMediosComunicacion')
            .select('MedioComunicacion_id')
            .eq('Ubicacion_id', ubicacionId);

        var ltMediosComunicacion = [];
        for (final medio in resMediosComunicacion) {
          final resultMapMediosComunicacion = {
            for (var e in medio.entries) e.key: e.value
          };
          ltMediosComunicacion.add(resultMapMediosComunicacion);
        }

        // MediosMedTradicional
        final resMediosMedTradicional = await supabase
            .from('Asp1_UbicacionMediosMedTradicional')
            .select('MedioUtilizaMedTrad_id')
            .eq('Ubicacion_id', ubicacionId);

        var ltMediosMedTradicional = [];
        for (final medio in resMediosMedTradicional) {
          final resultMapMediosMedTradicional = {
            for (var e in medio.entries) e.key: e.value
          };
          ltMediosMedTradicional.add(resultMapMediosMedTradicional);
        }

        // NombresMedTradicional
        final resNombresMedTradicional = await supabase
            .from('Asp1_UbicacionNombresMedTradicional')
            .select('NombreMedTradicional')
            .eq('Ubicacion_id', ubicacionId);

        var ltNombresMedTradicional = [];
        for (final nombre in resNombresMedTradicional) {
          final resultMapNombresMedTradicional = {
            for (var e in nombre.entries) e.key: e.value
          };
          ltNombresMedTradicional.add(resultMapNombresMedTradicional);
        }

        // TuberculosPlatanos
        final resTuberculosPlatanos = await supabase
            .from('Asp1_UbicacionTuberculosPlatanos')
            .select('TuberculoPlatano_id, OtroTuberculoPlatano')
            .eq('Ubicacion_id', ubicacionId);

        var ltTuberculosPlatanos = [];
        for (final tuberculo in resTuberculosPlatanos) {
          final resultMapTuberculosPlatanos = {
            for (var e in tuberculo.entries) e.key: e.value
          };
          ltTuberculosPlatanos.add(resultMapTuberculosPlatanos);
        }

        // Verduras
        final resVerduras = await supabase
            .from('Asp1_UbicacionVerduras')
            .select('Verdura_id, OtroVerdura')
            .eq('Ubicacion_id', ubicacionId);

        var ltVerduras = [];
        for (final verdura in resVerduras) {
          final resultMapVerduras = {
            for (var e in verdura.entries) e.key: e.value
          };
          ltVerduras.add(resultMapVerduras);
        }

        // MediosCentroAtencion
        final resMediosCentroAtencion = await supabase
            .from('Asp1_UbicacionMediosCentroAtencion')
            .select('MedioUtiliza_id')
            .eq('Ubicacion_id', ubicacionId);

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
        // Query to fetch Asp3_GrupoFamiliar records based on Familia_id
        final resGrupoFamiliar =
            await supabase.from('Asp3_GrupoFamiliar').select('''
      Familia_id, 
      Afiliado_id, 
      TipoDocumento_id, 
      Documento, 
      Genero_id, 
      FechaNacimiento, 
      Edad, 
      TipoRegimen_id, 
      Parentesco_id, 
      Etnia_id, 
      CursoVida_id, 
      NivelEducativo_id, 
      Ocupacion_id, 
      OtroOcupacion, 
      GrupoRiesgo_id, 
      OrigenEtnico5602_id, 
      CASE 
        WHEN PuebloIndigena_id = 0 THEN null 
        ELSE PuebloIndigena_id 
      END as puebloIndigenaId, 
      CASE 
        WHEN LenguaManeja_id = 0 THEN null 
        ELSE LenguaManeja_id 
      END as lenguaManejaId, 
      CASE 
        WHEN LenguaMaterna_id = 0 THEN null 
        ELSE LenguaMaterna_id 
      END as lenguaMaternaId
    ''').eq('Familia_id', familiaId);

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
        // Query to fetch Asp4_EstilosVidaSaludable records based on Familia_id
        final resEstilosVidaSaludable =
            await supabase.from('Asp4_EstilosVidaSaludable').select('''
      Afiliado_id, 
      Familia_id, 
      ActividadFisica_id, 
      Alimentacion_id, 
      ConsumoAlcohol_id, 
      ConsumeCigarrillo, 
      CASE 
        WHEN NumeroCigarrilloDia_id = 0 THEN null 
        ELSE NumeroCigarrilloDia_id 
      END as numeroCigarrilloDiaId, 
      ConsumoSustanciasPsicoactivas
    ''').eq('Familia_id', familiaId);

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
        // Query to fetch Asp5_CuidadoSaludCondRiesgo records based on Familia_id
        final resCuidadoSaludCondRiesgo =
            await supabase.from('Asp5_CuidadoSaludCondRiesgo').select('''
      CuidadoSaludCondRiesgo_id, 
      Afiliado_id, 
      Familia_id, 
      UltimaVezInstSalud_id, 
      CASE 
        WHEN SeguimientoEnfermedad_id = 0 THEN null 
        ELSE SeguimientoEnfermedad_id 
      END as seguimientoEnfermedadId, 
      CondicionNutricional_id, 
      TosFlema_id, 
      ManchasPiel_id, 
      CarnetVacunacion_id, 
      CASE 
        WHEN EsquemaVacunacion_id = 0 THEN null 
        ELSE EsquemaVacunacion_id 
      END as esquemaVacunacionId, 
      CASE 
        WHEN LugarVacunacion_id = 0 THEN null 
        ELSE LugarVacunacion_id 
      END as lugarVacunacionId, 
      UtilizaMetodoPlanificacion_id, 
      CASE 
        WHEN MetodoPlanificacion_id = 0 THEN null 
        ELSE MetodoPlanificacion_id 
      END as metodoPlanificacionId, 
      CASE 
        WHEN ConductaSeguir_id = 0 THEN null 
        ELSE ConductaSeguir_id 
      END as conductaSeguirId
    ''').eq('Familia_id', familiaId);

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
          final resServiciosSolicita = await supabase
              .from('Asp5_CuidadoSaludCondRiesgoServiciosSolicita')
              .select('CuidadoSaludCondRiesgo_id, ServicioSolicitado_id')
              .eq('CuidadoSaludCondRiesgo_id', cuidadoSaludConRiesgoId);

          var ltServiciosSolicita = [];
          for (final servicio in resServiciosSolicita) {
            final resultMapServiciosSolicita = {
              for (var e in servicio.entries) e.key: e.value
            };
            ltServiciosSolicita.add(resultMapServiciosSolicita);
          }

          // NombresEnfermedad
          final resNombresEnfermedad = await supabase
              .from('Asp5_CuidadoSaludCondRiesgoNombresEnfermedad')
              .select('CuidadoSaludCondRiesgo_id, NombreEnfermedad_id')
              .eq('CuidadoSaludCondRiesgo_id', cuidadoSaludConRiesgoId);

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
        // Query to fetch Asp6_DimSocioCulturalPueblosIndigenas records based on Familia_id
        final resSocioCulturalPueblosIndigenas = await supabase
            .from('Asp6_DimSocioCulturalPueblosIndigenas')
            .select('''
      DimSocioCulturalPueblosIndigenas_id, 
      Familia_id, 
      Afiliado_id, 
      ReligionProfesa_id, 
      ConoceUsosCostumbres_id, 
      Cuales_UsosCostumbres, 
      CASE 
        WHEN ParticipaCostumbres_id = 0 THEN null 
        ELSE ParticipaCostumbres_id 
      END as participaCostumbresId, 
      CASE 
        WHEN CostumbrePractica_id = 0 THEN null 
        ELSE CostumbrePractica_id 
      END as costumbrePracticaId, 
      CASE 
        WHEN SancionJusticia_id = 0 THEN null 
        ELSE SancionJusticia_id 
      END as sancionJusticiaId, 
      SitiosSagrados_id, 
      Cuales_SitiosSagrados
    ''').eq('Familia_id', familiaId);

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
          final resEventosCostumbresParticipa = await supabase
              .from('Asp6_DimSocioCulturalEventosCostumbresParticipo')
              .select(
                  'DimSocioCulturalPueblosIndigenas_id, EventoCostumbreParticipo_id')
              .eq('DimSocioCulturalPueblosIndigenas_id',
                  dimSocioCulturalPueblosIndigenasId);

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
        // Query to fetch Asp7_AtencionSalud records based on Familia_id
        final resAtencionSalud =
            await supabase.from('Asp7_AtencionSalud').select('''
      AtencionSalud_id, 
      Afiliado_id, 
      Familia_id, 
      EnfermedadAcude_id, 
      RecibioAtencionMedTradicional_id, 
      EnfermedadTratamiento_id, 
      UtilizaPlantasMed_id, 
      CASE 
        WHEN LugarPlantaMedicinal_id = 0 THEN null 
        ELSE LugarPlantaMedicinal_id 
      END as lugarPlantaMedicinalId
    ''').eq('Familia_id', familiaId);

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
          final resEnfermedadesTradicionales = await supabase
              .from('Asp7_EnfermedadesTradicionales_AtencionSalud')
              .select('AtencionSalud_id, EnfermedadTradicional_id')
              .eq('AtencionSalud_id', atencionSaludId);

          var ltEnfermedadesTradicionales = [];
          for (final enfermedad in resEnfermedadesTradicionales) {
            final resultMapEnfermedadesTradicionales = {
              for (var e in enfermedad.entries) e.key: e.value
            };
            ltEnfermedadesTradicionales.add(resultMapEnfermedadesTradicionales);
          }

          // EnfermedadesTRadicionales
          final resEspecialidadesMedTradAtencionSalud = await supabase
              .from('Asp7_EspecialidadesMedTradAtencionSalud')
              .select('AtencionSalud_id, EspecialidadMedTrad_id')
              .eq('AtencionSalud_id', atencionSaludId);

          var ltEspecialidadesMedTradAtencionSalud = [];
          for (final especialidad in resEspecialidadesMedTradAtencionSalud) {
            final resultMapEspecialidadesMedTradAtencionSalud = {
              for (var e in especialidad.entries) e.key: e.value
            };
            ltEspecialidadesMedTradAtencionSalud
                .add(resultMapEspecialidadesMedTradAtencionSalud);
          }

          // Lugaresatencion
          final resLugaresAtencionSalud = await supabase
              .from('Asp7_LugaresAtencionAtencionSalud')
              .select('AtencionSalud_id, LugarAtencionMedico_id')
              .eq('AtencionSalud_id', atencionSaludId);

          var ltLugaresAtencionSalud = [];
          for (final lugar in resLugaresAtencionSalud) {
            final resultMapLugaresAtencionSalud = {
              for (var e in lugar.entries) e.key: e.value
            };
            ltLugaresAtencionSalud.add(resultMapLugaresAtencionSalud);
          }

          // PlantasMedicinales
          final resPlantasMedicinales = await supabase
              .from('Asp7_PlantasMedicinales_AtencionSalud')
              .select('AtencionSalud_id, PlantaMedicinal_id')
              .eq('AtencionSalud_id', atencionSaludId);

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
