import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/ultima_vez_inst_salud/ultima_vez_inst_salud_repository.dart';
import '../../datasources/remote/ultima_vez_inst_salud_remote_ds.dart';
import '../../models/ultima_vez_inst_salud.dart';

class UltimaVezInstSaludRepositoryImpl implements UltimaVezInstSaludRepository {
  final UltimaVezInstSaludRemoteDataSource ultimaVezInstSaludRemoteDataSource;

  UltimaVezInstSaludRepositoryImpl(
      {required this.ultimaVezInstSaludRemoteDataSource});

  @override
  Future<Either<Failure, List<UltimaVezInstSaludModel>>>
      getUltimasVecesInstSaludRepository() async {
    try {
      final result =
          await ultimaVezInstSaludRemoteDataSource.getUltimasVecesInstSalud();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
