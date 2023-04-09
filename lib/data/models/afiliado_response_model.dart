import 'dart:convert';
import 'package:ifasoris/domain/entities/afiliado_entity.dart';

AfiliadoResponseModel afiliadoResponseModelFromJson(String str) =>
    AfiliadoResponseModel.fromJson(json.decode(str));

class AfiliadoResponseModel {
  AfiliadoResponseModel({
    required this.paginaActual,
    required this.registrosPorPagina,
    required this.totalRegistros,
    required this.totalPaginas,
    required this.resultado,
  });

  int paginaActual;
  int registrosPorPagina;
  int totalRegistros;
  int totalPaginas;
  List<AfiliadoModel> resultado;

  factory AfiliadoResponseModel.fromJson(Map<String, dynamic> json) =>
      AfiliadoResponseModel(
        paginaActual: json["paginaActual"],
        registrosPorPagina: json["registrosPorPagina"],
        totalRegistros: json["totalRegistros"],
        totalPaginas: json["totalPaginas"],
        resultado: List<AfiliadoModel>.from(
            json["resultado"].map((x) => AfiliadoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "paginaActual": paginaActual,
        "registrosPorPagina": registrosPorPagina,
        "totalRegistros": totalRegistros,
        "totalPaginas": totalPaginas,
        "resultado": List<dynamic>.from(resultado.map((x) => x.toJson())),
      };
}

class AfiliadoModel extends AfiliadoEntity {
  AfiliadoModel({
    int? afiliadoId,
    String? tipoDocAfiliado,
    String? documento,
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
  }) : super(
          afiliadoId: afiliadoId ?? 0,
          tipoDocAfiliado: tipoDocAfiliado ?? '',
          documento: documento ?? '',
          tipoDocCabezaFamilia: tipoDocCabezaFamilia ?? '',
          documentocabeza: documentocabeza ?? '',
          apellido1: apellido1 ?? '',
          apellido2: apellido2 ?? '',
          nombre1: nombre1 ?? '',
          nombre2: nombre2 ?? '',
          fecnac: fecnac,
          codGeneroAfiliado: codGeneroAfiliado ?? '',
          direccion: direccion ?? '',
          telefonofijo: telefonofijo ?? '',
          telefonocel1: telefonocel1 ?? '',
          telefonocel2: telefonocel2 ?? '',
          departamentoIde: departamentoIde ?? 0,
          codMpioAfiliado: codMpioAfiliado ?? '',
          nomMpioAfiliado: nomMpioAfiliado ?? '',
          codDptoAfiliado: codDptoAfiliado ?? '',
          nomDptoAfiliado: nomDptoAfiliado ?? '',
          fechafiliacion: fechafiliacion,
          codZonaAfiliado: codZonaAfiliado ?? '',
          codTipoPobAfiliado: codTipoPobAfiliado ?? '',
          ipsPrimariaAfiliado: ipsPrimariaAfiliado ?? '',
        );

  factory AfiliadoModel.fromJson(Map<String, dynamic> json) => AfiliadoModel(
        afiliadoId: json["afiliado_id"],
        tipoDocAfiliado: json["tipoDoc_Afiliado"],
        documento: json["documento"],
        tipoDocCabezaFamilia: json["tipoDoc_CabezaFamilia"],
        documentocabeza: json["documentocabeza"],
        apellido1: json["apellido1"],
        apellido2: json["apellido2"],
        nombre1: json["nombre1"],
        nombre2: json["nombre2"],
        fecnac: DateTime.parse(json["fecnac"]),
        codGeneroAfiliado: json["codGenero_Afiliado"],
        direccion: json["direccion"],
        telefonofijo: json["telefonofijo"],
        telefonocel1: json["telefonocel1"],
        telefonocel2: json["telefonocel2"],
        departamentoIde: json["departamento_Ide"],
        codMpioAfiliado: json["codMpio_Afiliado"],
        nomMpioAfiliado: json["nomMpio_Afiliado"],
        codDptoAfiliado: json["codDpto_Afiliado"],
        nomDptoAfiliado: json["nomDpto_Afiliado"],
        fechafiliacion: DateTime.parse(json["fechafiliacion"]),
        codZonaAfiliado: json["codZona_Afiliado"],
        codTipoPobAfiliado: json["codTipoPob_afiliado"],
        ipsPrimariaAfiliado: json["ipsPrimaria_Afiliado"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "afiliado_id": afiliadoId,
        "tipoDoc_Afiliado": tipoDocAfiliado,
        "documento": documento,
        "tipoDoc_CabezaFamilia": tipoDocCabezaFamilia,
        "documentocabeza": documentocabeza,
        "apellido1": apellido1,
        "apellido2": apellido2,
        "nombre1": nombre1,
        "nombre2": nombre2,
        "fecnac": fecnac?.toIso8601String(),
        "codGenero_Afiliado": codGeneroAfiliado,
        "direccion": direccion,
        "telefonofijo": telefonofijo,
        "telefonocel1": telefonocel1,
        "telefonocel2": telefonocel2,
        "departamento_Ide": departamentoIde,
        "codMpio_Afiliado": codMpioAfiliado,
        "nomMpio_Afiliado": nomMpioAfiliado,
        "codDpto_Afiliado": codDptoAfiliado,
        "nomDpto_Afiliado": nomDptoAfiliado,
        "fechafiliacion": fechafiliacion?.toIso8601String(),
        "codZona_Afiliado": codZonaAfiliado,
        "codTipoPob_afiliado": codTipoPobAfiliado,
        "ipsPrimaria_Afiliado": ipsPrimariaAfiliado,
      };
}
