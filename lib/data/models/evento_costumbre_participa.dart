import 'dart:convert';

import 'package:ifasoris/domain/entities/evento_costumbre_participa.dart';

List<EventoCostumbreParticipaModel> eventosCostumbresParticipaFromJson(
        String str) =>
    List<EventoCostumbreParticipaModel>.from(
        json.decode(str).map((x) => EventoCostumbreParticipaModel.fromJson(x)));

class EventoCostumbreParticipaModel extends EventoCostumbreParticipaEntity {
  const EventoCostumbreParticipaModel({
    int? eventoCostumbreParticipaId,
    String? descripcion,
    int? departamentoId,
  }) : super(
          eventoCostumbreParticipaId: eventoCostumbreParticipaId,
          descripcion: descripcion,
          departamentoId: departamentoId,
        );

  static EventoCostumbreParticipaModel fromEntity(
      EventoCostumbreParticipaEntity entity) {
    return EventoCostumbreParticipaModel(
      eventoCostumbreParticipaId: entity.eventoCostumbreParticipaId,
      descripcion: entity.descripcion,
      departamentoId: entity.departamentoId,
    );
  }

  factory EventoCostumbreParticipaModel.fromJson(Map<String, dynamic> json) =>
      EventoCostumbreParticipaModel(
        eventoCostumbreParticipaId: json["EventoCostumbreParticipo_id"],
        descripcion: json["Descripcion"],
        departamentoId: json["Departamento_Ide"],
      );

  Map<String, dynamic> toJson() => {
        "EventoCostumbreParticipo_id": eventoCostumbreParticipaId,
        "Descripcion": descripcion,
        "Departamento_Ide": departamentoId
      };
}

List<LstEventoCostumbreParticipa> listEventoCostumbreParticipaFromJson(
        String str) =>
    List<LstEventoCostumbreParticipa>.from(
        json.decode(str).map((x) => LstEventoCostumbreParticipa.fromJson(x)));

class LstEventoCostumbreParticipa {
  int? dimSocioCulturalPueblosIndigenasId;
  int? eventoCostumbreParticipaId;

  LstEventoCostumbreParticipa({
    this.dimSocioCulturalPueblosIndigenasId,
    this.eventoCostumbreParticipaId,
  });

  factory LstEventoCostumbreParticipa.fromJson(Map<String, dynamic> json) =>
      LstEventoCostumbreParticipa(
        eventoCostumbreParticipaId: json["EventoCostumbreParticipo_id"],
      );

  Map<String, dynamic> toJson() => {
        "DimSocioCulturalPueblosIndigenas_id":
            dimSocioCulturalPueblosIndigenasId,
        "EventoCostumbreParticipo_id": eventoCostumbreParticipaId,
      };
}

List<Asp6EventoCostumbreParticipa> asp6EventoCostumbreParticipaFromJson(
        String str) =>
    List<Asp6EventoCostumbreParticipa>.from(
        json.decode(str).map((x) => Asp6EventoCostumbreParticipa.fromJson(x)));

class Asp6EventoCostumbreParticipa {
  int? dimSocioCulturalEventosCostumbresParticipoId;
  int? dimSocioCulturalPueblosIndigenasId;
  int? eventoCostumbreParticipaId;

  Asp6EventoCostumbreParticipa({
    this.dimSocioCulturalEventosCostumbresParticipoId,
    this.dimSocioCulturalPueblosIndigenasId,
    this.eventoCostumbreParticipaId,
  });

  factory Asp6EventoCostumbreParticipa.fromJson(Map<String, dynamic> json) =>
      Asp6EventoCostumbreParticipa(
        dimSocioCulturalEventosCostumbresParticipoId:
            json["DimSocioCulturalEventosCostumbresParticipo_id"],
        dimSocioCulturalPueblosIndigenasId:
            json["DimSocioCulturalPueblosIndigenas_id"],
        eventoCostumbreParticipaId: json["EventoCostumbreParticipo_id"],
      );

  Map<String, dynamic> toJson() => {
        "DimSocioCulturalPueblosIndigenas_id":
            dimSocioCulturalPueblosIndigenasId,
        "EventoCostumbreParticipo_id": eventoCostumbreParticipaId,
      };
}
