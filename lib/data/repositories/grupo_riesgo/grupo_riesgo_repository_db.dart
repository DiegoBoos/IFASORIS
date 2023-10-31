import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/grupo_riesgo_entity.dart';
import '../../../domain/repositories/grupo_riesgo/grupo_riesgo_repository_db.dart';
import '../../datasources/local/grupo_riesgo_local_ds.dart';

class GrupoRiesgoRepositoryDBImpl implements GrupoRiesgoRepositoryDB {
  final GrupoRiesgoLocalDataSource grupoRiesgoLocalDataSource;

  GrupoRiesgoRepositoryDBImpl({required this.grupoRiesgoLocalDataSource});

  @override
  Future<Either<Failure, List<GrupoRiesgoEntity>>>
      getGruposRiesgoRepositoryDB() async {
    try {
      final result = await grupoRiesgoLocalDataSource.getGruposRiesgo();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveGrupoRiesgoRepositoryDB(
      GrupoRiesgoEntity grupoRiesgo) async {
    try {
      final result =
          await grupoRiesgoLocalDataSource.saveGrupoRiesgo(grupoRiesgo);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
