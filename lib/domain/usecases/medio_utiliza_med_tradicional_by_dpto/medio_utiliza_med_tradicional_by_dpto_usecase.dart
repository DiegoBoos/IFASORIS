import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_utiliza_med_tradicional_entity.dart';
import '../../repositories/medio_utiliza_med_tradicional_by_dpto/medio_utiliza_med_tradicional_by_dpto_repository.dart';

class MedioUtilizaMedTradicionalByDptoUsecase {
  final MedioUtilizaMedTradicionalByDptoRepository repository;

  MedioUtilizaMedTradicionalByDptoUsecase(this.repository);

  Future<Either<Failure, List<MedioUtilizaMedTradicionalEntity>>>
      getMediosUtilizaMedTradicionalByDptoUsecase(int dtoId) {
    return repository.getMediosUtilizaMedTradicionalByDptoRepository(dtoId);
  }
}
