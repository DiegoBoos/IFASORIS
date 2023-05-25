import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tipo_calendario_entity.dart';
import '../../../domain/repositories/tipo_calendario/tipo_calendario_repository_db.dart';
import '../../datasources/local/tipo_calendario_local_ds.dart';

class TipoCalendarioRepositoryDBImpl implements TipoCalendarioRepositoryDB {
  final TipoCalendarioLocalDataSource tipoCalendarioLocalDataSource;

  TipoCalendarioRepositoryDBImpl({required this.tipoCalendarioLocalDataSource});

  @override
  Future<Either<Failure, List<TipoCalendarioEntity>>>
      getTiposCalendarioRepositoryDB() async {
    try {
      final result = await tipoCalendarioLocalDataSource.getTiposCalendario();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTipoCalendarioRepositoryDB(
      TipoCalendarioEntity tipoCalendario) async {
    try {
      final result = await tipoCalendarioLocalDataSource
          .saveTipoCalendario(tipoCalendario);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
