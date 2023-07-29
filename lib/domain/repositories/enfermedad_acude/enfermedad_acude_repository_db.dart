import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/enfermedad_acude_entity.dart';

abstract class EnfermedadAcudeRepositoryDB {
  Future<Either<Failure, int>> saveEnfermedadAcudeRepositoryDB(
      EnfermedadAcudeEntity enfermedadAcude);

  Future<Either<Failure, List<EnfermedadAcudeEntity>>>
      getEnfermedadesAcudeRepositoryDB();
}
