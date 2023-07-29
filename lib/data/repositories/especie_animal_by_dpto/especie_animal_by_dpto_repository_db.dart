import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/especie_animal_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/especie_animal_entity.dart';
import '../../../domain/repositories/especie_animal_by_dpto/especie_animal_by_dpto_repository_db.dart';
import '../../datasources/local/especie_animal_by_dpto_local_ds.dart';

class EspecieAnimalByDptoRepositoryDBImpl
    implements EspecieAnimalByDptoRepositoryDB {
  final EspecieAnimalByDptoLocalDataSource especieAnimalByDptoLocalDataSource;

  EspecieAnimalByDptoRepositoryDBImpl(
      {required this.especieAnimalByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<EspecieAnimalEntity>>>
      getEspeciesAnimalesByDptoRepositoryDB() async {
    try {
      final result =
          await especieAnimalByDptoLocalDataSource.getEspeciesAnimalesByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEspecieAnimalByDptoRepositoryDB(
      EspecieAnimalEntity especieAnimal) async {
    try {
      final result = await especieAnimalByDptoLocalDataSource
          .saveEspecieAnimalByDpto(especieAnimal);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionEspecieAnimalesCriaRepositoryDB(
      int ubicacionId, List<LstAnimalCria> lstAnimalCria) async {
    try {
      final result = await especieAnimalByDptoLocalDataSource
          .saveUbicacionEspecieAnimalesCria(ubicacionId, lstAnimalCria);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstAnimalCria>>>
      getUbicacionEspeciesAnimalesRepositoryDB(int? ubicacionId) async {
    try {
      final result = await especieAnimalByDptoLocalDataSource
          .getAsp1EspeciesAnimales(ubicacionId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
