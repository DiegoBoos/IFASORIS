import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dificultad_acceso_ca_entity.dart';

abstract class DificultadAccesoCARepositoryDB {
  Future<Either<Failure, int>> saveDificultadAccesoCARepositoryDB(
      DificultadAccesoCAEntity dificultadAccesoCA);

  Future<Either<Failure, List<DificultadAccesoCAEntity>>>
      getDificultadesAccesoCARepositoryDB();
}
