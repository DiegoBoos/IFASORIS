class TuberculoPlatanoEntity {
  TuberculoPlatanoEntity({
    required this.tuberculoPlatanoId,
    required this.descripcion,
    required this.departamentoIde,
  });

  int tuberculoPlatanoId;
  String descripcion;
  int departamentoIde;

  Map<String, dynamic> toJson() => {
        "TuberculoPlatano_id": tuberculoPlatanoId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoIde,
      };
}
