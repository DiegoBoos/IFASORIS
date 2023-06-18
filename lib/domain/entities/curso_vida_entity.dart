class CursoVidaEntity {
  CursoVidaEntity({
    required this.cursoVidaId,
    required this.descripcion,
    required this.rango,
  });

  int cursoVidaId;
  String descripcion;
  String rango;

  Map<String, dynamic> toJson() => {
        "CursoVida_id": cursoVidaId,
        "Descripcion": descripcion,
        "Rango": rango,
      };
}
