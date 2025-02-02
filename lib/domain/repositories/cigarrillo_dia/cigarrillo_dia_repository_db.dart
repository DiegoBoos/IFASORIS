import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cigarrillo_dia.dart';

abstract class CigarrilloDiaRepositoryDB {
  Future<Either<Failure, int>> saveCigarrilloDiaRepositoryDB(
      CigarrilloDiaEntity cigarrilloDia);

  Future<Either<Failure, List<CigarrilloDiaEntity>>>
      getCigarrillosDiaRepositoryDB();
}
