import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/afiliado/afiliado_repository.dart';
import '../../datasources/remote/afiliado_remote_ds.dart';
import '../../models/afiliado.dart';

class AfiliadoRepositoryImpl implements AfiliadoRepository {
  final AfiliadoRemoteDataSource afiliadoRemoteDataSource;

  AfiliadoRepositoryImpl({required this.afiliadoRemoteDataSource});

  @override
  Future<Either<Failure, AfiliadoResponseModel>> getAfiliadosRepository(
      int dtoId) async {
    try {
      final result = await afiliadoRemoteDataSource.getAfiliados(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
