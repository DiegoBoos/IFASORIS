class CostumbrePracticaEntity {
  int costumbrePracticaId;
  String descripcion;

  CostumbrePracticaEntity({
    required this.costumbrePracticaId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "CostumbrePractica_id": costumbrePracticaId,
        "Descripcion": descripcion,
      };
}
