import 'package:ifasoris/data/models/especialidad_med_tradicional_model.dart';
import 'package:ifasoris/data/models/especie_animal_model.dart';
import 'package:ifasoris/data/models/factor_riesgo_vivienda_model.dart';
import 'package:ifasoris/data/models/ficha_model.dart';
import 'package:ifasoris/data/models/fruto_model.dart';
import 'package:ifasoris/data/models/hortaliza_model.dart';
import 'package:ifasoris/data/models/leguminosa_model.dart';
import 'package:ifasoris/data/models/medio_comunicacion_model.dart';
import 'package:ifasoris/data/models/medio_utiliza_ca_model.dart';
import 'package:ifasoris/data/models/medio_utiliza_med_tradicional_model.dart';
import 'package:ifasoris/data/models/nombre_med_tradicional_model.dart';
import 'package:ifasoris/data/models/piso_vivienda_model.dart';
import 'package:ifasoris/data/models/presencia_animal_vivienda_model.dart';
import 'package:ifasoris/data/models/servicio_publico_vivienda_model.dart';
import 'package:ifasoris/data/models/tipo_combustible_vivienda_model.dart';
import 'package:ifasoris/data/models/tipo_sanitario_vivienda_model.dart';
import 'package:ifasoris/data/models/tratamiento_agua_vivienda_model.dart';
import 'package:ifasoris/data/models/tuberculo_platano_model.dart';
import 'package:ifasoris/data/models/verdura_model.dart';
import 'package:ifasoris/domain/entities/atencion_salud_entity.dart';
import 'package:ifasoris/domain/entities/cuidado_salud_cond_riesgo_entity.dart';
import 'package:ifasoris/domain/entities/dimension_sociocultural_pueblos_indigenas_entity.dart';
import 'package:ifasoris/domain/entities/estilo_vida_saludable_entity.dart';
import 'package:ifasoris/domain/entities/grupo_familiar_entity.dart';

import '../../../domain/entities/ficha_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/dificultad_acceso_med_tradicional_model.dart';
import '../../models/techo_vivienda_model.dart';

abstract class FichaLocalDataSource {
  Future<FichaEntity> createFicha(FichaEntity ficha);
  Future<FichaEntity> createFichaCompleta(FichaEntity ficha);
  Future<List<FichaModel>> loadFichas(int familiaId);

  Future<int> deleteFicha(int fichaId);

  Future<List<FichaModel>> loadFichasDiligenciadas(int familiaId);
}

class FichaLocalDataSourceImpl implements FichaLocalDataSource {
  @override
  Future<FichaEntity> createFicha(FichaEntity ficha) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('Ficha', ficha.toJsonLocal());

    ficha.fichaId = res;

    return ficha;
  }

  @override
  Future<List<FichaModel>> loadFichas(int familiaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.rawQuery('''
      SELECT Ficha.Ficha_id, Ficha.FechaCreacion,Ficha.NumFicha,Ficha.UserName_Creacion,Ficha.UserName_Actualizacion, Ficha.UltimaActualizacion FROM Familia 
      LEFT JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
      WHERE Familia.Familia_id = $familiaId
      ''');
    final result =
        List<FichaModel>.from(res.map((m) => FichaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> deleteFicha(int fichaId) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.delete('Ficha', where: 'Ficha_id = ?', whereArgs: [fichaId]);

    return res;
  }

  @override
  Future<List<FichaModel>> loadFichasDiligenciadas(int familiaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.rawQuery('''
     SELECT Ficha.Ficha_id, Ficha.FechaCreacion,Ficha.NumFicha,Ficha.UserName_Creacion,Ficha.UserName_Actualizacion, Ficha.UltimaActualizacion FROM Ficha 
      LEFT JOIN Familia ON Familia.Ficha_id = Ficha.Ficha_id
      LEFT JOIN Asp1_Ubicacion ON Asp1_Ubicacion.Familia_id = Familia.Familia_id
      LEFT JOIN Asp2_DatosVivienda ON Asp2_DatosVivienda.Familia_id = Familia.Familia_id
      LEFT JOIN Asp3_GrupoFamiliar ON Asp3_GrupoFamiliar.Familia_id = Familia.Familia_id
      LEFT JOIN Asp4_EstilosVidaSaludable ON Asp4_EstilosVidaSaludable.Familia_id = Familia.Familia_id
      LEFT JOIN Asp5_CuidadoSaludCondRiesgo ON Asp5_CuidadoSaludCondRiesgo.Familia_id = Familia.Familia_id
      LEFT JOIN Asp6_DimSocioCulturalPueblosIndigenas ON Asp6_DimSocioCulturalPueblosIndigenas.Familia_id = Familia.Familia_id
      LEFT JOIN Asp7_AtencionSalud ON Asp7_AtencionSalud.Familia_id = Familia.Familia_id
      WHERE Ficha.Ficha_id = $familiaId
      ''');
    final result =
        List<FichaModel>.from(res.map((m) => FichaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<FichaEntity> createFichaCompleta(FichaEntity ficha) async {
    final db = await ConnectionSQLiteService.db;

    // Ficha
    ficha.fichaIdRemote = ficha.fichaId;
    ficha.fichaId = null;

    // Familia
    final familia = ficha.familia;
    familia!.familiaId = null;

    // // Vivienda
    // final vivienda = ficha.familia!.vivienda;
    // final lstTechos = vivienda!.lstTecho;
    // final lstServPublicos = vivienda.lstServPublico;
    // final lstTmtoAgua = vivienda.lstTmtoAgua;
    // final lstFactorRiesgo = vivienda.lstFactorRiesgo;
    // final lstTipoSanitario = vivienda.lstTipoSanitario;
    // final lstTipoCombustible = vivienda.lstTipoCombustible;
    // final lstPresenciaAnimal = vivienda.lstPresenciaAnimal;
    // final lstPiso = vivienda.lstPiso;

    // // Ubicacion
    // final ubicacion = ficha.familia!.ubicacion;
    // final lstDificultadAccesoMedTradicional =
    //     ubicacion!.lstDificultadAccesoMedTradicional;
    // final lstEspMedTradicional = ubicacion.lstEspMedTradicional;
    // final lstAnimalCria = ubicacion.lstAnimalCria;
    // final lstFrutos = ubicacion.lstFrutos;
    // final lstHortalizas = ubicacion.lstHortalizas;
    // final lstLeguminosas = ubicacion.lstLeguminosas;
    // final lstMediosComunica = ubicacion.lstMediosComunica;
    // final lstMediosMedTradicional = ubicacion.lstMediosMedTradicional;
    // final lstNombreMedTradicional = ubicacion.lstNombreMedTradicional;
    // final lstTuberculos = ubicacion.lstTuberculos;
    // final lstVerduras = ubicacion.lstVerduras;
    // final lstMediosUtilizaCA = ubicacion.lstMediosUtilizaCA;

    // GrupoFamiliar
    final grupoFamiliar = ficha.familia!.grupoFamiliar;

    // // EstilosVidaSaludable
    // final estilosVidaSaludable = ficha.familia!.estiloVidaSaludable;

    // // CuidadoSaludCondRiesgo
    // final cuidadoSaludCondRiesgo = ficha.familia!.cuidadoSaludCondRiesgo;

    // // SocioCulturalPueblosIndigenas
    // final socioCulturalPueblosIndigenas =
    //     ficha.familia!.socioCulturalPueblosIndigenas;

    // // AtencionSalud
    // final atencionSalud = ficha.familia!.atencionSalud;

    await db.transaction((txn) async {
      // Ficha
      final newFichaId = await txn.insert('Ficha', ficha.toJsonLocal());

      // Familia
      familia.fichaId = newFichaId;
      final newFamilia = await txn.insert('Familia', familia.toJson());

      // // Vivienda
      // vivienda.familiaId = newFamilia;
      // vivienda.datoViviendaId = null;
      // final newVivienda =
      //     await txn.insert('Asp2_DatosVivienda', vivienda.toJson());
      // // Techos
      // List<LstTecho> lstTechosDat = lstTechos!.map((techo) {
      //   return LstTecho(
      //     viviendaId: newVivienda,
      //     techoViviendaId: techo.techoViviendaId,
      //     otroTipoTecho: techo.otroTipoTecho,
      //   );
      // }).toList();
      // for (var e in lstTechosDat) {
      //   await txn.insert('Asp2_DatosViviendaTechos', e.toJson());
      // }
      // // LstServPublico
      // List<LstServPublico> lstServPublicosDat =
      //     lstServPublicos!.map((servPublico) {
      //   return LstServPublico(
      //     viviendaId: newVivienda,
      //     servicioPublicoViviendaId: servPublico.servicioPublicoViviendaId,
      //   );
      // }).toList();
      // for (var e in lstServPublicosDat) {
      //   await txn.insert('Asp2_DatosViviendaServiciosPublicos', e.toJson());
      // }
      // // lstTmtoAgua
      // List<LstTmtoAgua> lstTmtoAguaDat = lstTmtoAgua!.map((tmtoAgua) {
      //   return LstTmtoAgua(
      //       viviendaId: newVivienda,
      //       tratamientoAguaViviendaId: tmtoAgua.tratamientoAguaViviendaId,
      //       otroTratamientoAgua: tmtoAgua.otroTratamientoAgua);
      // }).toList();
      // for (var e in lstTmtoAguaDat) {
      //   await txn.insert('Asp2_DatosViviendaTratamientosAgua', e.toJson());
      // }
      // // lstFactorRiesgo
      // List<LstFactorRiesgo> lstFactorRiesgoDat =
      //     lstFactorRiesgo!.map((factorRiesgo) {
      //   return LstFactorRiesgo(
      //       viviendaId: newVivienda,
      //       factorRiesgoViviendaId: factorRiesgo.factorRiesgoViviendaId,
      //       otroFactorRiesgo: factorRiesgo.otroFactorRiesgo);
      // }).toList();
      // for (var e in lstFactorRiesgoDat) {
      //   await txn.insert('Asp2_DatosViviendaFactoresRiesgo', e.toJson());
      // }
      // // lstTipoSanitario
      // List<LstTipoSanitario> lstTipoSanitarioDat =
      //     lstTipoSanitario!.map((tipoSanitario) {
      //   return LstTipoSanitario(
      //       viviendaId: newVivienda,
      //       tipoSanitarioViviendaId: tipoSanitario.tipoSanitarioViviendaId,
      //       otroTipoSanitario: tipoSanitario.otroTipoSanitario);
      // }).toList();
      // for (var e in lstTipoSanitarioDat) {
      //   await txn.insert('Asp2_DatosViviendaTiposSanitario', e.toJson());
      // }
      // // lstTipoCombustible
      // List<LstTipoCombustible> lstTipoCombustibleDat =
      //     lstTipoCombustible!.map((tipoCombustible) {
      //   return LstTipoCombustible(
      //       viviendaId: newVivienda,
      //       tipoCombustibleViviendaId:
      //           tipoCombustible.tipoCombustibleViviendaId,
      //       otroTipoCombustible: tipoCombustible.otroTipoCombustible);
      // }).toList();
      // for (var e in lstTipoCombustibleDat) {
      //   await txn.insert('Asp2_DatosViviendaTiposCombustible', e.toJson());
      // }
      // // lstPresenciaAnimal
      // List<LstPresenciaAnimal> lstPresenciaAnimalDat =
      //     lstPresenciaAnimal!.map((presenciaAnimal) {
      //   return LstPresenciaAnimal(
      //       viviendaId: newVivienda,
      //       presenciaAnimalViviendaId:
      //           presenciaAnimal.presenciaAnimalViviendaId,
      //       otroPresenciaAnimal: presenciaAnimal.otroPresenciaAnimal);
      // }).toList();
      // for (var e in lstPresenciaAnimalDat) {
      //   await txn.insert('Asp2_DatosViviendaPresenciaAnimales', e.toJson());
      // }
      // // lstPiso
      // List<LstPiso> lstPisoDat = lstPiso!.map((piso) {
      //   return LstPiso(
      //       viviendaId: newVivienda,
      //       pisoViviendaId: piso.pisoViviendaId,
      //       otroTipoPiso: piso.otroTipoPiso);
      // }).toList();
      // for (var e in lstPisoDat) {
      //   await txn.insert('Asp2_DatosViviendaPisos', e.toJson());
      // }

      // // Ubicacion
      // ubicacion.familiaId = newFamilia;
      // ubicacion.ubicacionId = null;
      // final newUbicacion =
      //     await txn.insert('Asp1_Ubicacion', ubicacion.toJson());
      // // lstDificultadAccesoMedTradicional
      // List<LstDificultadAccesoMedTradicional>
      //     lstDificultadAccesoMedTradicionalDat =
      //     lstDificultadAccesoMedTradicional!
      //         .map((dificultadAccesoMedTradicional) {
      //   return LstDificultadAccesoMedTradicional(
      //     ubicacionId: newUbicacion,
      //     dificultadAccesoMedTradId:
      //         dificultadAccesoMedTradicional.dificultadAccesoMedTradId,
      //   );
      // }).toList();
      // for (var e in lstDificultadAccesoMedTradicionalDat) {
      //   await txn.insert('Asp1_UbicacionAccesoMedTradicional', e.toJson());
      // }
      // // lstEspMedTradicional
      // List<LstEspMedTradicional> lstEspMedTradicionalDat =
      //     lstEspMedTradicional!.map((espMedTradicional) {
      //   return LstEspMedTradicional(
      //     ubicacionId: newUbicacion,
      //     especialidadMedTradId: espMedTradicional.especialidadMedTradId,
      //   );
      // }).toList();
      // for (var e in lstEspMedTradicionalDat) {
      //   await txn.insert(
      //       'Asp1_UbicacionEspecialidadMedTradicional', e.toJson());
      // }
      // // lstAnimalCria
      // List<LstAnimalCria> lstAnimalCriaDat = lstAnimalCria!.map((animalCria) {
      //   return LstAnimalCria(
      //     ubicacionId: newUbicacion,
      //     especieAnimalCriaId: animalCria.especieAnimalCriaId,
      //   );
      // }).toList();
      // for (var e in lstAnimalCriaDat) {
      //   await txn.insert('Asp1_UbicacionEspecieAnimalesCria', e.toJson());
      // }
      // // lstFrutos
      // List<LstFruto> lstFrutosDat = lstFrutos!.map((fruto) {
      //   return LstFruto(
      //     ubicacionId: newUbicacion,
      //     frutoId: fruto.frutoId,
      //   );
      // }).toList();
      // for (var e in lstFrutosDat) {
      //   await txn.insert('Asp1_UbicacionFrutos', e.toJson());
      // }
      // // lstHortalizas
      // List<LstHortaliza> lstHortalizasDat = lstHortalizas!.map((hortaliza) {
      //   return LstHortaliza(
      //     ubicacionId: newUbicacion,
      //     hortalizaId: hortaliza.hortalizaId,
      //   );
      // }).toList();
      // for (var e in lstHortalizasDat) {
      //   await txn.insert('Asp1_UbicacionHortalizas', e.toJson());
      // }
      // // lstLeguminosas
      // List<LstLeguminosa> lstLeguminosasDat = lstLeguminosas!.map((leguminosa) {
      //   return LstLeguminosa(
      //     ubicacionId: newUbicacion,
      //     leguminosaId: leguminosa.leguminosaId,
      //   );
      // }).toList();
      // for (var e in lstLeguminosasDat) {
      //   await txn.insert('Asp1_UbicacionLeguminosas', e.toJson());
      // }
      // // lstMediosComunica
      // List<LstMediosComunica> lstMediosComunicaDat =
      //     lstMediosComunica!.map((medioComunica) {
      //   return LstMediosComunica(
      //     ubicacionId: newUbicacion,
      //     medioComunicacionId: medioComunica.medioComunicacionId,
      //   );
      // }).toList();
      // for (var e in lstMediosComunicaDat) {
      //   await txn.insert('Asp1_UbicacionMediosComunicacion', e.toJson());
      // }
      // // lstMediosMedTradicional
      // List<LstMediosMedTradicional> lstMediosMedTradicionalDat =
      //     lstMediosMedTradicional!.map((medioMedicinaTradicional) {
      //   return LstMediosMedTradicional(
      //     ubicacionId: newUbicacion,
      //     medioUtilizaMedTradId: medioMedicinaTradicional.medioUtilizaMedTradId,
      //   );
      // }).toList();
      // for (var e in lstMediosMedTradicionalDat) {
      //   await txn.insert('Asp1_UbicacionMediosMedTradicional', e.toJson());
      // }
      // // lstNombreMedTradicional
      // List<LstNombreMedTradicional> lstNombreMedTradicionalDat =
      //     lstNombreMedTradicional!.map((nombreMedTradicional) {
      //   return LstNombreMedTradicional(
      //     ubicacionId: newUbicacion,
      //     nombreMedTradicional: nombreMedTradicional.nombreMedTradicional,
      //   );
      // }).toList();
      // for (var e in lstNombreMedTradicionalDat) {
      //   await txn.insert('Asp1_UbicacionNombresMedTradicional', e.toJson());
      // }
      // // lstTuberculos
      // List<LstTuberculo> lstTuberculosDat = lstTuberculos!.map((tuberculo) {
      //   return LstTuberculo(
      //     ubicacionId: newUbicacion,
      //     tuberculoPlatanoId: tuberculo.tuberculoPlatanoId,
      //   );
      // }).toList();
      // for (var e in lstTuberculosDat) {
      //   await txn.insert('Asp1_UbicacionTuberculosPlatanos', e.toJson());
      // }
      // // lstVerduras
      // List<LstVerdura> lstVerdurasDat = lstVerduras!.map((verdura) {
      //   return LstVerdura(
      //     ubicacionId: newUbicacion,
      //     verduraId: verdura.verduraId,
      //   );
      // }).toList();
      // for (var e in lstVerdurasDat) {
      //   await txn.insert('Asp1_UbicacionVerduras', e.toJson());
      // }
      // // lstMediosUtilizaCA
      // List<LstMediosUtilizaCA> lstMediosUtilizaCADat =
      //     lstMediosUtilizaCA!.map((medioUtilizaCA) {
      //   return LstMediosUtilizaCA(
      //     ubicacionId: newUbicacion,
      //     medioUtilizaId: medioUtilizaCA.medioUtilizaId,
      //   );
      // }).toList();
      // for (var e in lstMediosUtilizaCADat) {
      //   await txn.insert('Asp1_UbicacionMediosCentroAtencion', e.toJson());
      // }

      // grupoFamiliar
      List<GrupoFamiliarEntity> grupoFamiliarDat =
          grupoFamiliar!.map((integrante) {
        return GrupoFamiliarEntity(
          familiaId: newFamilia,
          afiliadoId: integrante.afiliadoId,
          tipoDocumentoId: integrante.tipoDocumentoId,
          documento: integrante.documento,
          generoId: integrante.generoId,
          fechaNacimiento: integrante.fechaNacimiento,
          edad: integrante.edad,
          nombre1: integrante.nombre1,
          nombre2: integrante.nombre2,
          apellido1: integrante.apellido1,
          apellido2: integrante.apellido2,
          tipoDocAfiliado: integrante.tipoDocAfiliado,
          codGeneroAfiliado: integrante.codGeneroAfiliado,
          codRegimenAfiliado: integrante.codRegimenAfiliado,
          tipoRegimenId: integrante.tipoRegimenId,
          parentescoId: integrante.parentescoId,
          etniaId: integrante.etniaId,
          cursoVidaId: integrante.cursoVidaId,
          nivelEducativoId: integrante.nivelEducativoId,
          ocupacionId: integrante.ocupacionId,
          grupoRiesgoId: integrante.grupoRiesgoId,
          origenEtnico5602Id: integrante.origenEtnico5602Id,
          puebloIndigenaId: integrante.puebloIndigenaId,
          lenguaManejaId: integrante.lenguaManejaId,
          lenguaMaternaId: integrante.lenguaMaternaId,
        );
      }).toList();
      for (var e in grupoFamiliarDat) {
        await txn.insert('Asp3_GrupoFamiliar', e.toJson());
      }

      // // estilosVidaSaludable
      // List<EstiloVidaSaludableEntity> estilosVidaSaludableDat =
      //     estilosVidaSaludable!.map((integrante) {
      //   return EstiloVidaSaludableEntity(
      //     familiaId: newFamilia,
      //     afiliadoId: integrante.afiliadoId,
      //     actividadFisicaId: integrante.actividadFisicaId,
      //     alimentacionId: integrante.alimentacionId,
      //     consumoAlcoholId: integrante.consumoAlcoholId,
      //     consumeCigarrillo: integrante.consumeCigarrillo,
      //     numeroCigarrilloDiaId: integrante.numeroCigarrilloDiaId,
      //     consumoSustanciasPsicoactivas:
      //         integrante.consumoSustanciasPsicoactivas,
      //   );
      // }).toList();
      // for (var e in estilosVidaSaludableDat) {
      //   await txn.insert('Asp4_EstilosVidaSaludable', e.toJson());
      // }

      // // cuidadoSaludCodRiesgo
      // List<CuidadoSaludCondRiesgoEntity> cuidadoSaludCondRiesgoDat =
      //     cuidadoSaludCondRiesgo!.map((cuidado) {
      //   return CuidadoSaludCondRiesgoEntity(
      //       familiaId: newFamilia,
      //       afiliadoId: cuidado.afiliadoId,
      //       ultimaVezInstSaludId: cuidado.ultimaVezInstSaludId,
      //       seguimientoEnfermedadId: cuidado.seguimientoEnfermedadId,
      //       condicionNutricionalId: cuidado.condicionNutricionalId,
      //       tosFlemaId: cuidado.tosFlemaId,
      //       manchasPielId: cuidado.manchasPielId,
      //       carnetVacunacionId: cuidado.carnetVacunacionId,
      //       esquemaVacunacionId: cuidado.esquemaVacunacionId,
      //       lugarVacunacionId: cuidado.lugarVacunacionId,
      //       utilizaMetodoPlanificacionId: cuidado.utilizaMetodoPlanificacionId,
      //       metodoPlanificacionId: cuidado.metodoPlanificacionId,
      //       conductaSeguirId: cuidado.conductaSeguirId,
      //       lstServiciosSolicitados: cuidado.lstServiciosSolicitados,
      //       lstNombresEnfermedades: cuidado.lstNombresEnfermedades);
      // }).toList();
      // for (var e in cuidadoSaludCondRiesgoDat) {
      //   final newCuidadoSaludCondRiesgoId =
      //       await txn.insert('Asp5_CuidadoSaludCondRiesgo', e.toJson());
      //   for (var d in e.lstServiciosSolicitados!) {
      //     d.cuidadoSaludCondRiesgoId = newCuidadoSaludCondRiesgoId;
      //     await txn.insert(
      //         'Asp5_CuidadoSaludCondRiesgoServiciosSolicita', d.toJson());
      //   }
      //   for (var d in e.lstNombresEnfermedades!) {
      //     d.cuidadoSaludCondRiesgoId = newCuidadoSaludCondRiesgoId;
      //     await txn.insert(
      //         'Asp5_CuidadoSaludCondRiesgoNombresEnfermedad', d.toJson());
      //   }
      // }

      // // socioCulturalPueblosIndigenas
      // List<DimensionSocioCulturalPueblosIndigenasEntity>
      //     socioCulturalPueblosIndigenasDat =
      //     socioCulturalPueblosIndigenas!.map((pueblo) {
      //   return DimensionSocioCulturalPueblosIndigenasEntity(
      //     familiaId: newFamilia,
      //     afiliadoId: pueblo.afiliadoId,
      //     religionProfesaId: pueblo.religionProfesaId,
      //     conoceUsosCostumbresId: pueblo.conoceUsosCostumbresId,
      //     cualesUsosCostumbres: pueblo.cualesUsosCostumbres,
      //     participaCostumbresId: pueblo.participaCostumbresId,
      //     costumbrePracticaId: pueblo.costumbrePracticaId,
      //     sancionJusticiaId: pueblo.sancionJusticiaId,
      //     sitiosSagradosId: pueblo.sitiosSagradosId,
      //     cualesSitiosSagrados: pueblo.cualesSitiosSagrados,
      //     lstEventoCostumbreParticipa: pueblo.lstEventoCostumbreParticipa,
      //   );
      // }).toList();
      // for (var e in socioCulturalPueblosIndigenasDat) {
      //   final newSocioCulturalPueblosIndigenasId = await txn.insert(
      //       'Asp6_DimSocioCulturalPueblosIndigenas', e.toJson());
      //   for (var d in e.lstEventoCostumbreParticipa!) {
      //     d.dimSocioCulturalPueblosIndigenasId =
      //         newSocioCulturalPueblosIndigenasId;
      //     await txn.insert(
      //         'Asp6_DimSocioCulturalEventosCostumbresParticipo', d.toJson());
      //   }
      // }

      // // atencionSalud
      // List<AtencionSaludEntity> atencionSaludDat =
      //     atencionSalud!.map((atencion) {
      //   return AtencionSaludEntity(
      //     familiaId: newFamilia,
      //     afiliadoId: atencion.afiliadoId,
      //     enfermedadAcudeId: atencion.enfermedadAcudeId,
      //     recibioAtencionMedTradicionalId:
      //         atencion.recibioAtencionMedTradicionalId,
      //     enfermedadTratamientoId: atencion.enfermedadTratamientoId,
      //     utilizaPlantasMedId: atencion.utilizaPlantasMedId,
      //     lugarPlantaMedicinalId: atencion.lugarPlantaMedicinalId,
      //     lstEnfermedadesTradicionales: atencion.lstEnfermedadesTradicionales,
      //     lstEspecialidadesMedTradicional:
      //         atencion.lstEspecialidadesMedTradicional,
      //     lstLugaresAtencionMedico: atencion.lstLugaresAtencionMedico,
      //     lstPlantasMedicinales: atencion.lstPlantasMedicinales,
      //   );
      // }).toList();
      // for (var e in atencionSaludDat) {
      //   final newAtencionSaludId =
      //       await txn.insert('Asp7_AtencionSalud', e.toJson());
      //   for (var d in e.lstEnfermedadesTradicionales!) {
      //     d.atencionSaludId = newAtencionSaludId;
      //     await txn.insert(
      //         'Asp7_EnfermedadesTradicionales_AtencionSalud', d.toJson());
      //   }
      //   for (var d in e.lstEspecialidadesMedTradicional!) {
      //     // d.atencionId = newAtencionSaludId;
      //     final espAtencion = {
      //       "AtencionSalud_id": newAtencionSaludId,
      //       "EspecialidadMedTrad_id": d.especialidadMedTradId
      //     };
      //     await txn.insert(
      //         'Asp7_EspecialidadesMedTradAtencionSalud', espAtencion);
      //   }
      //   for (var d in e.lstLugaresAtencionMedico!) {
      //     d.atencionSaludId = newAtencionSaludId;
      //     await txn.insert('Asp7_LugaresAtencionAtencionSalud', d.toJson());
      //   }
      //   for (var d in e.lstPlantasMedicinales!) {
      //     d.atencionSaludId = newAtencionSaludId;
      //     await txn.insert('Asp7_PlantasMedicinales_AtencionSalud', d.toJson());
      //   }
      // }
    });

    return ficha;
  }
}
