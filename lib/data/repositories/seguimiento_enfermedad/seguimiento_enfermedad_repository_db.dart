import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/seguimiento_enfermedad_entity.dart';
import '../../../domain/repositories/seguimiento_enfermedad/seguimiento_enfermedad_repository_db.dart';
import '../../datasources/local/seguimiento_enfermedad_local_ds.dart';

class SeguimientoEnfermedadRepositoryDBImpl
    implements SeguimientoEnfermedadRepositoryDB {
  final SeguimientoEnfermedadLocalDataSource
      seguimientoEnfermedadLocalDataSource;

  SeguimientoEnfermedadRepositoryDBImpl(
      {required this.seguimientoEnfermedadLocalDataSource});

  @override
  Future<Either<Failure, List<SeguimientoEnfermedadEntity>>>
      getSeguimientoEnfermedadesRepositoryDB() async {
    try {
      final result = await seguimientoEnfermedadLocalDataSource
          .getSeguimientoEnfermedades();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveSeguimientoEnfermedadRepositoryDB(
      SeguimientoEnfermedadEntity seguimientoEnfermedad) async {
    try {
      final result = await seguimientoEnfermedadLocalDataSource
          .saveSeguimientoEnfermedad(seguimientoEnfermedad);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
