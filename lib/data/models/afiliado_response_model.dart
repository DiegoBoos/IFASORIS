import 'dart:convert';
import 'package:ifasoris/domain/entities/afiliado_entity.dart';

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
  AfiliadoModel(
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
      dynamic telefonocel2,
      int? departamentoIde,
      String? codMpioAfiliado,
      String? nomMpioAfiliado,
      String? codDptoAfiliado,
      String? nomDptoAfiliado,
      DateTime? fechafiliacion,
      String? codZonaAfiliado,
      String? codTipoPobAfiliado,
      String? ipsPrimariaAfiliado,
      int? idePrestador,
      int? edad,
      String? codRegimenAfiliado,
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
            codRegimenAfiliado: codRegimenAfiliado,
            familiaId: familiaId);

  factory AfiliadoModel.fromJson(Map<String, dynamic> json) => AfiliadoModel(
        afiliadoId: json["Afiliado_id"],
        tipoDocAfiliado: json["TipoDoc_Afiliado"],
        documento: json["documento"],
        afiliadoIdCabezaFamilia: json["AfiliadoId_CabezaFamilia"],
        tipoDocCabezaFamilia: json["TipoDoc_CabezaFamilia"],
        documentocabeza: json["documentocabeza"],
        apellido1: json["apellido1"],
        apellido2: json["apellido2"] ?? '',
        nombre1: json["nombre1"],
        nombre2: json["nombre2"] ?? '',
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
        apellido2: json["apellido2"] ?? '',
        nombre1: json["nombre1"],
        nombre2: json["nombre2"] ?? '',
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
}
