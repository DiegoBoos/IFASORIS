class FamiliaEntity {
  FamiliaEntity({
    this.familiaId,
    this.fichaId,
    this.apellidosFlia,
    this.fkAfiliadoId,
  });

  int? familiaId;
  int? fichaId;
  String? apellidosFlia;
  int? fkAfiliadoId;

  FamiliaEntity copyWith({
    int? familiaId,
    int? fichaId,
    String? apellidosFlia,
    int? fkAfiliadoId,
  }) =>
      FamiliaEntity(
        familiaId: familiaId ?? this.familiaId,
        fichaId: fichaId ?? this.fichaId,
        apellidosFlia: apellidosFlia ?? this.apellidosFlia,
        fkAfiliadoId: fkAfiliadoId ?? this.fkAfiliadoId,
      );

  Map<String, dynamic> toJson() => {
        "Familia_id": familiaId,
        "Ficha_id": fichaId,
        "ApellidosFlia": apellidosFlia,
        "FK_Afiliado_id": fkAfiliadoId,
      };
}
