import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/medio_utiliza_med_tradicional_entity.dart';
import '../../../domain/repositories/medio_utiliza_med_tradicional/medio_utiliza_med_tradicional_repository.dart';
import '../../datasources/remote/medio_utiliza_med_tradicional_remote_ds.dart';

class MedioUtilizaMedTradicionalRepositoryImpl
    implements MedioUtilizaMedTradicionalRepository {
  final MedioUtilizaMedTradicionalRemoteDataSource
      medioUtilizaMedTradicionalRemoteDataSource;

  MedioUtilizaMedTradicionalRepositoryImpl(
      {required this.medioUtilizaMedTradicionalRemoteDataSource});

  @override
  Future<Either<Failure, List<MedioUtilizaMedTradicionalEntity>>>
      getMediosUtilizaMedTradicionalRepository(int dtoId) async {
    try {
      final result = await medioUtilizaMedTradicionalRemoteDataSource
          .getMediosUtilizaMedTradicional(dtoId);

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
