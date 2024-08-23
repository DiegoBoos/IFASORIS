import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/autoridad_indigena.dart';
import '../../../domain/repositories/autoridad_indigena/autoridad_indigena_repository_db.dart';
import '../../datasources/local/autoridad_indigena_local_ds.dart';
import '../../models/autoridad_indigena.dart';

class AutoridadIndigenaRepositoryDBImpl
    implements AutoridadIndigenaRepositoryDB {
  final AutoridadIndigenaLocalDataSource autoridadIndigenaLocalDataSource;

  AutoridadIndigenaRepositoryDBImpl(
      {required this.autoridadIndigenaLocalDataSource});

  @override
  Future<Either<Failure, List<AutoridadIndigenaModel>>>
      getAutoridadesIndigenasRepositoryDB() async {
    try {
      final result =
          await autoridadIndigenaLocalDataSource.getAutoridadesIndigenas();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveAutoridadIndigenaRepositoryDB(
      AutoridadIndigenaEntity autoridadIndigena) async {
    try {
      final autoridadIndigenaModel =
          AutoridadIndigenaModel.fromEntity(autoridadIndigena);
      final result = await autoridadIndigenaLocalDataSource
          .saveAutoridadIndigena(autoridadIndigenaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
