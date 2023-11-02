class EquipoEntity {
  EquipoEntity({
    this.imei,
    this.modeloEquipo,
  });

  String? imei;
  String? modeloEquipo;
  String? nombrePersona;

  factory EquipoEntity.fromMap(Map<String, dynamic> json) => EquipoEntity(
        imei: json["imei"],
        modeloEquipo: json["modeloEquipo"],
      );

  Map<String, dynamic> toJson() => {
        "imei": imei,
        "modeloEquipo": modeloEquipo,
      };
}
