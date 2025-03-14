import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/sync_log_entity.dart';
import '../../../domain/repositories/sync_log/sync_log_repository_db.dart';
import '../../datasources/local/sync_log_local_ds.dart';

class SyncLogRepositoryDBImpl implements SyncLogRepositoryDB {
  final SyncLogLocalDataSource syncLogLocalDataSource;

  SyncLogRepositoryDBImpl({required this.syncLogLocalDataSource});

  @override
  Future<Either<Failure, List<SyncLogEntity>>> getSyncLogsRepositoryDB() async {
    try {
      final result = await syncLogLocalDataSource.getSyncLogsDB();

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> forceSyncRepositoryDB(
      List<SyncLogEntity> syncLogEntity) async {
    try {
      final result = await syncLogLocalDataSource.forceSyncDB(syncLogEntity);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
