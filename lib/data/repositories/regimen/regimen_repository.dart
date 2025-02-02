import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/regimen/regimen_repository.dart';
import '../../datasources/remote/regimen_remote_ds.dart';
import '../../models/regimen.dart';

class RegimenRepositoryImpl implements RegimenRepository {
  final RegimenRemoteDataSource regimenRemoteDataSource;

  RegimenRepositoryImpl({required this.regimenRemoteDataSource});

  @override
  Future<Either<Failure, List<RegimenModel>>> getRegimenesRepository() async {
    try {
      final result = await regimenRemoteDataSource.getRegimenes();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
