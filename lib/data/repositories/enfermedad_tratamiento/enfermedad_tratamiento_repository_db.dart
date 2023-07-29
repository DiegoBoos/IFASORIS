import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/enfermedad_tratamiento_entity.dart';
import '../../../domain/repositories/enfermedad_tratamiento/enfermedad_tratamiento_repository_db.dart';
import '../../datasources/local/enfermedad_tratamiento_local_ds.dart';

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
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEnfermedadTratamientoRepositoryDB(
      EnfermedadTratamientoEntity enfermedadTratamiento) async {
    try {
      final result = await enfermedadTratamientoLocalDataSource
          .saveEnfermedadTratamiento(enfermedadTratamiento);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
