import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/religion_profesa_entity.dart';
import '../../../domain/repositories/religion_profesa/religion_profesa_repository_db.dart';
import '../../datasources/local/religion_profesa_local_ds.dart';

class ReligionProfesaRepositoryDBImpl implements ReligionProfesaRepositoryDB {
  final ReligionProfesaLocalDataSource religionProfesaLocalDataSource;

  ReligionProfesaRepositoryDBImpl(
      {required this.religionProfesaLocalDataSource});

  @override
  Future<Either<Failure, List<ReligionProfesaEntity>>>
      getReligionesProfesaRepositoryDB() async {
    try {
      final result =
          await religionProfesaLocalDataSource.getReligionesProfesa();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveReligionProfesaRepositoryDB(
      ReligionProfesaEntity religionProfesa) async {
    try {
      final result = await religionProfesaLocalDataSource
          .saveReligionProfesa(religionProfesa);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
