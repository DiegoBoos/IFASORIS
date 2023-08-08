import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/nombre_enfermedad_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/nombre_enfermedad_entity.dart';

abstract class NombreEnfermedadRepositoryDB {
  Future<Either<Failure, int>> saveNombreEnfermedadRepositoryDB(
      NombreEnfermedadEntity nombreEnfermedad);

  Future<Either<Failure, List<NombreEnfermedadEntity>>>
      getNombresEnfermedadesRepositoryDB();

  Future<Either<Failure, List<LstNombreEnfermedad>>>
      getLstNombresEnfermedadesRepositoryDB(int? cuidadoSaludCondRiesgoId);

  Future<Either<Failure, int>> saveNombresEnfermedadesRepositoryDB(
      int cuidadoSaludCondRiesgoId,
      List<LstNombreEnfermedad> lstNombresEnfermedades);
}
