import 'atencion_salud_entity.dart';
import 'cuidado_salud_cond_riesgo_entity.dart';
import 'dim_ubicacion_entity.dart';
import 'dim_vivienda_entity.dart';
import 'dimension_sociocultural_pueblos_indigenas_entity.dart';
import 'estilo_vida_saludable_entity.dart';
import 'familia_entity.dart';
import 'grupo_familiar_entity.dart';

class FichaEntity {
  int? fichaId;
  DateTime? fechaCreacion;
  String? numFicha;
  String? userNameCreacion;
  String? userNameActualizacion;
  DateTime? ultimaActualizacion;
  FamiliaEntity? familia;
  int? fichaIdRemote;
  // List<FamiliaEntity>? familia;
  // List<DimViviendaEntity>? vivienda;
  // List<DimUbicacionEntity>? ubicacion;
  // List<GrupoFamiliarEntity>? grupoFamiliar;
  // List<EstiloVidaSaludableEntity>? estilosVidaSaludable;
  // List<CuidadoSaludCondRiesgoEntity>? cuidadoSaludCondRiesgo;
  // List<DimensionSocioCulturalPueblosIndigenasEntity>?
  //     socioCulturalPueblosIndigenas;
  // List<AtencionSaludEntity>? atencionSalud;

  FichaEntity({
    this.fichaId,
    this.fechaCreacion,
    this.numFicha,
    this.userNameCreacion,
    this.userNameActualizacion,
    this.ultimaActualizacion,
    this.familia,
    this.fichaIdRemote,
    // this.vivienda,
    // this.ubicacion,
    // this.grupoFamiliar,
    // this.estilosVidaSaludable,
    // this.cuidadoSaludCondRiesgo,
    // this.socioCulturalPueblosIndigenas,
    // this.atencionSalud,
  });

  Map<String, dynamic> toJsonLocalCompleta() => {
        "Ficha_id_remote": fichaId,
        "FechaCreacion": fechaCreacion?.toIso8601String(),
        "NumFicha": numFicha,
        "UserName_Creacion": userNameCreacion,
        "UserName_Actualizacion": userNameActualizacion,
        "UltimaActualizacion": ultimaActualizacion?.toIso8601String(),
        "familia": familia,
      };

  Map<String, dynamic> toJsonLocal() => {
        "Ficha_id": fichaId,
        "FechaCreacion": fechaCreacion?.toIso8601String(),
        "NumFicha": numFicha,
        "UserName_Creacion": userNameCreacion,
        "UserName_Actualizacion": userNameActualizacion,
        "UltimaActualizacion": ultimaActualizacion?.toIso8601String(),
        "Ficha_id_remote": fichaIdRemote,
      };

  Map<String, dynamic> toJsonRemote() => {
        "Ficha_id": fichaId,
        "FechaCreacion": fechaCreacion?.toIso8601String(),
        "NumFicha": numFicha,
        "UserName_Creacion": userNameCreacion,
        "UserName_Actualizacion": userNameActualizacion,
        "UltimaActualizacion": ultimaActualizacion?.toIso8601String(),
        // "Familia": familia == null
        //     ? []
        //     : List<dynamic>.from(familia!.map((x) => x.toJson())),
        // "Vivienda": vivienda == null
        //     ? []
        //     : List<dynamic>.from(vivienda!.map((x) => x.toJson())),
        // "Ubicacion": ubicacion == null
        //     ? []
        //     : List<dynamic>.from(ubicacion!.map((x) => x.toJson())),
        // "GrupoFamiliar": grupoFamiliar == null
        //     ? []
        //     : List<dynamic>.from(grupoFamiliar!.map((x) => x.toJson())),
        // "EstilosVidaSaludable": estilosVidaSaludable == null
        //     ? []
        //     : List<dynamic>.from(estilosVidaSaludable!.map((x) => x.toJson())),
        // "CuidadoSaludCondRiesgo": cuidadoSaludCondRiesgo == null
        //     ? []
        //     : List<dynamic>.from(
        //         cuidadoSaludCondRiesgo!.map((x) => x.toJson())),
        // "SocioCulturalPueblosIndigenas": socioCulturalPueblosIndigenas == null
        //     ? []
        //     : List<dynamic>.from(
        //         socioCulturalPueblosIndigenas!.map((x) => x.toJson())),
        // "AtencionSalud": atencionSalud == null
        //     ? []
        //     : List<dynamic>.from(atencionSalud!.map((x) => x.toJson())),
      };
}
