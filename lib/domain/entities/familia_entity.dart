class FamiliaEntity {
  FamiliaEntity({
    this.familiaId,
    required this.fichaId,
    required this.apellidosFlia,
    required this.afiliadoId,
    this.remoteFamiliaId,
  });

  int? familiaId;
  int fichaId;
  String apellidosFlia;
  int afiliadoId;
  int? remoteFamiliaId;

  FamiliaEntity copyWith({
    int? familiaId,
    int? fichaId,
    String? apellidosFlia,
    int? afiliadoId,
    int? remoteFamiliaId,
  }) =>
      FamiliaEntity(
        familiaId: familiaId ?? this.familiaId,
        fichaId: fichaId ?? this.fichaId,
        apellidosFlia: apellidosFlia ?? this.apellidosFlia,
        afiliadoId: afiliadoId ?? this.afiliadoId,
        remoteFamiliaId: remoteFamiliaId ?? this.remoteFamiliaId,
      );

  Map<String, dynamic> toJson() => {
        "Ficha_id": fichaId,
        "ApellidosFlia": apellidosFlia,
        "Afiliado_id": afiliadoId,
        "remoteFamilia_id": remoteFamiliaId,
      };
}
