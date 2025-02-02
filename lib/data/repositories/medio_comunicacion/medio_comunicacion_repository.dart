import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/medio_comunicacion/medio_comunicacion_repository.dart';
import '../../datasources/remote/medio_comunicacion_remote_ds.dart';
import '../../models/medio_comunicacion.dart';

class MedioComunicacionRepositoryImpl implements MedioComunicacionRepository {
  final MedioComunicacionRemoteDataSource medioComunicacionRemoteDataSource;

  MedioComunicacionRepositoryImpl(
      {required this.medioComunicacionRemoteDataSource});

  @override
  Future<Either<Failure, List<MedioComunicacionModel>>>
      getMediosComunicacionRepository(int dtoId) async {
    try {
      final result =
          await medioComunicacionRemoteDataSource.getMediosComunicacion(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
