import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_comunicacion_entity.dart';

abstract class MedioComunicacionRepositoryDB {
  Future<Either<Failure, int>> saveMedioComunicacionRepositoryDB(
      MedioComunicacionEntity medioComunicacion);

  Future<Either<Failure, List<MedioComunicacionEntity>>>
      getMediosComunicacionRepositoryDB();
}
