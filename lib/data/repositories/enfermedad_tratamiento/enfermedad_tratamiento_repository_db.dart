import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/enfermedad_tratamiento.dart';
import '../../../domain/repositories/enfermedad_tratamiento/enfermedad_tratamiento_repository_db.dart';
import '../../datasources/local/enfermedad_tratamiento_local_ds.dart';
import '../../models/enfermedad_tratamiento.dart';

class EnfermedadTratamientoRepositoryDBImpl
    implements EnfermedadTratamientoRepositoryDB {
  final EnfermedadTratamientoLocalDataSource
      enfermedadTratamientoLocalDataSource;

  EnfermedadTratamientoRepositoryDBImpl(
      {required this.enfermedadTratamientoLocalDataSource});

  @override
  Future<Either<Failure, List<EnfermedadTratamientoEntity>>>
      getEnfermedadesTratamientoRepositoryDB() async {
    try {
      final result = await enfermedadTratamientoLocalDataSource
          .getEnfermedadesTratamiento();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveEnfermedadTratamientoRepositoryDB(
      EnfermedadTratamientoEntity enfermedadTratamiento) async {
    try {
      final enfermedadTratamientoModel =
          EnfermedadTratamientoModel.fromEntity(enfermedadTratamiento);
      final result = await enfermedadTratamientoLocalDataSource
          .saveEnfermedadTratamiento(enfermedadTratamientoModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
