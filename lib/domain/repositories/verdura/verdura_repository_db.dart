import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/verdura.dart';

import '../../../core/error/failure.dart';
import '../../entities/verdura.dart';

abstract class VerduraRepositoryDB {
  Future<Either<Failure, int>> saveVerduraRepositoryDB(VerduraEntity verdura);

  Future<Either<Failure, List<VerduraEntity>>> getVerdurasRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionVerdurasRepositoryDB(
      int ubicacionId, List<LstVerdura> lstVerduras);

  Future<Either<Failure, List<LstVerdura>>> getUbicacionVerdurasRepositoryDB(
      int? ubicacionId);
}
