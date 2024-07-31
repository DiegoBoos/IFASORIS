import 'package:equatable/equatable.dart';

class AfiliadoEntity extends Equatable {
  final int? afiliadoId;
  final String? tipoDocAfiliado;
  final String? documento;
  final int? afiliadoIdCabezaFamilia;
  final String? tipoDocCabezaFamilia;
  final String? documentocabeza;
  final String? apellido1;
  final String? apellido2;
  final String? nombre1;
  final String? nombre2;
  final DateTime? fecnac;
  final String? codGeneroAfiliado;
  final String? direccion;
  final String? telefonofijo;
  final String? telefonocel1;
  final dynamic telefonocel2;
  final int? departamentoIde;
  final String? codMpioAfiliado;
  final String? nomMpioAfiliado;
  final String? codDptoAfiliado;
  final String? nomDptoAfiliado;
  final DateTime? fechafiliacion;
  final String? codZonaAfiliado;
  final String? codTipoPobAfiliado;
  final String? ipsPrimariaAfiliado;
  final int? idePrestador;
  final int? edad;
  final String? codRegimenAfiliado;
  final int? familiaId;

  const AfiliadoEntity({
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
    this.idePrestador,
    this.edad,
    this.codRegimenAfiliado,
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
    int? idePrestador,
    int? edad,
    String? codRegimenAfiliado,
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
        idePrestador: idePrestador ?? this.idePrestador,
        edad: edad ?? this.edad,
        codRegimenAfiliado: codRegimenAfiliado ?? this.codRegimenAfiliado,
        familiaId: familiaId ?? this.familiaId,
      );

  @override
  List<Object?> get props => [
        afiliadoId,
        tipoDocAfiliado,
        documento,
        afiliadoIdCabezaFamilia,
        tipoDocCabezaFamilia,
        documentocabeza,
        apellido1,
        apellido2,
        nombre1,
        nombre2,
        fecnac,
        codGeneroAfiliado,
        direccion,
        telefonofijo,
        telefonocel1,
        telefonocel2,
        departamentoIde,
        codMpioAfiliado,
        nomMpioAfiliado,
        codDptoAfiliado,
        nomDptoAfiliado,
        fechafiliacion,
        codZonaAfiliado,
        codTipoPobAfiliado,
        ipsPrimariaAfiliado,
        idePrestador,
        edad,
        codRegimenAfiliado,
        familiaId,
      ];
}
