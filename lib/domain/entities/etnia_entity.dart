class EtniaEntity {
  int etniaId;
  String descripcion;

  EtniaEntity({
    required this.etniaId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "Etnia_id": etniaId,
        "Descripcion": descripcion,
      };
}
