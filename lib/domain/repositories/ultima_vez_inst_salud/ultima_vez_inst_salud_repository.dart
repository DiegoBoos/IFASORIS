import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/ultima_vez_inst_salud_entity.dart';

abstract class UltimaVezInstSaludRepository {
  Future<Either<Failure, List<UltimaVezInstSaludEntity>>>
      getUltimasVecesInstSaludRepository();
}
