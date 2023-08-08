class EventoCostumbreParticipaEntity {
  int eventoCostumbreParticipaId;
  String descripcion;

  EventoCostumbreParticipaEntity({
    required this.eventoCostumbreParticipaId,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "EventoCostumbreParticipo_id": eventoCostumbreParticipaId,
        "Descripcion": descripcion,
      };
}
