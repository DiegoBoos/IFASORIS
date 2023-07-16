class ConsumoAlcoholEntity {
  int consumoAlcoholId;
  String descripcion;

  ConsumoAlcoholEntity({
    required this.consumoAlcoholId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "ConsumoAlcohol_id": consumoAlcoholId,
        "Descripcion": descripcion,
      };
}
