import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/seguimiento_enfermedad.dart';
import '../../../domain/repositories/seguimiento_enfermedad/seguimiento_enfermedad_repository_db.dart';
import '../../datasources/local/seguimiento_enfermedad_local_ds.dart';
import '../../models/seguimiento_enfermedad.dart';

class SeguimientoEnfermedadRepositoryDBImpl
    implements SeguimientoEnfermedadRepositoryDB {
  final SeguimientoEnfermedadLocalDataSource
      seguimientoEnfermedadLocalDataSource;

  SeguimientoEnfermedadRepositoryDBImpl(
      {required this.seguimientoEnfermedadLocalDataSource});

  @override
  Future<Either<Failure, List<SeguimientoEnfermedadModel>>>
      getSeguimientoEnfermedadesRepositoryDB() async {
    try {
      final result = await seguimientoEnfermedadLocalDataSource
          .getSeguimientoEnfermedades();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveSeguimientoEnfermedadRepositoryDB(
      SeguimientoEnfermedadEntity seguimientoEnfermedad) async {
    try {
      final seguimientoEnfermedadModel =
          SeguimientoEnfermedadModel.fromEntity(seguimientoEnfermedad);
      final result = await seguimientoEnfermedadLocalDataSource
          .saveSeguimientoEnfermedad(seguimientoEnfermedadModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
