class ResguardoByDptoEntity {
  ResguardoByDptoEntity({
    required this.resguardoId,
    required this.nombreResguardo,
    required this.codaneResguardo,
    required this.departamentoIde,
  });

  int resguardoId;
  String nombreResguardo;
  String codaneResguardo;
  int departamentoIde;

  factory ResguardoByDptoEntity.fromJson(Map<String, dynamic> json) =>
      ResguardoByDptoEntity(
        resguardoId: json["resguardo_id"],
        nombreResguardo: json["nombreResguardo"],
        codaneResguardo: json["codaneResguardo"],
        departamentoIde: json["departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "resguardo_id": resguardoId,
        "nombreResguardo": nombreResguardo,
        "codaneResguardo": codaneResguardo,
        "departamento_Ide": departamentoIde,
      };
}
