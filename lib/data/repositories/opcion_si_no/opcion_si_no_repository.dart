import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/opcion_si_no_entity.dart';
import '../../../domain/repositories/opcion_si_no/opcion_si_no_repository.dart';
import '../../datasources/remote/opcion_si_no_remote_ds.dart';

class OpcionSiNoRepositoryImpl implements OpcionSiNoRepository {
  final OpcionSiNoRemoteDataSource opcionSiNoRemoteDataSource;

  OpcionSiNoRepositoryImpl({required this.opcionSiNoRemoteDataSource});

  @override
  Future<Either<Failure, List<OpcionSiNoEntity>>>
      getOpcionesSiNoRepository() async {
    try {
      final result = await opcionSiNoRemoteDataSource.getOpcionesSiNo();

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
