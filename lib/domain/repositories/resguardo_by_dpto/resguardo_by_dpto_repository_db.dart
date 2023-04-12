import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/resguardo_entity.dart';

abstract class ResguardoByDptoRepositoryDB {
  Future<Either<Failure, int>> saveResguardoByDptoRepositoryDB(
      ResguardoEntity resguardo);

  Future<Either<Failure, List<ResguardoEntity>>>
      getResguardosByDptoRepositoryDB();
}
