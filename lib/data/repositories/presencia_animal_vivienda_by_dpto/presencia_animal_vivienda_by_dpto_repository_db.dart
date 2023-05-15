import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/presencia_animal_vivienda_entity.dart';
import '../../../domain/repositories/presencia_animal_vivienda_by_dpto/presencia_animal_vivienda_by_dpto_repository_db.dart';
import '../../datasources/local/presencia_animal_vivienda_by_dpto_local_ds.dart';

class PresenciaAnimalViviendaByDptoRepositoryDBImpl
    implements PresenciaAnimalViviendaByDptoRepositoryDB {
  final PresenciaAnimalViviendaByDptoLocalDataSource
      presenciaAnimalViviendaByDptoLocalDataSource;

  PresenciaAnimalViviendaByDptoRepositoryDBImpl(
      {required this.presenciaAnimalViviendaByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<PresenciaAnimalViviendaEntity>>>
      getPresenciaAnimalesViviendaByDptoRepositoryDB() async {
    try {
      final result = await presenciaAnimalViviendaByDptoLocalDataSource
          .getPresenciaAnimalesViviendaByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePresenciaAnimalViviendaByDptoRepositoryDB(
      PresenciaAnimalViviendaEntity presenciaAnimalViviendaByDpto) async {
    try {
      final result = await presenciaAnimalViviendaByDptoLocalDataSource
          .savePresenciaAnimalViviendaByDpto(presenciaAnimalViviendaByDpto);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
