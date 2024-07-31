import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/genero.dart';

abstract class GeneroRepositoryDB {
  Future<Either<Failure, int>> saveGeneroRepositoryDB(GeneroEntity genero);

  Future<Either<Failure, List<GeneroEntity>>> getGenerosRepositoryDB();
}
