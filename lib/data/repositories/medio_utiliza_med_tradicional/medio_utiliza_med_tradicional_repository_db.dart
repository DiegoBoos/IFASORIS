import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/medio_utiliza_med_tradicional_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/medio_utiliza_med_tradicional_entity.dart';
import '../../../domain/repositories/medio_utiliza_med_tradicional/medio_utiliza_med_tradicional_repository_db.dart';
import '../../datasources/local/medio_utiliza_med_tradicional_local_ds.dart';

class MedioUtilizaMedTradicionalRepositoryDBImpl
    implements MedioUtilizaMedTradicionalRepositoryDB {
  final MedioUtilizaMedTradicionalLocalDataSource
      medioUtilizaMedTradicionalLocalDataSource;

  MedioUtilizaMedTradicionalRepositoryDBImpl(
      {required this.medioUtilizaMedTradicionalLocalDataSource});

  @override
  Future<Either<Failure, List<MedioUtilizaMedTradicionalEntity>>>
      getMediosUtilizaMedTradicionalRepositoryDB() async {
    try {
      final result = await medioUtilizaMedTradicionalLocalDataSource
          .getMediosUtilizaMedTradicional();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveMedioUtilizaMedTradicionalRepositoryDB(
      MedioUtilizaMedTradicionalEntity medioUtilizaMedTradicional) async {
    try {
      final result = await medioUtilizaMedTradicionalLocalDataSource
          .saveMedioUtilizaMedTradicional(medioUtilizaMedTradicional);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionMediosMedTradicionalRepositoryDB(
      int ubicacionId,
      List<LstMediosMedTradicional> lstMediosMedTradicional) async {
    try {
      final result = await medioUtilizaMedTradicionalLocalDataSource
          .saveUbicacionMediosMedTradicional(
              ubicacionId, lstMediosMedTradicional);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstMediosMedTradicional>>>
      getUbicacionMediosUtilizaMedTradicionalRepositoryDB(
          int? ubicacionId) async {
    try {
      final result = await medioUtilizaMedTradicionalLocalDataSource
          .getUbicacionMediosUtilizaMedTradicional(ubicacionId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
