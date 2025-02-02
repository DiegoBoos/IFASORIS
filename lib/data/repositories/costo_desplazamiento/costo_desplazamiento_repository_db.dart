import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/costo_desplazamiento.dart';
import '../../../domain/repositories/costo_desplazamiento/costo_desplazamiento_repository_db.dart';
import '../../datasources/local/costo_desplazamiento_local_ds.dart';
import '../../models/costo_desplazamiento.dart';

class CostoDesplazamientoRepositoryDBImpl
    implements CostoDesplazamientoRepositoryDB {
  final CostoDesplazamientoLocalDataSource costoDesplazamientoLocalDataSource;

  CostoDesplazamientoRepositoryDBImpl(
      {required this.costoDesplazamientoLocalDataSource});

  @override
  Future<Either<Failure, List<CostoDesplazamientoModel>>>
      getCostosDesplazamientoRepositoryDB() async {
    try {
      final result =
          await costoDesplazamientoLocalDataSource.getCostosDesplazamiento();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveCostoDesplazamientoRepositoryDB(
      CostoDesplazamientoEntity costoDesplazamiento) async {
    try {
      final costoDesplazamientoModel =
          CostoDesplazamientoModel.fromEntity(costoDesplazamiento);
      final result = await costoDesplazamientoLocalDataSource
          .saveCostoDesplazamiento(costoDesplazamientoModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
