import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/dificultad_acceso_ca_entity.dart';
import '../../../domain/repositories/dificultad_acceso_ca/dificultad_acceso_ca_repository_db.dart';
import '../../datasources/local/dificultad_acceso_ca_local_ds.dart';

class DificultadAccesoCARepositoryDBImpl
    implements DificultadAccesoCARepositoryDB {
  final DificultadAccesoCALocalDataSource dificultadAccesoCALocalDataSource;

  DificultadAccesoCARepositoryDBImpl(
      {required this.dificultadAccesoCALocalDataSource});

  @override
  Future<Either<Failure, List<DificultadAccesoCAEntity>>>
      getDificultadesAccesoCARepositoryDB() async {
    try {
      final result =
          await dificultadAccesoCALocalDataSource.getDificultadesAccesoCA();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveDificultadAccesoCARepositoryDB(
      DificultadAccesoCAEntity dificultadAccesoCA) async {
    try {
      final result = await dificultadAccesoCALocalDataSource
          .saveDificultadAccesoCA(dificultadAccesoCA);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
