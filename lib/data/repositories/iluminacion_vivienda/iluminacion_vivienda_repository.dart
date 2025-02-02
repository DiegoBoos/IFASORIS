import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/iluminacion_vivienda/iluminacion_vivienda_repository.dart';
import '../../datasources/remote/iluminacion_vivienda_remote_ds.dart';
import '../../models/iluminacion_vivienda.dart';

class IluminacionViviendaRepositoryImpl
    implements IluminacionViviendaRepository {
  final IluminacionViviendaRemoteDataSource iluminacionViviendaRemoteDataSource;

  IluminacionViviendaRepositoryImpl(
      {required this.iluminacionViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<IluminacionViviendaModel>>>
      getIluminacionesViviendaRepository() async {
    try {
      final result =
          await iluminacionViviendaRemoteDataSource.getIluminacionesVivienda();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
