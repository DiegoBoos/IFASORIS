import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/ficha_model.dart';

abstract class FichaRemoteDataSource {
  Future<String> createFicha();
}

class FichaRemoteDataSourceImpl implements FichaRemoteDataSource {
  final http.Client client;

  FichaRemoteDataSourceImpl({required this.client});

  @override
  Future<String> createFicha() async {
    try {
      final db = await ConnectionSQLiteService.db;
      final res = await db.rawQuery('''
    SELECT
      F.Ficha_id,
      F.FechaCreacion,
      F.NumFicha,
      F.UserName,
      F.UltimaActualizacion,
	    Fa.Familia_id,
      Fa.Ficha_id,
      Fa.ApellidosFlia,
      Fa.Afiliado_id,
	    V.Familia_id,
	    V.TipoVivienda_id,
	    V.TenenciaVivienda_id,
	    V.VentilacionVivienda_id,
	    V.PisoVivienda_id,
	    V.OtroTipoPiso,
	    TE.TechoVivienda_id,
	    TE.OtroTipoTecho,
	    SP.ServicioPublicoVivienda_id,
	    TA.TratamientoAguaVivienda_id,
	    FR.FactorRiesgoVivienda_id,
	    TS.TipoSanitarioVivienda_id,
	    TS.OtroTipoSanitario,
	    TC.TipoCombustibleVivienda_id,
	    TC.OtroTipoCombustible,
	    PA.PresenciaAnimalVivienda_id,
	    PA.OtroPresenciaAnimal,
	    U.Familia_id,
	    U.NombreRecibeVisita,
	    U.TipoDoc_RecibeVisita,
	    U.Documento_RecibeVisita,
	    U.PerteneceResguardo,
	    U.ViaAcceso_id,
	    U.Resguardo_id,
	    U.AutoridadIndigena_id,
	    U.EstadoVia_id,
	    U.TiempoTarda_id,
	    U.MedioUtiliza_id,
	    U.CostoDesplazamiento_id,
	    U.ExisteMedTradicionalComunidad,
	    U.TiempoTardaMedTrad_id,
	    U.CostoDesplazamiento_MedTradicional,
	    U.PoseeChagra,
	    U.ProduccionMinera,
	    U.TipoCalendario_id,
	    AMT.DificultadAccesoMedTrad_id,
	    UC.Cereal_id,
	    DA.DificultaAcceso_id,
	    EMT.EspecialidadMedTrad_id,
	    EAC.EspecieAnimalCria_id,
	    FRU.Fruto_id,
	    H.Hortaliza_id,
	    L.Leguminosa_id,
	    MC.MedioComunicacion_id,
	    MMT.MedioUtilizaMedTrad_id,
	    NMT.NombreMedTradicional,
	    TP.TuberculoPlatano_id,
	    VE.Verdura_id,
	    GF.Familia_id,
      GF.Afiliado_id,
      GF.TipoDocumento_id,
      GF.Documento,
      GF.Genero_id,
      GF.FechaNacimiento,
      GF.Edad,
      GF.TipoRegimen_id,
      GF.Parentesco_id,
      GF.Etnia_id,
      GF.CursoVida_id,
      GF.NivelEducativo_id,
      GF.Ocupacion_id,
      GF.GrupoRiesgo_id,
      GF.OrigenEtnico5602_id,
      GF.PuebloIndigena_id,
      GF.LenguaManeja_id,
      GF.LenguaMaterna_id,
      EVS.Afiliado_id,
      EVS.Familia_id,
      EVS.ActividadFisica_id,
      EVS.Alimentacion_id,
      EVS.ConsumoAlcohol_id,
      EVS.ConsumeCigarrillo,
      EVS.NumeroCigarrilloDia_id,
      EVS.ConsumoSustanciasPsicoactivas,
	    CSCR.CuidadoSaludCondRiesgo_id,
      CSCR.Afiliado_id,
      CSCR.Familia_id,
      CSCR.UltimaVezInstSalud_id,
      CSCR.SeguimientoEnfermedad_id,
      CSCR.CondicionNutricional_id,
      CSCR.TosFlema_id,
      CSCR.ManchasPiel_id,
      CSCR.CarnetVacunacion_id,
      CSCR.EsquemaVacunacion_id,
      CSCR.LugarVacunacion_id,
      CSCR.UtilizaMetodoPlanificacion_id,
      CSCR.MetodoPlanificacion_id,
      CSCR.ConductaSeguir_id,
	    CSCRS.CuidadoSaludCondRiesgo_id,
	    CSCRS.ServicioSolicitado_id,
	    CSCRNE.CuidadoSaludCondRiesgo_id,
	    CSCRNE.NombreEnfermedad_id,
	    SCPI.Familia_id,
      SCPI.Afiliado_id,
      SCPI.ReligionProfesa_id,
      SCPI.ConoceUsosCostumbres_id,
      SCPI.Cuales_UsosCostumbres,
      SCPI.ParticipaCostumbres_id,
      SCPI.CostumbrePractica_id,
      SCPI.SancionJusticia_id,
      SCPI.SitiosSagrados_id,
      SCPI.Cuales_SitiosSagrados,
	    SCECP.EventoCostumbreParticipo_id,
	    ASA.Afiliado_id,
      ASA.Familia_id,
      ASA.EnfermedadAcude_id,
      ASA.RecibioAtencionMedTradicional_id,
      ASA.EnfermedadTratamiento_id,
      ASA.UtilizaPlantasMed_id,
      ASA.LugarPlantaMedicinal_id,
	    ET.EnfermedadTradicional_id,
	    EMTAS.EspecialidadMedTrad_id,
	    LA.LugarAtencionMedico_id,
	    PM.PlantaMedicinal_id
    FROM Ficha AS F
    JOIN Familia AS Fa ON F.Ficha_id = Fa.Ficha_id
    JOIN Asp2_DatosVivienda AS V ON Fa.Familia_id = V.Familia_id
    JOIN Asp2_DatosViviendaTechos AS Te ON V.DatoVivienda_id = Te.DatoVivienda_id
    JOIN Asp2_DatosViviendaServiciosPublicos AS SP ON V.DatoVivienda_id = SP.DatoVivienda_id
    JOIN Asp2_DatosViviendaTratamientosAgua AS TA ON V.DatoVivienda_id = TA.DatoVivienda_id
    JOIN Asp2_DatosViviendaFactoresRiesgo AS FR ON V.DatoVivienda_id = FR.DatoVivienda_id
    JOIN Asp2_DatosViviendaTiposSanitario AS TS ON V.DatoVivienda_id = TS.DatoVivienda_id
    JOIN Asp2_DatosViviendaTiposCombustible AS TC ON V.DatoVivienda_id = TC.DatoVivienda_id
    JOIN Asp2_DatosViviendaPresenciaAnimales AS PA ON V.DatoVivienda_id = PA.DatoVivienda_id
    JOIN Asp1_Ubicacion AS U ON Fa.Familia_id = U.Familia_id
    JOIN Asp1_UbicacionAccesoMedTradicional AS AMT ON U.Ubicacion_id = AMT.Ubicacion_id
    JOIN Asp1_UbicacionCereales AS UC ON U.Ubicacion_id = UC.Ubicacion_id
    JOIN Asp1_UbicacionDificultadAcceso AS DA ON U.Ubicacion_id = DA.Ubicacion_id
    JOIN Asp1_UbicacionEspecialidadMedTradicional AS EMT ON U.Ubicacion_id = EMT.Ubicacion_id
    JOIN Asp1_UbicacionEspecieAnimalesCria AS EAC ON U.Ubicacion_id = EAC.Ubicacion_id
    JOIN Asp1_UbicacionFrutos AS FRU ON U.Ubicacion_id = FRU.Ubicacion_id
    JOIN Asp1_UbicacionHortalizas AS H ON U.Ubicacion_id = H.Ubicacion_id
    JOIN Asp1_UbicacionLeguminosas AS L ON U.Ubicacion_id = L.Ubicacion_id
    JOIN Asp1_UbicacionMediosComunicacion AS MC ON U.Ubicacion_id = MC.Ubicacion_id
    JOIN Asp1_UbicacionMediosMedTradicional AS MMT ON U.Ubicacion_id = MMT.Ubicacion_id
    JOIN Asp1_UbicacionNombresMedTradicional AS NMT ON U.Ubicacion_id = NMT.Ubicacion_id
    JOIN Asp1_UbicacionTuberculosPlatanos AS TP ON U.Ubicacion_id = TP.Ubicacion_id
    JOIN Asp1_UbicacionVerduras AS VE ON U.Ubicacion_id = VE.Ubicacion_id
    JOIN Asp3_GrupoFamiliar AS GF ON Fa.Familia_id = GF.Familia_id
    JOIN Asp4_EstilosVidaSaludable AS EVS ON Fa.Familia_id = EVS.Familia_id
    JOIN Asp5_CuidadoSaludCondRiesgo AS CSCR ON Fa.Familia_id = CSCR.Familia_id
    JOIN Asp5_CuidadoSaludCondRiesgoServiciosSolicita AS CSCRS ON CSCR.CuidadoSaludCondRiesgo_id = CSCRS.CuidadoSaludCondRiesgo_id
    JOIN Asp5_CuidadoSaludCondRiesgoNombresEnfermedad AS CSCRNE ON CSCR.CuidadoSaludCondRiesgo_id = CSCRNE.CuidadoSaludCondRiesgo_id
    JOIN Asp6_DimSocioCulturalPueblosIndigenas AS SCPI ON Fa.Familia_id = SCPI.Familia_id
    JOIN Asp6_DimSocioCulturalEventosCostumbresParticipo AS SCECP ON SCPI.DimSocioCulturalPueblosIndigenas_id = SCECP.DimSocioCulturalPueblosIndigenas_id
    JOIN Asp7_AtencionSalud AS ASA ON Fa.Familia_id = ASA.Familia_id
    JOIN Asp7_EnfermedadesTradicionales_AtencionSalud AS ET ON ASA.AtencionSalud_id = ET.AtencionSalud_id
    JOIN Asp7_EspecialidadesMedTradAtencionSalud AS EMTAS ON ASA.AtencionSalud_id = EMTAS.AtencionSalud_id
    JOIN Asp7_LugaresAtencionAtencionSalud AS LA ON ASA.AtencionSalud_id = LA.AtencionSalud_id
    JOIN Asp7_PlantasMedicinales_AtencionSalud AS PM ON ASA.AtencionSalud_id = PM.AtencionSalud_id''');

      if (res.isEmpty) {
        throw const ServerFailure(
            ['Error al subir ficha, datos insuficientes']);
      }

      final resultMap = {for (var e in res[0].entries) e.key: e.value};
      final result = FichaModel.fromJson(resultMap);

      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/registrarficha');

      final resp = await client.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: result.toJsonRemote());

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        return decodedResp['Description'];
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
