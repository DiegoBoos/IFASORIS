import 'dart:convert';

class LstNombreMedTradicional {
  int? ubicacionId;
  String? nombreMedTradicional;

  LstNombreMedTradicional({
    this.ubicacionId,
    this.nombreMedTradicional,
  });

  factory LstNombreMedTradicional.fromJson(Map<String, dynamic> json) =>
      LstNombreMedTradicional(
        nombreMedTradicional: json["NombreMedTradicional"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "NombreMedTradicional": nombreMedTradicional,
      };
}

List<UbicacionNombresMedTradicional> ubicacionNombresMedTradicionalFromJson(
        String str) =>
    List<UbicacionNombresMedTradicional>.from(json
        .decode(str)
        .map((x) => UbicacionNombresMedTradicional.fromJson(x)));

class UbicacionNombresMedTradicional {
  int? ubicacionNombresMedTradicionalId;
  int? ubicacionId;
  String? nombreMedTradicional;

  UbicacionNombresMedTradicional({
    this.ubicacionNombresMedTradicionalId,
    this.ubicacionId,
    this.nombreMedTradicional,
  });

  factory UbicacionNombresMedTradicional.fromJson(Map<String, dynamic> json) =>
      UbicacionNombresMedTradicional(
        ubicacionNombresMedTradicionalId:
            json["UbicacionNombreMedTradicional_id"],
        ubicacionId: json["Ubicacion_id"],
        nombreMedTradicional: json["NombreMedTradicional"],
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "NombreMedTradicional": nombreMedTradicional,
      };
}
