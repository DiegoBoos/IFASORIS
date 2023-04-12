class MedioUtilizaMedTradicionalEntity {
  MedioUtilizaMedTradicionalEntity({
    required this.medioUtilizaMedTradId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int medioUtilizaMedTradId;
  String descripcion;
  int departamentoIde;

  factory MedioUtilizaMedTradicionalEntity.fromJson(
          Map<String, dynamic> json) =>
      MedioUtilizaMedTradicionalEntity(
        medioUtilizaMedTradId: json["medioUtilizaMedTrad_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "medioUtilizaMedTrad_id": medioUtilizaMedTradId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
