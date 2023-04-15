class MedioUtilizaMedTradicionalEntity {
  MedioUtilizaMedTradicionalEntity({
    required this.medioUtilizaMedTradId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int medioUtilizaMedTradId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "MedioUtilizaMedTrad_id": medioUtilizaMedTradId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
