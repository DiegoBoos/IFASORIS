import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/ultima_vez_inst_salud_entity.dart';
import '../../../domain/repositories/ultima_vez_inst_salud/ultima_vez_inst_salud_repository.dart';
import '../../datasources/remote/ultima_vez_inst_salud_remote_ds.dart';

class UltimaVezInstSaludRepositoryImpl implements UltimaVezInstSaludRepository {
  final UltimaVezInstSaludRemoteDataSource ultimaVezInstSaludRemoteDataSource;

  UltimaVezInstSaludRepositoryImpl(
      {required this.ultimaVezInstSaludRemoteDataSource});

  @override
  Future<Either<Failure, List<UltimaVezInstSaludEntity>>>
      getUltimasVecesInstSaludRepository() async {
    try {
      final result =
          await ultimaVezInstSaludRemoteDataSource.getUltimasVecesInstSalud();

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
