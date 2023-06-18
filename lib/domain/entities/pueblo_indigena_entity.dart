class PuebloIndigenaEntity {
  int puebloIndigenaId;
  String descripcion;
  int departamentoIde;

  PuebloIndigenaEntity({
    required this.puebloIndigenaId,
    required this.descripcion,
    required this.departamentoIde,
  });

  Map<String, dynamic> toJson() => {
        "PuebloIndigena_id": puebloIndigenaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
