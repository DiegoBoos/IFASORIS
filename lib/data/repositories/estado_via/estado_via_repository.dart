import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/estado_via/estado_via_repository.dart';
import '../../datasources/remote/estado_via_remote_ds.dart';
import '../../models/estado_via.dart';

class EstadoViaRepositoryImpl implements EstadoViaRepository {
  final EstadoViaRemoteDataSource estadoViaRemoteDataSource;

  EstadoViaRepositoryImpl({required this.estadoViaRemoteDataSource});

  @override
  Future<Either<Failure, List<EstadoViaModel>>>
      getEstadoViasRepository() async {
    try {
      final result = await estadoViaRemoteDataSource.getEstadoVias();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
