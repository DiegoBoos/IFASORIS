import '../../ui/blocs/grupo_familiar/grupo_familiar_bloc.dart';

class GrupoFamiliarEntity {
  int? afiliadoId;
  bool? isCompleted;
  GrupoFamiliarState formStatus;
  int? remoteGrupoFamiliarId;

  GrupoFamiliarEntity(
      {this.afiliadoId,
      this.isCompleted = false,
      this.formStatus = const GrupoFamiliarFormInitial(),
      this.remoteGrupoFamiliarId});

  GrupoFamiliarEntity copyWith({
    int? afiliadoId,
    bool? isCompleted,
    GrupoFamiliarState? formStatus,
    int? familiaRegistroId,
    int? tipoDocumentoId,
    String? documento,
    String? nombresApellidos,
    int? generoId,
    String? fechaNac,
    String? edad,
    int? cursoVida,
    int? parentescoId,
    int? regimenId,
    int? nivelEducativoId,
    int? ocupacionId,
    int? grupoRiesgoId,
    int? etniaId,
    int? puebloIndigenaId,
    int? lenguaManejaId,
    int? nombreLenguaMaternaId,
  }) =>
      GrupoFamiliarEntity(
        afiliadoId: afiliadoId ?? this.afiliadoId,
        isCompleted: isCompleted ?? this.isCompleted,
        formStatus: formStatus ?? this.formStatus,
      );

  Map<String, dynamic> toJson() => {
        "DatoVivienda_id": afiliadoId,
        "Familia_id": isCompleted,
        "remoteGrupoFamiliarId": remoteGrupoFamiliarId,
      };
}
