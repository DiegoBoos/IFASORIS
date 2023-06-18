class LenguaManejaEntity {
  LenguaManejaEntity({
    required this.lenguaManejaId,
    required this.descripcion,
  });

  int lenguaManejaId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "LenguaManeja_id": lenguaManejaId,
        "Descripcion": descripcion,
      };
}
