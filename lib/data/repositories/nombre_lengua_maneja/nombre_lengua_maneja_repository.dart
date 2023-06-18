import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/nombre_lengua_maneja_entity.dart';
import '../../../domain/repositories/nombre_lengua_maneja/nombre_lengua_maneja_repository.dart';
import '../../datasources/remote/nombre_lengua_maneja_remote_ds.dart';

class NombreLenguaManejaRepositoryImpl implements NombreLenguaManejaRepository {
  final NombreLenguaManejaRemoteDataSource nombreLenguaManejaRemoteDataSource;

  NombreLenguaManejaRepositoryImpl(
      {required this.nombreLenguaManejaRemoteDataSource});

  @override
  Future<Either<Failure, List<NombreLenguaManejaEntity>>>
      getNombresLenguasManejaRepository() async {
    try {
      final result =
          await nombreLenguaManejaRemoteDataSource.getNombresLenguasManeja();

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
