import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/sync_log.dart';
import '../../../domain/repositories/sync_log/sync_log_repository_db.dart';
import '../../datasources/local/sync_log_local_ds.dart';
import '../../models/sync_log.dart';

class SyncLogRepositoryDBImpl implements SyncLogRepositoryDB {
  final SyncLogLocalDataSource syncLogLocalDataSource;

  SyncLogRepositoryDBImpl({required this.syncLogLocalDataSource});

  @override
  Future<Either<Failure, List<SyncLogModel>>> getSyncLogsRepositoryDB() async {
    try {
      final result = await syncLogLocalDataSource.getSyncLogsDB();

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> forceSyncRepositoryDB(
      List<SyncLogEntity> syncLog) async {
    try {
      final syncLogModel =
          syncLog.map((e) => SyncLogModel.fromEntity(e)).toList();
      final result = await syncLogLocalDataSource.forceSyncDB(syncLogModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
