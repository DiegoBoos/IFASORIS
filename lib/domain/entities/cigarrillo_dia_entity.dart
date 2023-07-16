class CigarrilloDiaEntity {
  int numeroCigarrilloDiaId;
  String descripcion;

  CigarrilloDiaEntity({
    required this.numeroCigarrilloDiaId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "NumeroCigarrilloDia_id": numeroCigarrilloDiaId,
        "Descripcion": descripcion,
      };
}
