import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/enfermedad_acude/enfermedad_acude_repository.dart';
import '../../datasources/remote/enfermedad_acude_remote_ds.dart';
import '../../models/enfermedad_acude.dart';

class EnfermedadAcudeRepositoryImpl implements EnfermedadAcudeRepository {
  final EnfermedadAcudeRemoteDataSource enfermedadAcudeRemoteDataSource;

  EnfermedadAcudeRepositoryImpl(
      {required this.enfermedadAcudeRemoteDataSource});

  @override
  Future<Either<Failure, List<EnfermedadAcudeModel>>>
      getEnfermedadesAcudeRepository() async {
    try {
      final result =
          await enfermedadAcudeRemoteDataSource.getEnfermedadesAcude();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
