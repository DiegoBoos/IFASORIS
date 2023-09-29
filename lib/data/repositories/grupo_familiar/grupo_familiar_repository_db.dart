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
  Future<Either<Failure, int>> saveGrupoFamiliarRepositoryDB(
      List<GrupoFamiliarEntity> afiliadosGrupoFamiliar) async {
    try {
      final result = await grupoFamiliarLocalDataSource
          .saveGrupoFamiliar(afiliadosGrupoFamiliar);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<GrupoFamiliarEntity>>>
      getGrupoFamiliarRepositoryDB(int familiaId) async {
    try {
      final result =
          await grupoFamiliarLocalDataSource.getGrupoFamiliar(familiaId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> deleteAfiliadoGrupoFamiliarRepositoryDB(
      int afiliadoId) async {
    try {
      final result = await grupoFamiliarLocalDataSource
          .deleteAfiliadoGrupoFamiliar(afiliadoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> existeAfiliadoGrupoFamiliarRepositoryDB(
      int afiliadoId) async {
    try {
      final result = await grupoFamiliarLocalDataSource
          .existeAfiliadoGrupoFamiliar(afiliadoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
