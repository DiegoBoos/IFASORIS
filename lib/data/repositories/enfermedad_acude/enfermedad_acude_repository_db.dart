import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/enfermedad_acude.dart';
import '../../../domain/repositories/enfermedad_acude/enfermedad_acude_repository_db.dart';
import '../../datasources/local/enfermedad_acude_local_ds.dart';
import '../../models/enfermedad_acude.dart';

class EnfermedadAcudeRepositoryDBImpl implements EnfermedadAcudeRepositoryDB {
  final EnfermedadAcudeLocalDataSource enfermedadAcudeLocalDataSource;

  EnfermedadAcudeRepositoryDBImpl(
      {required this.enfermedadAcudeLocalDataSource});

  @override
  Future<Either<Failure, List<EnfermedadAcudeModel>>>
      getEnfermedadesAcudeRepositoryDB() async {
    try {
      final result =
          await enfermedadAcudeLocalDataSource.getEnfermedadesAcude();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEnfermedadAcudeRepositoryDB(
      EnfermedadAcudeEntity enfermedadAcude) async {
    try {
      final enfermedadAcudeModel =
          EnfermedadAcudeModel.fromEntity(enfermedadAcude);
      final result = await enfermedadAcudeLocalDataSource
          .saveEnfermedadAcude(enfermedadAcudeModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
