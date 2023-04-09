import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/autoridad_indigena_entity.dart';
import '../../../domain/repositories/autoridad_indigena/autoridad_indigena_repository_db.dart';
import '../../datasources/local/autoridad_indigena_local_ds.dart';

class AutoridadIndigenaRepositoryDBImpl
    implements AutoridadIndigenaRepositoryDB {
  final AutoridadIndigenaLocalDataSource autoridadIndigenaLocalDataSource;

  AutoridadIndigenaRepositoryDBImpl(
      {required this.autoridadIndigenaLocalDataSource});

  @override
  Future<Either<Failure, List<AutoridadIndigenaEntity>>>
      getAutoridadesIndigenasRepositoryDB() async {
    try {
      final result =
          await autoridadIndigenaLocalDataSource.getAutoridadesIndigenas();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveAutoridadIndigenaRepositoryDB(
      AutoridadIndigenaEntity autoridadIndigena) async {
    try {
      final result = await autoridadIndigenaLocalDataSource
          .saveAutoridadIndigena(autoridadIndigena);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
