import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/via_acceso_entity.dart';

abstract class ViaAccesoRepositoryDB {
  Future<Either<Failure, int>> saveViaAccesoRepositoryDB(
      ViaAccesoEntity viaAcceso);

  Future<Either<Failure, List<ViaAccesoEntity>>> getViasAccesoRepositoryDB();
}
