import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/cuarto_vivienda_entity.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/cuarto_vivienda/cuarto_vivienda_repository.dart';
import '../../datasources/remote/cuarto_vivienda_remote_ds.dart';

class NroCuartoViviendaRepositoryImpl implements NroCuartoViviendaRepository {
  final NroCuartoViviendaRemoteDataSource nroCuartoViviendaRemoteDataSource;

  NroCuartoViviendaRepositoryImpl(
      {required this.nroCuartoViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<NroCuartoViviendaEntity>>>
      getNroCuartosViviendaRepository() async {
    try {
      final result =
          await nroCuartoViviendaRemoteDataSource.getNroCuartosVivienda();

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
