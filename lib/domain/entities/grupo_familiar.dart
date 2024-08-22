import 'package:equatable/equatable.dart';

import '../../ui/blocs/grupo_familiar/grupo_familiar_bloc.dart';

class GrupoFamiliarEntity extends Equatable {
  final int? grupoFamiliarId;
  final int? familiaId;
  final int? afiliadoId;
  final int? tipoDocumentoId;
  final String? documento;
  final int? generoId;
  final DateTime? fechaNacimiento;
  final int? edad;
  final String? nombre1;
  final String? nombre2;
  final String? apellido1;
  final String? apellido2;
  final String? tipoDocAfiliado;
  final String? codGeneroAfiliado;
  final String? codTipoRegimenAfiliado;
  final int? tipoRegimenId;
  final int? parentescoId;
  final int? etniaId;
  final int? cursoVidaId;
  final int? nivelEducativoId;
  final int? ocupacionId;
  final String? otroOcupacion;
  final int? grupoRiesgoId;
  final int? origenEtnico5602Id;
  final int? puebloIndigenaId;
  final int? lenguaManejaId;
  final int? lenguaMaternaId;
  final int isComplete;
  final GrupoFamiliarState formStatus;

  const GrupoFamiliarEntity(
      {this.grupoFamiliarId,
      this.familiaId,
      this.afiliadoId,
      this.tipoDocumentoId,
      this.documento,
      this.generoId,
      this.fechaNacimiento,
      this.edad,
      this.nombre1,
      this.nombre2,
      this.apellido1,
      this.apellido2,
      this.tipoDocAfiliado,
      this.codGeneroAfiliado,
      this.codTipoRegimenAfiliado,
      this.tipoRegimenId,
      this.parentescoId,
      this.etniaId,
      this.cursoVidaId,
      this.nivelEducativoId,
      this.ocupacionId,
      this.otroOcupacion,
      this.grupoRiesgoId,
      this.origenEtnico5602Id,
      this.puebloIndigenaId,
      this.lenguaManejaId,
      this.lenguaMaternaId,
      this.isComplete = 0,
      this.formStatus = const GrupoFamiliarFormInitial()});

  GrupoFamiliarEntity copyWith({
    int? grupoFamiliarId,
    int? familiaId,
    int? afiliadoId,
    int? tipoDocumentoId,
    String? documento,
    int? generoId,
    DateTime? fechaNacimiento,
    int? edad,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    String? tipoDocAfiliado,
    String? codGeneroAfiliado,
    String? codTipoRegimenAfiliado,
    int? tipoRegimenId,
    int? parentescoId,
    int? etniaId,
    int? cursoVidaId,
    int? nivelEducativoId,
    int? ocupacionId,
    String? otroOcupacion,
    int? grupoRiesgoId,
    int? origenEtnico5602Id,
    int? puebloIndigenaId,
    int? lenguaManejaId,
    int? lenguaMaternaId,
    int? isComplete,
    GrupoFamiliarState? formStatus,
  }) =>
      GrupoFamiliarEntity(
        grupoFamiliarId: grupoFamiliarId ?? this.grupoFamiliarId,
        familiaId: familiaId ?? this.familiaId,
        afiliadoId: afiliadoId ?? this.afiliadoId,
        tipoDocumentoId: tipoDocumentoId ?? this.tipoDocumentoId,
        documento: documento ?? this.documento,
        generoId: generoId ?? this.generoId,
        fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
        edad: edad ?? this.edad,
        nombre1: nombre1 ?? this.nombre1,
        nombre2: nombre2 ?? this.nombre2,
        apellido1: apellido1 ?? this.apellido1,
        apellido2: apellido2 ?? this.apellido2,
        tipoDocAfiliado: tipoDocAfiliado ?? this.tipoDocAfiliado,
        codGeneroAfiliado: codGeneroAfiliado ?? this.codGeneroAfiliado,
        codTipoRegimenAfiliado:
            codTipoRegimenAfiliado ?? this.codTipoRegimenAfiliado,
        tipoRegimenId: tipoRegimenId ?? this.tipoRegimenId,
        parentescoId: parentescoId ?? this.parentescoId,
        etniaId: etniaId ?? this.etniaId,
        cursoVidaId: cursoVidaId ?? this.cursoVidaId,
        nivelEducativoId: nivelEducativoId ?? this.nivelEducativoId,
        ocupacionId: ocupacionId ?? this.ocupacionId,
        otroOcupacion: otroOcupacion ?? this.otroOcupacion,
        grupoRiesgoId: grupoRiesgoId ?? this.grupoRiesgoId,
        origenEtnico5602Id: origenEtnico5602Id ?? this.origenEtnico5602Id,
        puebloIndigenaId: puebloIndigenaId ?? this.puebloIndigenaId,
        lenguaManejaId: lenguaManejaId ?? this.lenguaManejaId,
        lenguaMaternaId: lenguaMaternaId ?? this.lenguaMaternaId,
        isComplete: isComplete ?? this.isComplete,
        formStatus: formStatus ?? this.formStatus,
      );

  @override
  List<Object?> get props => [
        grupoFamiliarId,
        familiaId,
        afiliadoId,
        tipoDocumentoId,
        documento,
        generoId,
        fechaNacimiento,
        edad,
        nombre1,
        nombre2,
        apellido1,
        apellido2,
        tipoDocAfiliado,
        codGeneroAfiliado,
        codTipoRegimenAfiliado,
        tipoRegimenId,
        parentescoId,
        etniaId,
        cursoVidaId,
        nivelEducativoId,
        ocupacionId,
        otroOcupacion,
        grupoRiesgoId,
        origenEtnico5602Id,
        puebloIndigenaId,
        lenguaManejaId,
        lenguaMaternaId,
        isComplete,
        formStatus,
      ];
}
