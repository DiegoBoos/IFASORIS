import '../../ui/blocs/grupo_familiar/grupo_familiar_bloc.dart';

class GrupoFamiliarEntity {
  int? afiliadoId;
  bool? isCompleted;
  GrupoFamiliarState formStatus;

  GrupoFamiliarEntity(
      {this.afiliadoId,
      this.isCompleted = false,
      this.formStatus = const GrupoFamiliarFormInitial()});

  GrupoFamiliarEntity copyWith({
    int? afiliadoId,
    bool? isCompleted,
    GrupoFamiliarState? formStatus,
  }) =>
      GrupoFamiliarEntity(
        afiliadoId: afiliadoId ?? this.afiliadoId,
        isCompleted: isCompleted ?? this.isCompleted,
        formStatus: formStatus ?? this.formStatus,
      );
}
