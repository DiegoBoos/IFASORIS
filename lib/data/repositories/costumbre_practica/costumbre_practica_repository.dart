import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/costumbre_practica_entity.dart';
import '../../../domain/repositories/costumbre_practica/costumbre_practica_repository.dart';
import '../../datasources/remote/costumbre_practica_remote_ds.dart';

class CostumbrePracticaRepositoryImpl implements CostumbrePracticaRepository {
  final CostumbrePracticaRemoteDataSource costumbrePracticaRemoteDataSource;

  CostumbrePracticaRepositoryImpl(
      {required this.costumbrePracticaRemoteDataSource});

  @override
  Future<Either<Failure, List<CostumbrePracticaEntity>>>
      getCostumbresPracticanRepository() async {
    try {
      final result =
          await costumbrePracticaRemoteDataSource.getCostumbresPractican();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
