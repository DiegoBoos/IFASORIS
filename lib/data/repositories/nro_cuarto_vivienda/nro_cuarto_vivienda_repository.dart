import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/nro_cuarto_vivienda.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/nro_cuarto_vivienda/nro_cuarto_vivienda_repository.dart';
import '../../datasources/remote/nro_cuarto_vivienda_remote_ds.dart';

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
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
