import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/ultima_vez_inst_salud.dart';

abstract class UltimaVezInstSaludRepositoryDB {
  Future<Either<Failure, int>> saveUltimaVezInstSaludRepositoryDB(
      UltimaVezInstSaludEntity ultimaVezInstSalud);

  Future<Either<Failure, List<UltimaVezInstSaludEntity>>>
      getUltimasVecesInstSaludRepositoryDB();
}
