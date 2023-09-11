import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/medio_utiliza_ca_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/medio_utiliza_ca_entity.dart';
import '../../../domain/repositories/medio_utiliza_ca/medio_utiliza_ca_repository_db.dart';
import '../../datasources/local/medio_utiliza_ca_local_ds.dart';

class MedioUtilizaCARepositoryDBImpl implements MedioUtilizaCARepositoryDB {
  final MedioUtilizaCALocalDataSource medioUtilizaCALocalDataSource;

  MedioUtilizaCARepositoryDBImpl({required this.medioUtilizaCALocalDataSource});

  @override
  Future<Either<Failure, List<MedioUtilizaCAEntity>>>
      getMediosUtilizaCARepositoryDB() async {
    try {
      final result = await medioUtilizaCALocalDataSource.getMediosUtilizaCA();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveMedioUtilizaCARepositoryDB(
      MedioUtilizaCAEntity medioUtilizaCA) async {
    try {
      final result = await medioUtilizaCALocalDataSource
          .saveMedioUtilizaCA(medioUtilizaCA);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstMediosUtilizaCA>>>
      getUbicacionMediosUtilizaCARepositoryDB(int? ubicacionId) async {
    try {
      final result = await medioUtilizaCALocalDataSource
          .getUbicacionMediosUtilizaCA(ubicacionId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionMediosUtilizaCARepositoryDB(
      int ubicacionId, List<LstMediosUtilizaCA> lstMediosUtilizaCA) async {
    try {
      final result = await medioUtilizaCALocalDataSource
          .saveUbicacionMediosUtilizaCA(ubicacionId, lstMediosUtilizaCA);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
