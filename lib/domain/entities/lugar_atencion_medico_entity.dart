class LugarAtencionMedicoEntity {
  int lugarAtencionMedicoId;
  String descripcion;

  LugarAtencionMedicoEntity({
    required this.lugarAtencionMedicoId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "LugarAtencionMedico_id": lugarAtencionMedicoId,
        "Descripcion": descripcion,
      };
}
