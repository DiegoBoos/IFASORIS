import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/medio_utiliza_ca.dart';
import '../../../domain/repositories/medio_utiliza_ca/medio_utiliza_ca_repository_db.dart';
import '../../datasources/local/medio_utiliza_ca_local_ds.dart';
import '../../models/medio_utiliza_ca.dart';

class MedioUtilizaCARepositoryDBImpl implements MedioUtilizaCARepositoryDB {
  final MedioUtilizaCALocalDataSource medioUtilizaCALocalDataSource;

  MedioUtilizaCARepositoryDBImpl({required this.medioUtilizaCALocalDataSource});

  @override
  Future<Either<Failure, List<MedioUtilizaCAModel>>>
      getMediosUtilizaCARepositoryDB() async {
    try {
      final result = await medioUtilizaCALocalDataSource.getMediosUtilizaCA();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveMedioUtilizaCARepositoryDB(
      MedioUtilizaCAEntity medioUtilizaCA) async {
    try {
      final medioUtilizaCAModel =
          MedioUtilizaCAModel.fromEntity(medioUtilizaCA);
      final result = await medioUtilizaCALocalDataSource
          .saveMedioUtilizaCA(medioUtilizaCAModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, List<LstMediosUtilizaCA>>>
      getUbicacionMediosUtilizaCARepositoryDB(int? ubicacionId) async {
    try {
      final result = await medioUtilizaCALocalDataSource
          .getUbicacionMediosUtilizaCA(ubicacionId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionMediosUtilizaCARepositoryDB(
      int ubicacionId, List<LstMediosUtilizaCA> lstMediosUtilizaCA) async {
    try {
      final result = await medioUtilizaCALocalDataSource
          .saveUbicacionMediosUtilizaCA(ubicacionId, lstMediosUtilizaCA);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
