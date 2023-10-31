import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/medio_comunicacion_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/medio_comunicacion_entity.dart';
import '../../../domain/repositories/medio_comunicacion/medio_comunicacion_repository_db.dart';
import '../../datasources/local/medio_comunicacion_local_ds.dart';

class MedioComunicacionRepositoryDBImpl
    implements MedioComunicacionRepositoryDB {
  final MedioComunicacionLocalDataSource medioComunicacionLocalDataSource;

  MedioComunicacionRepositoryDBImpl(
      {required this.medioComunicacionLocalDataSource});

  @override
  Future<Either<Failure, List<MedioComunicacionEntity>>>
      getMediosComunicacionRepositoryDB() async {
    try {
      final result =
          await medioComunicacionLocalDataSource.getMediosComunicacion();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveMedioComunicacionRepositoryDB(
      MedioComunicacionEntity medioComunicacion) async {
    try {
      final result = await medioComunicacionLocalDataSource
          .saveMedioComunicacion(medioComunicacion);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionMediosComunicacionRepositoryDB(
      int ubicacionId, List<LstMediosComunica> lstMediosComunica) async {
    try {
      final result = await medioComunicacionLocalDataSource
          .saveUbicacionMediosComunicacion(ubicacionId, lstMediosComunica);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstMediosComunica>>>
      getUbicacionMediosComunicacionRepositoryDB(int? ubicacionId) async {
    try {
      final result = await medioComunicacionLocalDataSource
          .getUbicacionMediosComunicacion(ubicacionId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
