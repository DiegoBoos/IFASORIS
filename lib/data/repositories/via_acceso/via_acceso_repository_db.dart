import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/via_acceso_entity.dart';
import '../../../domain/repositories/via_acceso/via_acceso_repository_db.dart';
import '../../datasources/local/via_acceso_local_ds.dart';

class ViaAccesoRepositoryDBImpl implements ViaAccesoRepositoryDB {
  final ViaAccesoLocalDataSource viaAccesoLocalDataSource;

  ViaAccesoRepositoryDBImpl({required this.viaAccesoLocalDataSource});

  @override
  Future<Either<Failure, List<ViaAccesoEntity>>>
      getViasAccesoRepositoryDB() async {
    try {
      final result = await viaAccesoLocalDataSource.getViasAcceso();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveViaAccesoRepositoryDB(
      ViaAccesoEntity viaAcceso) async {
    try {
      final result = await viaAccesoLocalDataSource.saveViaAcceso(viaAcceso);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
