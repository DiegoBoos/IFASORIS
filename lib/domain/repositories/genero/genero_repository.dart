import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/genero.dart';

abstract class GeneroRepository {
  Future<Either<Failure, List<GeneroEntity>>> getGenerosRepository();
}
