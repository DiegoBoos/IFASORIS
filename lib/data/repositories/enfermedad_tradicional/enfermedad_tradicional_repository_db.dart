import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/enfermedad_tradicional.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/enfermedad_tradicional.dart';
import '../../../domain/repositories/enfermedad_tradicional/enfermedad_tradicional_repository_db.dart';
import '../../datasources/local/enfermedad_tradicional_local_ds.dart';

class EnfermedadTradicionalRepositoryDBImpl
    implements EnfermedadTradicionalRepositoryDB {
  final EnfermedadTradicionalLocalDataSource
      enfermedadTradicionalLocalDataSource;

  EnfermedadTradicionalRepositoryDBImpl(
      {required this.enfermedadTradicionalLocalDataSource});

  @override
  Future<Either<Failure, List<EnfermedadTradicionalModel>>>
      getEnfermedadesTradicionalesRepositoryDB() async {
    try {
      final result = await enfermedadTradicionalLocalDataSource
          .getEnfermedadesTradicionales();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEnfermedadTradicionalRepositoryDB(
      EnfermedadTradicionalEntity enfermedadTradicional) async {
    try {
      final enfermedadTradicionalModel =
          EnfermedadTradicionalModel.fromEntity(enfermedadTradicional);
      final result = await enfermedadTradicionalLocalDataSource
          .saveEnfermedadTradicional(enfermedadTradicionalModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstEnfermedadTradicional>>>
      getEnfermedadesTradicionalesAtencionSaludRepositoryDB(
          int? atencionSaludId) async {
    try {
      final result = await enfermedadTradicionalLocalDataSource
          .getEnfermedadesTradicionalesAtencionSalud(atencionSaludId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      saveEnfermedadesTradicionalesAtencionSaludRepositoryDB(
          int atencionSaludId,
          List<LstEnfermedadTradicional> lstEnfermedadTradicional) async {
    try {
      final result = await enfermedadTradicionalLocalDataSource
          .saveEnfermedadesTradicionalesAtencionSalud(
              atencionSaludId, lstEnfermedadTradicional);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
