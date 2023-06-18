class GeneroEntity {
  int generoId;
  String tipo;
  String descripcion;

  GeneroEntity({
    required this.generoId,
    required this.tipo,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "Genero_id": generoId,
        "Tipo": tipo,
        "Descripcion": descripcion,
      };
}
