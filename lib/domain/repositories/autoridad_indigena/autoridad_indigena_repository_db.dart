import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/autoridad_indigena.dart';

abstract class AutoridadIndigenaRepositoryDB {
  Future<Either<Failure, int>> saveAutoridadIndigenaRepositoryDB(
      AutoridadIndigenaEntity autoridadIndigena);

  Future<Either<Failure, List<AutoridadIndigenaEntity>>>
      getAutoridadesIndigenasRepositoryDB();
}
