import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_utiliza_med_tradicional_by_dpto_entity.dart';

abstract class MedioUtilizaMedTradicionalByDptoRepositoryDB {
  Future<Either<Failure, int>> saveMedioUtilizaMedTradicionalByDptoRepositoryDB(
      MedioUtilizaMedTradicionalByDptoEntity medioUtilizaMedTradicionalByDpto);

  Future<Either<Failure, List<MedioUtilizaMedTradicionalByDptoEntity>>>
      getMediosUtilizaMedTradicionalByDptoRepositoryDB(int dtoId);
}
