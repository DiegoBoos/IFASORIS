import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_utiliza_med_tradicional_by_dpto_entity.dart';

abstract class MedioUtilizaMedTradicionalByDptoRepository {
  Future<Either<Failure, List<MedioUtilizaMedTradicionalByDptoEntity>>>
      getMediosUtilizaMedTradicionalByDptoRepository(int dtoId);
}
