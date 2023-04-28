class AfiliadoEntity {
  AfiliadoEntity({
    required this.afiliadoId,
    required this.tipoDocAfiliado,
    required this.documento,
    required this.afiliadoIdCabezaFamilia,
    required this.tipoDocCabezaFamilia,
    required this.documentocabeza,
    required this.apellido1,
    required this.apellido2,
    required this.nombre1,
    required this.nombre2,
    this.fecnac,
    required this.codGeneroAfiliado,
    required this.direccion,
    required this.telefonofijo,
    required this.telefonocel1,
    required this.telefonocel2,
    required this.departamentoIde,
    required this.codMpioAfiliado,
    required this.nomMpioAfiliado,
    required this.codDptoAfiliado,
    required this.nomDptoAfiliado,
    this.fechafiliacion,
    required this.codZonaAfiliado,
    required this.codTipoPobAfiliado,
    required this.ipsPrimariaAfiliado,
    this.familiaId,
  });

  int afiliadoId;
  String tipoDocAfiliado;
  String documento;
  int afiliadoIdCabezaFamilia;
  String tipoDocCabezaFamilia;
  String documentocabeza;
  String apellido1;
  String apellido2;
  String nombre1;
  String nombre2;
  DateTime? fecnac;
  String codGeneroAfiliado;
  String direccion;
  String telefonofijo;
  String telefonocel1;
  String telefonocel2;
  int departamentoIde;
  String codMpioAfiliado;
  String nomMpioAfiliado;
  String codDptoAfiliado;
  String nomDptoAfiliado;
  DateTime? fechafiliacion;
  String codZonaAfiliado;
  String codTipoPobAfiliado;
  String ipsPrimariaAfiliado;
  int? familiaId;

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
        "Familia_id": familiaId,
      };
}
