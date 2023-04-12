import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/hortaliza_entity.dart';

abstract class HortalizaByDptoRepositoryDB {
  Future<Either<Failure, int>> saveHortalizaByDptoRepositoryDB(
      HortalizaEntity hortaliza);

  Future<Either<Failure, List<HortalizaEntity>>>
      getHortalizasByDptoRepositoryDB();
}
