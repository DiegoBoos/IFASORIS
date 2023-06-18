class ParentescoEntity {
  int parentescoId;
  String descripcion;

  ParentescoEntity({
    required this.parentescoId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "Parentesco_id": parentescoId,
        "Descripcion": descripcion,
      };
}
