import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/resguardo_entity.dart';

abstract class ResguardoRepositoryDB {
  Future<Either<Failure, int>> saveResguardoRepositoryDB(
      ResguardoEntity resguardo);

  Future<Either<Failure, List<ResguardoEntity>>> getResguardosRepositoryDB();
}
