import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/estilo_vida_saludable.dart';
import '../../../domain/repositories/estilo_vida_saludable/estilo_vida_saludable_repository_db.dart';
import '../../datasources/local/estilo_vida_saludable_local_ds.dart';
import '../../models/estilo_vida_saludable.dart';

class EstiloVidaSaludableRepositoryDBImpl
    implements EstiloVidaSaludableRepositoryDB {
  final EstiloVidaSaludableLocalDataSource estiloVidaSaludableLocalDataSource;

  EstiloVidaSaludableRepositoryDBImpl(
      {required this.estiloVidaSaludableLocalDataSource});

  @override
  Future<Either<Failure, int>> saveEstiloVidaSaludableRepositoryDB(
      EstiloVidaSaludableEntity estiloVidaSaludable) async {
    try {
      final estiloVidaSaludableModel =
          EstiloVidaSaludableModel.fromEntity(estiloVidaSaludable);
      final result = await estiloVidaSaludableLocalDataSource
          .saveEstiloVidaSaludable(estiloVidaSaludableModel);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, EstiloVidaSaludableModel?>>
      getEstiloVidaSaludableRepositoryDB(int afiliadoId) async {
    try {
      final result = await estiloVidaSaludableLocalDataSource
          .getEstiloVidaSaludable(afiliadoId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
