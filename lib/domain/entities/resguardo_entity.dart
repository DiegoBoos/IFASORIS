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

  Map<String, dynamic> toJson() => {
        "Resguardo_id": resguardoId,
        "NombreResguardo": nombreResguardo,
        "CodaneResguardo": codaneResguardo,
        "Departamento_Ide": departamentoIde,
      };
}
