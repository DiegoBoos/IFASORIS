import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/verdura_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/verdura_entity.dart';

abstract class VerduraByDptoRepositoryDB {
  Future<Either<Failure, int>> saveVerduraByDptoRepositoryDB(
      VerduraEntity verdura);

  Future<Either<Failure, List<VerduraEntity>>> getVerdurasByDptoRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionVerdurasRepositoryDB(
      int ubicacionId, List<LstVerdura> lstVerduras);

  Future<Either<Failure, List<LstVerdura>>> getUbicacionVerdurasRepositoryDB(
      int? ubicacionId);
}
