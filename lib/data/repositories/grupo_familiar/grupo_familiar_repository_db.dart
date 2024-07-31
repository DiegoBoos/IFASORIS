import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/grupo_familiar.dart';
import '../../../domain/repositories/grupo_familiar/grupo_familiar_repository_db.dart';
import '../../datasources/local/grupo_familiar_local_ds.dart';
import '../../models/grupo_familiar.dart';

class GrupoFamiliarRepositoryDBImpl implements GrupoFamiliarRepositoryDB {
  final GrupoFamiliarLocalDataSource grupoFamiliarLocalDataSource;

  GrupoFamiliarRepositoryDBImpl({required this.grupoFamiliarLocalDataSource});

  @override
  Future<Either<Failure, GrupoFamiliarModel>>
      saveAfiliadoGrupoFamiliarRepositoryDB(
          GrupoFamiliarEntity afiliadoGrupoFamiliar) async {
    try {
      final afiliadoGrupoFamiliarModel =
          GrupoFamiliarModel.fromEntity(afiliadoGrupoFamiliar);
      final result = await grupoFamiliarLocalDataSource
          .saveGrupoFamiliar(afiliadoGrupoFamiliarModel);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<GrupoFamiliarModel>>>
      getGrupoFamiliarRepositoryDB(int familiaId) async {
    try {
      final result =
          await grupoFamiliarLocalDataSource.getGrupoFamiliar(familiaId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
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
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> completeGrupoFamiliarRepositoryDB(
      int afiliado) async {
    try {
      final result =
          await grupoFamiliarLocalDataSource.completeGrupoFamiliar(afiliado);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, bool>> existeAfiliadoCabezaFamiliaRepositoryDB(
      int afiliadoId) async {
    try {
      final result = await grupoFamiliarLocalDataSource
          .existeAfiliadoCabezaFamilia(afiliadoId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
