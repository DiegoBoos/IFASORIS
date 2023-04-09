class AfiliadoEntity {
  AfiliadoEntity({
    required this.afiliadoId,
    required this.tipoDocAfiliado,
    required this.documento,
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
  });

  int afiliadoId;
  String tipoDocAfiliado;
  String documento;
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

  factory AfiliadoEntity.fromJson(Map<String, dynamic> json) => AfiliadoEntity(
        afiliadoId: json["afiliado_id"],
        tipoDocAfiliado: json["tipoDoc_Afiliado"],
        documento: json["documento"],
        tipoDocCabezaFamilia: json["tipoDoc_CabezaFamilia"],
        documentocabeza: json["documentocabeza"],
        apellido1: json["apellido1"],
        apellido2: json["apellido2"],
        nombre1: json["nombre1"],
        nombre2: json["nombre2"],
        fecnac: json["fecnac"] == null ? null : DateTime.parse(json["fecnac"]),
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
        fechafiliacion: json["fechafiliacion"] == null
            ? null
            : DateTime.parse(json["fechafiliacion"]),
        codZonaAfiliado: json["codZona_Afiliado"],
        codTipoPobAfiliado: json["codTipoPob_afiliado"],
        ipsPrimariaAfiliado: json["ipsPrimaria_Afiliado"],
      );

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
