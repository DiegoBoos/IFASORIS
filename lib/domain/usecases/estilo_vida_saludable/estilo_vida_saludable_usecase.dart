import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/estilo_vida_saludable_entity.dart';
import '../../repositories/estilo_vida_saludable/estilo_vida_saludable_repository.dart';

class EstiloVidaSaludableUsecase {
  final EstiloVidaSaludableRepository repository;

  EstiloVidaSaludableUsecase(this.repository);

  Future<Either<Failure, EstiloVidaSaludableEntity>>
      uploadEstiloVidaSaludableUsecase() {
    return repository.uploadEstiloVidaSaludableRepository();
  }
}
