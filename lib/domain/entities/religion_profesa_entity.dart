class ReligionProfesaEntity {
  int religionProfesaId;
  String descripcion;

  ReligionProfesaEntity({
    required this.religionProfesaId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "ReligionProfesa_id": religionProfesaId,
        "Descripcion": descripcion,
      };
}
