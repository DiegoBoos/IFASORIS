import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../../domain/repositories/grupo_familiar/grupo_familiar_repository_db.dart';
import '../../datasources/local/grupo_familiar_local_ds.dart';

class GrupoFamiliarRepositoryDBImpl implements GrupoFamiliarRepositoryDB {
  final GrupoFamiliarLocalDataSource grupoFamiliarLocalDataSource;

  GrupoFamiliarRepositoryDBImpl({required this.grupoFamiliarLocalDataSource});

  @override
  Future<Either<Failure, Map<String, dynamic>>>
      saveAfiliadoGrupoFamiliarRepositoryDB(
          GrupoFamiliarEntity afiliadoGrupoFamiliar) async {
    try {
      final result = await grupoFamiliarLocalDataSource
          .saveGrupoFamiliar(afiliadoGrupoFamiliar);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<GrupoFamiliarEntity>>>
      getGrupoFamiliarRepositoryDB(int familiaId) async {
    try {
      final result =
          await grupoFamiliarLocalDataSource.getGrupoFamiliar(familiaId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> deleteAfiliadoGrupoFamiliarRepositoryDB(
      int afiliadoId, int familiaId) async {
    try {
      final result = await grupoFamiliarLocalDataSource
          .deleteAfiliadoGrupoFamiliar(afiliadoId, familiaId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> completeGrupoFamiliarRepositoryDB(
      int familiaId) async {
    try {
      final result =
          await grupoFamiliarLocalDataSource.completeGrupoFamiliar(familiaId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
