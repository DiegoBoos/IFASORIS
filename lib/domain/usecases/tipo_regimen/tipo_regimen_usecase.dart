import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_regimen.dart';
import '../../repositories/tipo_regimen/tipo_regimen_repository.dart';

class TipoRegimenUsecase {
  final TipoRegimenRepository repository;

  TipoRegimenUsecase(this.repository);

  Future<Either<Failure, List<TipoRegimenEntity>>> getTipoRegimenesUsecase() {
    return repository.getTipoRegimenesRepository();
  }
}
