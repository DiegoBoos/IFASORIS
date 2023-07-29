class CondicionNutricionalEntity {
  CondicionNutricionalEntity({
    required this.condicionNutricionalId,
    required this.descripcion,
  });

  int condicionNutricionalId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "CondicionNutricional_id": condicionNutricionalId,
        "Descripcion": descripcion,
      };
}
