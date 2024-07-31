import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/cuarto_vivienda.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/cuarto_vivienda/cuarto_vivienda_repository.dart';
import '../../datasources/remote/cuarto_vivienda_remote_ds.dart';

class CuartoViviendaRepositoryImpl implements CuartoViviendaRepository {
  final CuartoViviendaRemoteDataSource cuartoViviendaRemoteDataSource;

  CuartoViviendaRepositoryImpl({required this.cuartoViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<CuartoViviendaEntity>>>
      getCuartosViviendaRepository() async {
    try {
      final result = await cuartoViviendaRemoteDataSource.getCuartosVivienda();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
