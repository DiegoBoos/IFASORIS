import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/costo_desplazamiento_entity.dart';
import '../../../domain/repositories/costo_desplazamiento/costo_desplazamiento_repository_db.dart';
import '../../datasources/local/costo_desplazamiento_local_ds.dart';

class CostoDesplazamientoRepositoryDBImpl
    implements CostoDesplazamientoRepositoryDB {
  final CostoDesplazamientoLocalDataSource costoDesplazamientoLocalDataSource;

  CostoDesplazamientoRepositoryDBImpl(
      {required this.costoDesplazamientoLocalDataSource});

  @override
  Future<Either<Failure, List<CostoDesplazamientoEntity>>>
      getCostosDesplazamientoRepositoryDB() async {
    try {
      final result =
          await costoDesplazamientoLocalDataSource.getCostosDesplazamiento();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveCostoDesplazamientoRepositoryDB(
      CostoDesplazamientoEntity costoDesplazamiento) async {
    try {
      final result = await costoDesplazamientoLocalDataSource
          .saveCostoDesplazamiento(costoDesplazamiento);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
