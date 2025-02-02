import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/regimen.dart';
import '../../../domain/repositories/regimen/regimen_repository_db.dart';
import '../../datasources/local/regimen_local_ds.dart';
import '../../models/regimen.dart';

class RegimenRepositoryDBImpl implements RegimenRepositoryDB {
  final RegimenLocalDataSource regimenLocalDataSource;

  RegimenRepositoryDBImpl({required this.regimenLocalDataSource});

  @override
  Future<Either<Failure, List<RegimenModel>>> getRegimenesRepositoryDB() async {
    try {
      final result = await regimenLocalDataSource.getRegimenes();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveRegimenRepositoryDB(
      RegimenEntity regimen) async {
    try {
      final regimenModel = RegimenModel.fromEntity(regimen);
      final result = await regimenLocalDataSource.saveRegimen(regimenModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
