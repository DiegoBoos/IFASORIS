import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/estilo_vida_saludable_entity.dart';

import '../../../core/error/failure.dart';

abstract class EstiloVidaSaludableRepositoryDB {
  Future<Either<Failure, int>> saveEstiloVidaSaludableRepositoryDB(
      EstiloVidaSaludableEntity estiloVidaSaludable);

  Future<Either<Failure, EstiloVidaSaludableEntity?>>
      getEstiloVidaSaludableRepositoryDB(int afiliadoId);
}
