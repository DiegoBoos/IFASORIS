// ignore_for_file: non_constant_identifier_names

class PuebloIndigenaEntity {
  int puebloIde;
  String TPS_CMD_IND_RSG_ID;
  String TPS_CMD_IND_RSG_NOMBRE;

  PuebloIndigenaEntity({
    required this.puebloIde,
    required this.TPS_CMD_IND_RSG_ID,
    required this.TPS_CMD_IND_RSG_NOMBRE,
  });

  Map<String, dynamic> toJson() => {
        "Pueblo_ide": puebloIde,
        "TPS_CMD_IND_RSG_ID": TPS_CMD_IND_RSG_ID,
        "TPS_CMD_IND_RSG_NOMBRE": TPS_CMD_IND_RSG_NOMBRE,
      };
}
