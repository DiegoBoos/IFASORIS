import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/lengua_maneja_entity.dart';

abstract class LenguaManejaRepositoryDB {
  Future<Either<Failure, int>> saveLenguaManejaRepositoryDB(
      LenguaManejaEntity lenguaManeja);

  Future<Either<Failure, List<LenguaManejaEntity>>>
      getLenguasManejaRepositoryDB();
}
