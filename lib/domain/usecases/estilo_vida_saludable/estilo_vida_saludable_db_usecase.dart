import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/estilo_vida_saludable_entity.dart';
import '../../repositories/estilo_vida_saludable/estilo_vida_saludable_repository_db.dart';

class EstiloVidaSaludableUsecaseDB {
  final EstiloVidaSaludableRepositoryDB repositoryDB;

  EstiloVidaSaludableUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveEstiloVidaSaludableUsecaseDB(
      EstiloVidaSaludableEntity estiloVidaSaludable) {
    return repositoryDB
        .saveEstiloVidaSaludableRepositoryDB(estiloVidaSaludable);
  }

  Future<Either<Failure, EstiloVidaSaludableEntity?>>
      getEstiloVidaSaludableUsecaseDB(int afiliadoId) {
    return repositoryDB.getEstiloVidaSaludableRepositoryDB(afiliadoId);
  }
}
