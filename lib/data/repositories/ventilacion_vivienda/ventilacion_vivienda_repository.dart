import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/ventilacion_vivienda/ventilacion_vivienda_repository.dart';
import '../../datasources/remote/ventilacion_vivienda_remote_ds.dart';
import '../../models/ventilacion_vivienda.dart';

class VentilacionViviendaRepositoryImpl
    implements VentilacionViviendaRepository {
  final VentilacionViviendaRemoteDataSource ventilacionViviendaRemoteDataSource;

  VentilacionViviendaRepositoryImpl(
      {required this.ventilacionViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<VentilacionViviendaModel>>>
      getVentilacionesViviendaRepository() async {
    try {
      final result =
          await ventilacionViviendaRemoteDataSource.getVentilacionesVivienda();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
