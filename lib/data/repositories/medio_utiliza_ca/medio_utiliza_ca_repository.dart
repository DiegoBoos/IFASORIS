import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/medio_utiliza_ca/medio_utiliza_ca_repository.dart';
import '../../datasources/remote/medio_utiliza_ca_remote_ds.dart';
import '../../models/medio_utiliza_ca.dart';

class MedioUtilizaCARepositoryImpl implements MedioUtilizaCARepository {
  final MedioUtilizaCARemoteDataSource medioUtilizaCARemoteDataSource;

  MedioUtilizaCARepositoryImpl({required this.medioUtilizaCARemoteDataSource});

  @override
  Future<Either<Failure, List<MedioUtilizaCAModel>>>
      getMediosUtilizaCARepository(int ideDpto) async {
    try {
      final result =
          await medioUtilizaCARemoteDataSource.getMediosUtilizaCA(ideDpto);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
