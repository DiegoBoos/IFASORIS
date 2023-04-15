class MedioUtilizaCAEntity {
  MedioUtilizaCAEntity({
    required this.medioUtilizaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int medioUtilizaId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "MedioUtiliza_id": medioUtilizaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
