import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/verdura/verdura_repository.dart';
import '../../datasources/remote/verdura_remote_ds.dart';
import '../../models/verdura.dart';

class VerduraRepositoryImpl implements VerduraRepository {
  final VerduraRemoteDataSource verduraRemoteDataSource;

  VerduraRepositoryImpl({required this.verduraRemoteDataSource});

  @override
  Future<Either<Failure, List<VerduraModel>>> getVerdurasRepository(
      int dtoId) async {
    try {
      final result = await verduraRemoteDataSource.getVerduras(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
