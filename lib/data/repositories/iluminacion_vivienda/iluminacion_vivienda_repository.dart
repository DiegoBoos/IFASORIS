import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/iluminacion_vivienda_entity.dart';
import '../../../domain/repositories/iluminacion_vivienda/iluminacion_vivienda_repository.dart';
import '../../datasources/remote/iluminacion_vivienda_remote_ds.dart';

class IluminacionViviendaRepositoryImpl
    implements IluminacionViviendaRepository {
  final IluminacionViviendaRemoteDataSource iluminacionViviendaRemoteDataSource;

  IluminacionViviendaRepositoryImpl(
      {required this.iluminacionViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<IluminacionViviendaEntity>>>
      getIluminacionesViviendaRepository() async {
    try {
      final result =
          await iluminacionViviendaRemoteDataSource.getIluminacionesVivienda();

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
