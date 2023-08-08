import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_utiliza_med_tradicional_entity.dart';

abstract class MedioUtilizaMedTradicionalRepository {
  Future<Either<Failure, List<MedioUtilizaMedTradicionalEntity>>>
      getMediosUtilizaMedTradicionalRepository(int dtoId);
}
