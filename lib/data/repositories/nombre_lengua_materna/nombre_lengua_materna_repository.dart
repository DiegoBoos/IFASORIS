import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/nombre_lengua_materna/nombre_lengua_materna_repository.dart';
import '../../datasources/remote/nombre_lengua_materna_remote_ds.dart';
import '../../models/nombre_lengua_materna.dart';

class NombreLenguaMaternaRepositoryImpl
    implements NombreLenguaMaternaRepository {
  final NombreLenguaMaternaRemoteDataSource nombreLenguaMaternaRemoteDataSource;

  NombreLenguaMaternaRepositoryImpl(
      {required this.nombreLenguaMaternaRemoteDataSource});

  @override
  Future<Either<Failure, List<NombreLenguaMaternaModel>>>
      getNombresLenguasMaternaRepository(int dtoId) async {
    try {
      final result = await nombreLenguaMaternaRemoteDataSource
          .getNombresLenguasMaterna(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
