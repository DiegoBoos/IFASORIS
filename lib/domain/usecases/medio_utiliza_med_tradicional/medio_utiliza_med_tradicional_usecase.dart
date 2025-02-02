import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_utiliza_med_tradicional.dart';
import '../../repositories/medio_utiliza_med_tradicional/medio_utiliza_med_tradicional_repository.dart';

class MedioUtilizaMedTradicionalUsecase {
  final MedioUtilizaMedTradicionalRepository repository;

  MedioUtilizaMedTradicionalUsecase(this.repository);

  Future<Either<Failure, List<MedioUtilizaMedTradicionalEntity>>>
      getMediosUtilizaMedTradicionalUsecase(int dtoId) {
    return repository.getMediosUtilizaMedTradicionalRepository(dtoId);
  }
}
