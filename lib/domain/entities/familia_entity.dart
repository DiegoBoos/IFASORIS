class FamiliaEntity {
  FamiliaEntity({
    required this.fichaId,
    required this.apellidosFlia,
    required this.afiliadoId,
  });

  int fichaId;
  String apellidosFlia;
  int afiliadoId;

  FamiliaEntity copyWith({
    int? fichaId,
    String? apellidosFlia,
    int? afiliadoId,
  }) =>
      FamiliaEntity(
        fichaId: fichaId ?? this.fichaId,
        apellidosFlia: apellidosFlia ?? this.apellidosFlia,
        afiliadoId: afiliadoId ?? this.afiliadoId,
      );

  Map<String, dynamic> toJson() => {
        "Ficha_id": fichaId,
        "ApellidosFlia": apellidosFlia,
        "Afiliado_id": afiliadoId,
      };
}
