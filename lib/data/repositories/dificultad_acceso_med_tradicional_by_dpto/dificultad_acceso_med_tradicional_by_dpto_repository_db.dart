import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/dificultad_acceso_med_tradicional_entity.dart';
import '../../../domain/repositories/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_repository_db.dart';
import '../../datasources/local/dificultad_acceso_med_tradicional_by_dpto_local_ds.dart';

class DificultadAccesoMedTradicionalByDptoRepositoryDBImpl
    implements DificultadAccesoMedTradicionalByDptoRepositoryDB {
  final DificultadAccesoMedTradicionalByDptoLocalDataSource
      dificultadAccesoMedTradicionalByDptoLocalDataSource;

  DificultadAccesoMedTradicionalByDptoRepositoryDBImpl(
      {required this.dificultadAccesoMedTradicionalByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<DificultadAccesoMedTradicionalEntity>>>
      getDificultadesAccesoMedTradicionalByDptoRepositoryDB() async {
    try {
      final result = await dificultadAccesoMedTradicionalByDptoLocalDataSource
          .getDificultadesAccesoMedTradicionalByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      saveDificultadAccesoMedTradicionalByDptoRepositoryDB(
          DificultadAccesoMedTradicionalEntity
              dificultadAccesoMedTradicionalByDpto) async {
    try {
      final result = await dificultadAccesoMedTradicionalByDptoLocalDataSource
          .saveDificultadAccesoMedTradicionalByDpto(
              dificultadAccesoMedTradicionalByDpto);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
