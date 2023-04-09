import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/estado_via_entity.dart';

abstract class EstadoViaRepositoryDB {
  Future<Either<Failure, int>> saveEstadoViaRepositoryDB(
      EstadoViaEntity estadoVia);

  Future<Either<Failure, List<EstadoViaEntity>>> getEstadosViasRepositoryDB();
}
