class FamiliaEntity {
  FamiliaEntity({
    this.familiaId,
    this.fichaId,
    this.apellidosFlia,
    this.afiliadoId,
  });

  int? familiaId;
  int? fichaId;
  String? apellidosFlia;
  int? afiliadoId;

  FamiliaEntity copyWith({
    int? familiaId,
    int? fichaId,
    String? apellidosFlia,
    int? afiliadoId,
  }) =>
      FamiliaEntity(
        familiaId: familiaId ?? this.familiaId,
        fichaId: fichaId ?? this.fichaId,
        apellidosFlia: apellidosFlia ?? this.apellidosFlia,
        afiliadoId: afiliadoId ?? this.afiliadoId,
      );

  Map<String, dynamic> toJson() => {
        "Familia_id": familiaId,
        "Ficha_id": fichaId,
        "ApellidosFlia": apellidosFlia,
        "Afiliado_id": afiliadoId,
      };
}
