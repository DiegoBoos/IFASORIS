import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/esquema_vacunacion.dart';

abstract class EsquemaVacunacionRepositoryDB {
  Future<Either<Failure, int>> saveEsquemaVacunacionRepositoryDB(
      EsquemaVacunacionEntity esquemaVacunacion);

  Future<Either<Failure, List<EsquemaVacunacionEntity>>>
      getEsquemasVacunacionRepositoryDB();
}
