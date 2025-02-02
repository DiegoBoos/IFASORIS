import 'dart:convert';

import 'package:ifasoris/domain/entities/afiliado.dart';

AfiliadoResponseModel afiliadoResponseFromJson(String str) =>
    AfiliadoResponseModel.fromJson(json.decode(str));

class AfiliadoResponseModel {
  AfiliadoResponseModel({
    required this.totalRegistros,
    required this.resultado,
  });

  int totalRegistros;
  List<AfiliadoModel> resultado;

  factory AfiliadoResponseModel.fromJson(Map<String, dynamic> json) =>
      AfiliadoResponseModel(
        totalRegistros: json["totalRecords"],
        resultado: List<AfiliadoModel>.from(
            json["afiliados"].map((x) => AfiliadoModel.fromJson(x))),
      );
}

class AfiliadoModel extends AfiliadoEntity {
  const AfiliadoModel(
      {super.afiliadoId,
      super.tipoDocAfiliado,
      super.documento,
      super.afiliadoIdCabezaFamilia,
      super.tipoDocCabezaFamilia,
      super.documentocabeza,
      super.apellido1,
      super.apellido2,
      super.nombre1,
      super.nombre2,
      super.fecnac,
      super.codGeneroAfiliado,
      super.direccion,
      super.telefonofijo,
      super.telefonocel1,
      String? super.telefonocel2,
      super.departamentoIde,
      super.codMpioAfiliado,
      super.nomMpioAfiliado,
      super.codDptoAfiliado,
      super.nomDptoAfiliado,
      super.fechafiliacion,
      super.codZonaAfiliado,
      super.codTipoPobAfiliado,
      super.ipsPrimariaAfiliado,
      super.idePrestador,
      super.edad,
      super.codRegimenAfiliado,
      super.familiaId});

  factory AfiliadoModel.fromEntity(AfiliadoEntity entity) {
    return AfiliadoModel(
      afiliadoId: entity.afiliadoId,
      tipoDocAfiliado: entity.tipoDocAfiliado,
      documento: entity.documento,
      afiliadoIdCabezaFamilia: entity.afiliadoIdCabezaFamilia,
      tipoDocCabezaFamilia: entity.tipoDocCabezaFamilia,
      documentocabeza: entity.documentocabeza,
      apellido1: entity.apellido1,
      apellido2: entity.apellido2,
      nombre1: entity.nombre1,
      nombre2: entity.nombre2,
      fecnac: entity.fecnac,
      codGeneroAfiliado: entity.codGeneroAfiliado,
      direccion: entity.direccion,
      telefonofijo: entity.telefonofijo,
      telefonocel1: entity.telefonocel1,
      telefonocel2: entity.telefonocel2,
      departamentoIde: entity.departamentoIde,
      codMpioAfiliado: entity.codMpioAfiliado,
      nomMpioAfiliado: entity.nomMpioAfiliado,
      codDptoAfiliado: entity.codDptoAfiliado,
      nomDptoAfiliado: entity.nomDptoAfiliado,
      fechafiliacion: entity.fechafiliacion,
      codZonaAfiliado: entity.codZonaAfiliado,
      codTipoPobAfiliado: entity.codTipoPobAfiliado,
      ipsPrimariaAfiliado: entity.ipsPrimariaAfiliado,
      idePrestador: entity.idePrestador,
      edad: entity.edad,
      codRegimenAfiliado: entity.codRegimenAfiliado,
      familiaId: entity.familiaId,
    );
  }

  factory AfiliadoModel.fromJson(Map<String, dynamic> json) => AfiliadoModel(
        afiliadoId: json["Afiliado_id"],
        tipoDocAfiliado: json["TipoDoc_Afiliado"],
        documento: json["documento"],
        afiliadoIdCabezaFamilia: json["AfiliadoId_CabezaFamilia"],
        tipoDocCabezaFamilia: json["TipoDoc_CabezaFamilia"],
        documentocabeza: json["documentocabeza"],
        apellido1: json["apellido1"],
        apellido2: json["apellido2"],
        nombre1: json["nombre1"],
        nombre2: json["nombre2"],
        fecnac: json["fecnac"] != null ? DateTime.parse(json["fecnac"]) : null,
        codGeneroAfiliado: json["CodGenero_Afiliado"],
        direccion: json["Direccion"],
        telefonofijo: json["Telefonofijo"],
        telefonocel1: json["Telefonocel1"],
        telefonocel2: json["Telefonocel2"],
        departamentoIde: json["Departamento_Ide"],
        codMpioAfiliado: json["CodMpio_Afiliado"],
        nomMpioAfiliado: json["NomMpio_Afiliado"],
        codDptoAfiliado: json["CodDpto_Afiliado"],
        nomDptoAfiliado: json["NomDpto_Afiliado"],
        fechafiliacion: json["fechafiliacion"] != null
            ? DateTime.parse(json["fechafiliacion"])
            : null,
        codZonaAfiliado: json["CodZona_Afiliado"],
        codTipoPobAfiliado: json["CodTipoPob_afiliado"],
        ipsPrimariaAfiliado: json["IPSPrimaria_Afiliado"],
        idePrestador: json["IDE_PRESTADOR"],
        edad: json["Edad"],
        codRegimenAfiliado: json["CodRegimen_Afiliado"],
        familiaId: json["Familia_id"],
      );

  factory AfiliadoModel.fromDB(Map<String, dynamic> json) => AfiliadoModel(
        afiliadoId: json["Afiliado_id"],
        tipoDocAfiliado: json["TipoDoc_Afiliado"],
        documento: json["documento"],
        afiliadoIdCabezaFamilia: json["AfiliadoId_CabezaFamilia"],
        tipoDocCabezaFamilia: json["TipoDoc_CabezaFamilia"],
        documentocabeza: json["documentocabeza"],
        apellido1: json["apellido1"],
        apellido2: json["apellido2"],
        nombre1: json["nombre1"],
        nombre2: json["nombre2"],
        fecnac: json["fecnac"] != null ? DateTime.parse(json["fecnac"]) : null,
        codGeneroAfiliado: json["CodGenero_Afiliado"],
        direccion: json["Direccion"],
        telefonofijo: json["Telefonofijo"],
        telefonocel1: json["Telefonocel1"],
        telefonocel2: json["Telefonocel2"],
        departamentoIde: json["Departamento_Ide"],
        codMpioAfiliado: json["CodMpio_Afiliado"],
        nomMpioAfiliado: json["NomMpio_Afiliado"],
        codDptoAfiliado: json["CodDpto_Afiliado"],
        nomDptoAfiliado: json["NomDpto_Afiliado"],
        fechafiliacion: json["fechafiliacion"] != null
            ? DateTime.parse(json["fechafiliacion"])
            : null,
        codZonaAfiliado: json["CodZona_Afiliado"],
        codTipoPobAfiliado: json["CodTipoPob_afiliado"],
        ipsPrimariaAfiliado: json["IPSPrimaria_Afiliado"],
        idePrestador: json["IDE_PRESTADOR"],
        edad: json["Edad"],
        codRegimenAfiliado: json["CodRegimen_Afiliado"],
        familiaId: json["Familia_id"],
      );

  Map<String, dynamic> toJson() => {
        "Afiliado_id": afiliadoId,
        "TipoDoc_Afiliado": tipoDocAfiliado,
        "documento": documento,
        "AfiliadoId_CabezaFamilia": afiliadoIdCabezaFamilia,
        "TipoDoc_CabezaFamilia": tipoDocCabezaFamilia,
        "documentocabeza": documentocabeza,
        "apellido1": apellido1,
        "apellido2": apellido2,
        "nombre1": nombre1,
        "nombre2": nombre2,
        "fecnac": fecnac?.toIso8601String(),
        "CodGenero_Afiliado": codGeneroAfiliado,
        "Direccion": direccion,
        "Telefonofijo": telefonofijo,
        "Telefonocel1": telefonocel1,
        "Telefonocel2": telefonocel2,
        "Departamento_Ide": departamentoIde,
        "CodMpio_Afiliado": codMpioAfiliado,
        "NomMpio_Afiliado": nomMpioAfiliado,
        "CodDpto_Afiliado": codDptoAfiliado,
        "NomDpto_Afiliado": nomDptoAfiliado,
        "fechafiliacion": fechafiliacion?.toIso8601String(),
        "CodZona_Afiliado": codZonaAfiliado,
        "CodTipoPob_afiliado": codTipoPobAfiliado,
        "IPSPrimaria_Afiliado": ipsPrimariaAfiliado,
        "IDE_PRESTADOR": idePrestador,
        "Edad": edad,
        "CodRegimen_Afiliado": codRegimenAfiliado,
      };

  Map<String, dynamic> toJsonForSharedPreferences() => {
        "Afiliado_id": afiliadoId,
        "TipoDoc_Afiliado": tipoDocAfiliado,
        "documento": documento,
        "AfiliadoId_CabezaFamilia": afiliadoIdCabezaFamilia,
        "TipoDoc_CabezaFamilia": tipoDocCabezaFamilia,
        "documentocabeza": documentocabeza,
        "apellido1": apellido1,
        "apellido2": apellido2 ?? '',
        "nombre1": nombre1,
        "nombre2": nombre2 ?? '',
        "fecnac": fecnac?.toIso8601String(),
        "CodGenero_Afiliado": codGeneroAfiliado,
        "Direccion": direccion,
        "Telefonofijo": telefonofijo,
        "Telefonocel1": telefonocel1,
        "Telefonocel2": telefonocel2,
        "Departamento_Ide": departamentoIde,
        "CodMpio_Afiliado": codMpioAfiliado,
        "NomMpio_Afiliado": nomMpioAfiliado,
        "CodDpto_Afiliado": codDptoAfiliado,
        "NomDpto_Afiliado": nomDptoAfiliado,
        "fechafiliacion": fechafiliacion?.toIso8601String(),
        "CodZona_Afiliado": codZonaAfiliado,
        "CodTipoPob_afiliado": codTipoPobAfiliado,
        "IPSPrimaria_Afiliado": ipsPrimariaAfiliado,
        "IDE_PRESTADOR": idePrestador,
        "Edad": edad,
        "CodRegimen_Afiliado": codRegimenAfiliado,
        "Familia_id": familiaId,
      };
}
