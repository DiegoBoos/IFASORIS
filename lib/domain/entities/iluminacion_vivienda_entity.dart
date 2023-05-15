class IluminacionViviendaEntity {
  IluminacionViviendaEntity({
    required this.iluminacionViviendaId,
    required this.descripcion,
  });

  int iluminacionViviendaId;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "IluminacionVivienda_id": iluminacionViviendaId,
        "Descripcion": descripcion,
      };
}
