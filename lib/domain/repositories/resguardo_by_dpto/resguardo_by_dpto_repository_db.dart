import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/resguardo_by_dpto_entity.dart';

abstract class ResguardoByDptoRepositoryDB {
  Future<Either<Failure, int>> saveResguardoByDptoRepositoryDB(
      ResguardoByDptoEntity resguardoByDpto);

  Future<Either<Failure, List<ResguardoByDptoEntity>>>
      getResguardosByDptoRepositoryDB(int dtoId);
}
