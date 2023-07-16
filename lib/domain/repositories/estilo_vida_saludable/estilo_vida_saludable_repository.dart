import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/estilo_vida_saludable_entity.dart';

abstract class EstiloVidaSaludableRepository {
  Future<Either<Failure, EstiloVidaSaludableEntity>>
      uploadEstiloVidaSaludableRepository();
}
