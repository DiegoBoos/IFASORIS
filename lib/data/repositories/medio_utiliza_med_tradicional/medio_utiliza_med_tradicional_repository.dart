import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/medio_utiliza_med_tradicional/medio_utiliza_med_tradicional_repository.dart';
import '../../datasources/remote/medio_utiliza_med_tradicional_remote_ds.dart';
import '../../models/medio_utiliza_med_tradicional.dart';

class MedioUtilizaMedTradicionalRepositoryImpl
    implements MedioUtilizaMedTradicionalRepository {
  final MedioUtilizaMedTradicionalRemoteDataSource
      medioUtilizaMedTradicionalRemoteDataSource;

  MedioUtilizaMedTradicionalRepositoryImpl(
      {required this.medioUtilizaMedTradicionalRemoteDataSource});

  @override
  Future<Either<Failure, List<MedioUtilizaMedTradicionalModel>>>
      getMediosUtilizaMedTradicionalRepository(int dtoId) async {
    try {
      final result = await medioUtilizaMedTradicionalRemoteDataSource
          .getMediosUtilizaMedTradicional(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
