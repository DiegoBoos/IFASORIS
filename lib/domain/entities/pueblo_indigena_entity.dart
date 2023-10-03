// ignore_for_file: non_constant_identifier_names

class PuebloIndigenaEntity {
  int puebloIde;
  int Departamento_Ide;
  String Descripcion;

  PuebloIndigenaEntity({
    required this.puebloIde,
    required this.Departamento_Ide,
    required this.Descripcion,
  });

  Map<String, dynamic> toJson() => {
        "Pueblo_ide": puebloIde,
        "Departamento_Ide": Departamento_Ide,
        "Descripcion": Descripcion,
      };
}
