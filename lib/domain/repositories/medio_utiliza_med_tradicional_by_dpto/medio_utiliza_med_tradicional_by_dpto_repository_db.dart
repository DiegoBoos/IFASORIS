import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_utiliza_med_tradicional_entity.dart';

abstract class MedioUtilizaMedTradicionalByDptoRepositoryDB {
  Future<Either<Failure, int>> saveMedioUtilizaMedTradicionalByDptoRepositoryDB(
      MedioUtilizaMedTradicionalEntity medioUtilizaMedTradicional);

  Future<Either<Failure, List<MedioUtilizaMedTradicionalEntity>>>
      getMediosUtilizaMedTradicionalByDptoRepositoryDB();
}
