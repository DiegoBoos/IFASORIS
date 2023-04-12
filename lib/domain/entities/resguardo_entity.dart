class ResguardoEntity {
  ResguardoEntity({
    required this.resguardoId,
    required this.nombreResguardo,
    required this.codaneResguardo,
    required this.departamentoIde,
  });

  int resguardoId;
  String nombreResguardo;
  String codaneResguardo;
  int departamentoIde;

  factory ResguardoEntity.fromJson(Map<String, dynamic> json) =>
      ResguardoEntity(
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
