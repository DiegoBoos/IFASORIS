import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/seguimiento_enfermedad_entity.dart';

abstract class SeguimientoEnfermedadRepositoryDB {
  Future<Either<Failure, int>> saveSeguimientoEnfermedadRepositoryDB(
      SeguimientoEnfermedadEntity seguimientoEnfermedad);

  Future<Either<Failure, List<SeguimientoEnfermedadEntity>>>
      getSeguimientoEnfermedadesRepositoryDB();
}
