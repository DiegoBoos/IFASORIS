class NivelEducativoEntity {
  NivelEducativoEntity({
    required this.nivelEducativoId,
    required this.descripcion,
  });

  int nivelEducativoId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "NivelEducativo_id": nivelEducativoId,
        "Descripcion": descripcion,
      };
}
