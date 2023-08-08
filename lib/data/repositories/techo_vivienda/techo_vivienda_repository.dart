import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/techo_vivienda_entity.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/techo_vivienda/techo_vivienda_repository.dart';
import '../../datasources/remote/techo_vivienda_remote_ds.dart';

class TechoViviendaRepositoryImpl implements TechoViviendaRepository {
  final TechoViviendaRemoteDataSource techoViviendaRemoteDataSource;

  TechoViviendaRepositoryImpl({required this.techoViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<TechoViviendaEntity>>>
      getTechosViviendaRepository(int dtoId) async {
    try {
      final result =
          await techoViviendaRemoteDataSource.getTechosVivienda(dtoId);

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
