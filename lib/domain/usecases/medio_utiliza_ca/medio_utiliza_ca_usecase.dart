import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_utiliza_ca_entity.dart';
import '../../repositories/medio_utiliza_ca/medio_utiliza_ca_repository.dart';

class MedioUtilizaCAUsecase {
  final MedioUtilizaCARepository repository;

  MedioUtilizaCAUsecase(this.repository);

  Future<Either<Failure, List<MedioUtilizaCAEntity>>>
      getMediosUtilizaCAUsecase() {
    return repository.getMediosUtilizaCARepository();
  }
}
