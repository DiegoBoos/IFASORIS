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
      {int? afiliadoId,
      String? tipoDocAfiliado,
      String? documento,
      int? afiliadoIdCabezaFamilia,
      String? tipoDocCabezaFamilia,
      String? documentocabeza,
      String? apellido1,
      String? apellido2,
      String? nombre1,
      String? nombre2,
      DateTime? fecnac,
      String? codGeneroAfiliado,
      String? direccion,
      String? telefonofijo,
      String? telefonocel1,
      String? telefonocel2,
      int? departamentoIde,
      String? codMpioAfiliado,
      String? nomMpioAfiliado,
      String? codDptoAfiliado,
      String? nomDptoAfiliado,
      DateTime? fechafiliacion,
      String? codZonaAfiliado,
      String? codTipoPobAfiliado,
      String? ipsPrimariaAfiliado,
      String? idePrestador,
      int? edad,
      String? codTipoRegimenAfiliado,
      int? familiaId})
      : super(
            afiliadoId: afiliadoId,
            tipoDocAfiliado: tipoDocAfiliado,
            documento: documento,
            afiliadoIdCabezaFamilia: afiliadoIdCabezaFamilia,
            tipoDocCabezaFamilia: tipoDocCabezaFamilia,
            documentocabeza: documentocabeza,
            apellido1: apellido1,
            apellido2: apellido2,
            nombre1: nombre1,
            nombre2: nombre2,
            fecnac: fecnac,
            codGeneroAfiliado: codGeneroAfiliado,
            direccion: direccion,
            telefonofijo: telefonofijo,
            telefonocel1: telefonocel1,
            telefonocel2: telefonocel2,
            departamentoIde: departamentoIde,
            codMpioAfiliado: codMpioAfiliado,
            nomMpioAfiliado: nomMpioAfiliado,
            codDptoAfiliado: codDptoAfiliado,
            nomDptoAfiliado: nomDptoAfiliado,
            fechafiliacion: fechafiliacion,
            codZonaAfiliado: codZonaAfiliado,
            codTipoPobAfiliado: codTipoPobAfiliado,
            ipsPrimariaAfiliado: ipsPrimariaAfiliado,
            idePrestador: idePrestador,
            edad: edad,
            codTipoRegimenAfiliado: codTipoRegimenAfiliado,
            familiaId: familiaId);

  static AfiliadoModel fromEntity(AfiliadoEntity entity) {
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
      codTipoRegimenAfiliado: entity.codTipoRegimenAfiliado,
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
        codTipoRegimenAfiliado: json["CodTipoRegimen_Afiliado"],
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
        codTipoRegimenAfiliado: json["CodTipoRegimen_Afiliado"],
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
        "CodTipoRegimen_Afiliado": codTipoRegimenAfiliado,
        "Familia_id": familiaId,
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
        "CodTipoRegimen_Afiliado": codTipoRegimenAfiliado,
        "Familia_id": familiaId,
      };
}
