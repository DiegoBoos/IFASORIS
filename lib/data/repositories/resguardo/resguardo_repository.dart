import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/resguardo/resguardo_repository.dart';
import '../../datasources/remote/resguardo_remote_ds.dart';
import '../../models/resguardo.dart';

class ResguardoRepositoryImpl implements ResguardoRepository {
  final ResguardoRemoteDataSource resguardoRemoteDataSource;

  ResguardoRepositoryImpl({required this.resguardoRemoteDataSource});

  @override
  Future<Either<Failure, List<ResguardoModel>>> getResguardosRepository(
      int dtoId) async {
    try {
      final result = await resguardoRemoteDataSource.getResguardos(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
