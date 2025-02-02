import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/enfermedad_tratamiento.dart';

abstract class EnfermedadTratamientoRepositoryDB {
  Future<Either<Failure, int>> saveEnfermedadTratamientoRepositoryDB(
      EnfermedadTratamientoEntity enfermedadTratamiento);

  Future<Either<Failure, List<EnfermedadTratamientoEntity>>>
      getEnfermedadesTratamientoRepositoryDB();
}
