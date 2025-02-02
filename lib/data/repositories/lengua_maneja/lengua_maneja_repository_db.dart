import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/lengua_maneja.dart';
import '../../../domain/repositories/lengua_maneja/lengua_maneja_repository_db.dart';
import '../../datasources/local/lengua_maneja_local_ds.dart';
import '../../models/lengua_maneja.dart';

class LenguaManejaRepositoryDBImpl implements LenguaManejaRepositoryDB {
  final LenguaManejaLocalDataSource lenguaManejaLocalDataSource;

  LenguaManejaRepositoryDBImpl({required this.lenguaManejaLocalDataSource});

  @override
  Future<Either<Failure, List<LenguaManejaModel>>>
      getLenguasManejaRepositoryDB() async {
    try {
      final result = await lenguaManejaLocalDataSource.getLenguasManeja();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveLenguaManejaRepositoryDB(
      LenguaManejaEntity lenguaManeja) async {
    try {
      final lenguaManejaModel = LenguaManejaModel.fromEntity(lenguaManeja);
      final result =
          await lenguaManejaLocalDataSource.saveLenguaManeja(lenguaManejaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
