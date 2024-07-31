import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/hortaliza/hortaliza_repository.dart';
import '../../datasources/remote/hortaliza_remote_ds.dart';
import '../../models/hortaliza.dart';

class HortalizaRepositoryImpl implements HortalizaRepository {
  final HortalizaRemoteDataSource hortalizaRemoteDataSource;

  HortalizaRepositoryImpl({required this.hortalizaRemoteDataSource});

  @override
  Future<Either<Failure, List<HortalizaModel>>> getHortalizasRepository(
      int dtoId) async {
    try {
      final result = await hortalizaRemoteDataSource.getHortalizas(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
