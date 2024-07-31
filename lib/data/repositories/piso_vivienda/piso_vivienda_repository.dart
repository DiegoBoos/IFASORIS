import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/piso_vivienda/piso_vivienda_repository.dart';
import '../../datasources/remote/piso_vivienda_remote_ds.dart';
import '../../models/piso_vivienda.dart';

class PisoViviendaRepositoryImpl implements PisoViviendaRepository {
  final PisoViviendaRemoteDataSource pisoViviendaRemoteDataSource;

  PisoViviendaRepositoryImpl({required this.pisoViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<PisoViviendaModel>>> getPisosViviendaRepository(
      int dtoId) async {
    try {
      final result = await pisoViviendaRemoteDataSource.getPisosVivienda(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
