import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/costumbre_practica/costumbre_practica_repository.dart';
import '../../datasources/remote/costumbre_practica_remote_ds.dart';
import '../../models/costumbre_practica.dart';

class CostumbrePracticaRepositoryImpl implements CostumbrePracticaRepository {
  final CostumbrePracticaRemoteDataSource costumbrePracticaRemoteDataSource;

  CostumbrePracticaRepositoryImpl(
      {required this.costumbrePracticaRemoteDataSource});

  @override
  Future<Either<Failure, List<CostumbrePracticaModel>>>
      getCostumbresPracticanRepository(int dtoId) async {
    try {
      final result =
          await costumbrePracticaRemoteDataSource.getCostumbresPractican(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
