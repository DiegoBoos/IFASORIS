class MedioUtilizaCAEntity {
  MedioUtilizaCAEntity({
    required this.medioUtilizaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int medioUtilizaId;
  String descripcion;
  int departamentoIde;

  factory MedioUtilizaCAEntity.fromJson(Map<String, dynamic> json) =>
      MedioUtilizaCAEntity(
        medioUtilizaId: json["medioUtiliza_id"],
        descripcion: json["descripcion"],
        departamentoIde: json["departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "medioUtiliza_id": medioUtilizaId,
        "descripcion": descripcion,
        "departamento_Ide": departamentoIde,
      };
}
