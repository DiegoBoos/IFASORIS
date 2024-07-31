import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/sync_log.dart';

abstract class SyncLogRepositoryDB {
  Future<Either<Failure, List<SyncLogEntity>>> getSyncLogsRepositoryDB();
  Future<Either<Failure, int>> forceSyncRepositoryDB(
      List<SyncLogEntity> syncLogs);
}
