class EquipoEntity {
  EquipoEntity({
    this.idEquipo,
    this.modeloEquipo,
  });

  String? idEquipo;
  String? modeloEquipo;
  String? nombrePersona;

  factory EquipoEntity.fromMap(Map<String, dynamic> json) => EquipoEntity(
        idEquipo: json["idEquipo"],
        modeloEquipo: json["modeloEquipo"],
      );

  Map<String, dynamic> toJson() => {
        "idEquipo": idEquipo,
        "modeloEquipo": modeloEquipo,
      };
}
