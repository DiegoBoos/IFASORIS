import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/estilo_vida_saludable_entity.dart';
import '../../../domain/repositories/estilo_vida_saludable/estilo_vida_saludable_repository_db.dart';
import '../../datasources/local/estilo_vida_saludable_local_ds.dart';

class EstiloVidaSaludableRepositoryDBImpl
    implements EstiloVidaSaludableRepositoryDB {
  final EstiloVidaSaludableLocalDataSource estiloVidaSaludableLocalDataSource;

  EstiloVidaSaludableRepositoryDBImpl(
      {required this.estiloVidaSaludableLocalDataSource});

  @override
  Future<Either<Failure, int>> saveEstiloVidaSaludableRepositoryDB(
      EstiloVidaSaludableEntity estiloVidaSaludable) async {
    try {
      final result = await estiloVidaSaludableLocalDataSource
          .saveEstiloVidaSaludable(estiloVidaSaludable);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, EstiloVidaSaludableEntity?>>
      getEstiloVidaSaludableRepositoryDB(int afiliadoId) async {
    try {
      final result = await estiloVidaSaludableLocalDataSource
          .getEstiloVidaSaludable(afiliadoId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
