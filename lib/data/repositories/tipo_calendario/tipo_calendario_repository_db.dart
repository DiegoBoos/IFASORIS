import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tipo_calendario.dart';
import '../../../domain/repositories/tipo_calendario/tipo_calendario_repository_db.dart';
import '../../datasources/local/tipo_calendario_local_ds.dart';
import '../../models/tipo_calendario.dart';

class TipoCalendarioRepositoryDBImpl implements TipoCalendarioRepositoryDB {
  final TipoCalendarioLocalDataSource tipoCalendarioLocalDataSource;

  TipoCalendarioRepositoryDBImpl({required this.tipoCalendarioLocalDataSource});

  @override
  Future<Either<Failure, List<TipoCalendarioModel>>>
      getTiposCalendarioRepositoryDB() async {
    try {
      final result = await tipoCalendarioLocalDataSource.getTiposCalendario();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveTipoCalendarioRepositoryDB(
      TipoCalendarioEntity tipoCalendario) async {
    try {
      final tipoCalendarioModel =
          TipoCalendarioModel.fromEntity(tipoCalendario);
      final result = await tipoCalendarioLocalDataSource
          .saveTipoCalendario(tipoCalendarioModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
