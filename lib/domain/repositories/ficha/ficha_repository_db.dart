import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/ficha_entity.dart';

import '../../../core/error/failure.dart';

abstract class FichaRepositoryDB {
  Future<Either<Failure, FichaEntity?>> createFichaRepositoryDB(
      FichaEntity ficha);
}
