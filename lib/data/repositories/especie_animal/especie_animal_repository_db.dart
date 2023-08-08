import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/especie_animal_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/especie_animal_entity.dart';
import '../../../domain/repositories/especie_animal/especie_animal_repository_db.dart';
import '../../datasources/local/especie_animal_local_ds.dart';

class EspecieAnimalRepositoryDBImpl implements EspecieAnimalRepositoryDB {
  final EspecieAnimalLocalDataSource especieAnimalLocalDataSource;

  EspecieAnimalRepositoryDBImpl({required this.especieAnimalLocalDataSource});

  @override
  Future<Either<Failure, List<EspecieAnimalEntity>>>
      getEspeciesAnimalesRepositoryDB() async {
    try {
      final result = await especieAnimalLocalDataSource.getEspeciesAnimales();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEspecieAnimalRepositoryDB(
      EspecieAnimalEntity especieAnimal) async {
    try {
      final result =
          await especieAnimalLocalDataSource.saveEspecieAnimal(especieAnimal);
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
      final result = await especieAnimalLocalDataSource
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
      final result = await especieAnimalLocalDataSource
          .getAsp1EspeciesAnimales(ubicacionId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
