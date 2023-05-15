import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/ventilacion_vivienda_entity.dart';
import '../../../domain/repositories/ventilacion_vivienda/ventilacion_vivienda_repository.dart';
import '../../datasources/remote/ventilacion_vivienda_remote_ds.dart';

class VentilacionViviendaRepositoryImpl
    implements VentilacionViviendaRepository {
  final VentilacionViviendaRemoteDataSource ventilacionViviendaRemoteDataSource;

  VentilacionViviendaRepositoryImpl(
      {required this.ventilacionViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<VentilacionViviendaEntity>>>
      getVentilacionesViviendaRepository() async {
    try {
      final result =
          await ventilacionViviendaRemoteDataSource.getVentilacionesVivienda();

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
