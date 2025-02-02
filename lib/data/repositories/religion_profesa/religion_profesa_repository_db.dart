import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/religion_profesa.dart';
import '../../../domain/repositories/religion_profesa/religion_profesa_repository_db.dart';
import '../../datasources/local/religion_profesa_local_ds.dart';
import '../../models/religion_profesa.dart';

class ReligionProfesaRepositoryDBImpl implements ReligionProfesaRepositoryDB {
  final ReligionProfesaLocalDataSource religionProfesaLocalDataSource;

  ReligionProfesaRepositoryDBImpl(
      {required this.religionProfesaLocalDataSource});

  @override
  Future<Either<Failure, List<ReligionProfesaModel>>>
      getReligionesProfesaRepositoryDB() async {
    try {
      final result =
          await religionProfesaLocalDataSource.getReligionesProfesa();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveReligionProfesaRepositoryDB(
      ReligionProfesaEntity religionProfesa) async {
    try {
      final religionProfesaModel =
          ReligionProfesaModel.fromEntity(religionProfesa);
      final result = await religionProfesaLocalDataSource
          .saveReligionProfesa(religionProfesaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
