import 'dart:convert';

import 'package:ifasoris/domain/entities/evento_costumbre_participa_entity.dart';

List<EventoCostumbreParticipaModel> eventosCostumbresParticipaFromJson(
        String str) =>
    List<EventoCostumbreParticipaModel>.from(
        json.decode(str).map((x) => EventoCostumbreParticipaModel.fromJson(x)));

class EventoCostumbreParticipaModel extends EventoCostumbreParticipaEntity {
  EventoCostumbreParticipaModel({
    required int eventoCostumbreParticipaId,
    required String descripcion,
  }) : super(
            eventoCostumbreParticipaId: eventoCostumbreParticipaId,
            descripcion: descripcion);

  factory EventoCostumbreParticipaModel.fromJson(Map<String, dynamic> json) =>
      EventoCostumbreParticipaModel(
        eventoCostumbreParticipaId: json["EventoCostumbreParticipa_id"],
        descripcion: json["Descripcion"],
      );
}

class LstEventoCostumbreParticipa {
  int? eventoCostumbreParticipaId;

  LstEventoCostumbreParticipa({
    this.eventoCostumbreParticipaId,
  });

  factory LstEventoCostumbreParticipa.fromJson(Map<String, dynamic> json) =>
      LstEventoCostumbreParticipa(
        eventoCostumbreParticipaId: json["EventoCostumbreParticipo_id"],
      );

  Map<String, dynamic> toJson() => {
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
