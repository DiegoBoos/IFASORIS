class SancionJusticiaEntity {
  int sancionJusticiaId;
  String descripcion;

  SancionJusticiaEntity({
    required this.sancionJusticiaId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "SancionJusticia_id": sancionJusticiaId,
        "Descripcion": descripcion,
      };
}
