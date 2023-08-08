import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tratamiento_agua_vivienda_entity.dart';
import '../../../domain/repositories/tratamiento_agua_vivienda/tratamiento_agua_vivienda_repository.dart';
import '../../datasources/remote/tratamiento_agua_vivienda_remote_ds.dart';

class TratamientoAguaViviendaRepositoryImpl
    implements TratamientoAguaViviendaRepository {
  final TratamientoAguaViviendaRemoteDataSource
      tratamientoAguaViviendaRemoteDataSource;

  TratamientoAguaViviendaRepositoryImpl(
      {required this.tratamientoAguaViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<TratamientoAguaViviendaEntity>>>
      getTratamientosAguaViviendaRepository(int dtoId) async {
    try {
      final result = await tratamientoAguaViviendaRemoteDataSource
          .getTratamientosAguaVivienda(dtoId);

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
