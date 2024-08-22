import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/tipo_regimen.dart';
import '../../../domain/repositories/tipo_regimen/tipo_regimen_repository_db.dart';
import '../../datasources/local/tipo_regimen_local_ds.dart';
import '../../models/tipo_regimen.dart';

class TipoRegimenRepositoryDBImpl implements TipoRegimenRepositoryDB {
  final TipoRegimenLocalDataSource tipoRegimenLocalDataSource;

  TipoRegimenRepositoryDBImpl({required this.tipoRegimenLocalDataSource});

  @override
  Future<Either<Failure, List<TipoRegimenModel>>>
      getTipoRegimenesRepositoryDB() async {
    try {
      final result = await tipoRegimenLocalDataSource.getTipoRegimenes();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTipoRegimenRepositoryDB(
      TipoRegimenEntity tiporegimen) async {
    try {
      final tiporegimenModel = TipoRegimenModel.fromEntity(tiporegimen);
      final result =
          await tipoRegimenLocalDataSource.saveTipoRegimen(tiporegimenModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
