class AfiliadoEntity {
  int? afiliadoId;
  String? tipoDocAfiliado;
  String? documento;
  int? afiliadoIdCabezaFamilia;
  String? tipoDocCabezaFamilia;
  String? documentocabeza;
  String? apellido1;
  String? apellido2;
  String? nombre1;
  String? nombre2;
  DateTime? fecnac;
  String? codGeneroAfiliado;
  String? direccion;
  String? telefonofijo;
  String? telefonocel1;
  dynamic telefonocel2;
  int? departamentoIde;
  String? codMpioAfiliado;
  String? nomMpioAfiliado;
  String? codDptoAfiliado;
  String? nomDptoAfiliado;
  DateTime? fechafiliacion;
  String? codZonaAfiliado;
  String? codTipoPobAfiliado;
  String? ipsPrimariaAfiliado;
  int? familiaId;

  AfiliadoEntity({
    this.afiliadoId,
    this.tipoDocAfiliado,
    this.documento,
    this.afiliadoIdCabezaFamilia,
    this.tipoDocCabezaFamilia,
    this.documentocabeza,
    this.apellido1,
    this.apellido2,
    this.nombre1,
    this.nombre2,
    this.fecnac,
    this.codGeneroAfiliado,
    this.direccion,
    this.telefonofijo,
    this.telefonocel1,
    this.telefonocel2,
    this.departamentoIde,
    this.codMpioAfiliado,
    this.nomMpioAfiliado,
    this.codDptoAfiliado,
    this.nomDptoAfiliado,
    this.fechafiliacion,
    this.codZonaAfiliado,
    this.codTipoPobAfiliado,
    this.ipsPrimariaAfiliado,
    this.familiaId,
  });

  AfiliadoEntity copyWith({
    int? afiliadoId,
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
    int? familiaId,
  }) =>
      AfiliadoEntity(
        afiliadoId: afiliadoId ?? this.afiliadoId,
        tipoDocAfiliado: tipoDocAfiliado ?? this.tipoDocAfiliado,
        documento: documento ?? this.documento,
        afiliadoIdCabezaFamilia:
            afiliadoIdCabezaFamilia ?? this.afiliadoIdCabezaFamilia,
        tipoDocCabezaFamilia: tipoDocCabezaFamilia ?? this.tipoDocCabezaFamilia,
        documentocabeza: documentocabeza ?? this.documentocabeza,
        apellido1: apellido1 ?? this.apellido1,
        apellido2: apellido2 ?? this.apellido2,
        nombre1: nombre1 ?? this.nombre1,
        nombre2: nombre2 ?? this.nombre2,
        fecnac: fecnac ?? this.fecnac,
        codGeneroAfiliado: codGeneroAfiliado ?? this.codGeneroAfiliado,
        direccion: direccion ?? this.direccion,
        telefonofijo: telefonofijo ?? this.telefonofijo,
        telefonocel1: telefonocel1 ?? this.telefonocel1,
        telefonocel2: telefonocel2 ?? this.telefonocel2,
        departamentoIde: departamentoIde ?? this.departamentoIde,
        codMpioAfiliado: codMpioAfiliado ?? this.codMpioAfiliado,
        nomMpioAfiliado: nomMpioAfiliado ?? this.nomMpioAfiliado,
        codDptoAfiliado: codDptoAfiliado ?? this.codDptoAfiliado,
        nomDptoAfiliado: nomDptoAfiliado ?? this.nomDptoAfiliado,
        fechafiliacion: fechafiliacion ?? this.fechafiliacion,
        codZonaAfiliado: codZonaAfiliado ?? this.codZonaAfiliado,
        codTipoPobAfiliado: codTipoPobAfiliado ?? this.codTipoPobAfiliado,
        ipsPrimariaAfiliado: ipsPrimariaAfiliado ?? this.ipsPrimariaAfiliado,
        familiaId: familiaId ?? this.familiaId,
      );

  factory AfiliadoEntity.fromJson(Map<String, dynamic> json) => AfiliadoEntity(
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
        fecnac: json["fecnac"] == null ? null : DateTime.parse(json["fecnac"]),
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
        fechafiliacion: json["fechafiliacion"] == null
            ? null
            : DateTime.parse(json["fechafiliacion"]),
        codZonaAfiliado: json["CodZona_Afiliado"],
        codTipoPobAfiliado: json["CodTipoPob_afiliado"],
        ipsPrimariaAfiliado: json["IPSPrimaria_Afiliado"],
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
      };

  Map<String, dynamic> toJsonForSharedPreferences() => {
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
        "Familia_id": familiaId,
      };
}
