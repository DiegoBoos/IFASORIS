import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/medio_utiliza_ca_entity.dart';
import '../../../domain/repositories/medio_utiliza_ca/medio_utiliza_ca_repository.dart';
import '../../datasources/remote/medio_utiliza_ca_remote_ds.dart';

class MedioUtilizaCARepositoryImpl implements MedioUtilizaCARepository {
  final MedioUtilizaCARemoteDataSource medioUtilizaCARemoteDataSource;

  MedioUtilizaCARepositoryImpl({required this.medioUtilizaCARemoteDataSource});

  @override
  Future<Either<Failure, List<MedioUtilizaCAEntity>>>
      getMediosUtilizaCARepository() async {
    try {
      final mediosUtilizaCA =
          await medioUtilizaCARemoteDataSource.getMediosUtilizaCA();

      return Right(mediosUtilizaCA);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
