import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/enfermedad_acude_entity.dart';
import '../../../domain/repositories/enfermedad_acude/enfermedad_acude_repository.dart';
import '../../datasources/remote/enfermedad_acude_remote_ds.dart';

class EnfermedadAcudeRepositoryImpl implements EnfermedadAcudeRepository {
  final EnfermedadAcudeRemoteDataSource enfermedadAcudeRemoteDataSource;

  EnfermedadAcudeRepositoryImpl(
      {required this.enfermedadAcudeRemoteDataSource});

  @override
  Future<Either<Failure, List<EnfermedadAcudeEntity>>>
      getEnfermedadesAcudeRepository() async {
    try {
      final result =
          await enfermedadAcudeRemoteDataSource.getEnfermedadesAcude();

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
