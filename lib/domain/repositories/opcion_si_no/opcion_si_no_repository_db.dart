import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/opcion_si_no.dart';

abstract class OpcionSiNoRepositoryDB {
  Future<Either<Failure, int>> saveOpcionSiNoRepositoryDB(
      OpcionSiNoEntity opcionSiNo);

  Future<Either<Failure, List<OpcionSiNoEntity>>> getOpcionesSiNoRepositoryDB();
}
