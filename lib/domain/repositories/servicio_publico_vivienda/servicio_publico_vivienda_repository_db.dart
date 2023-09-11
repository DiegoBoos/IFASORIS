import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/servicio_publico_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/servicio_publico_vivienda_entity.dart';

abstract class ServicioPublicoViviendaRepositoryDB {
  Future<Either<Failure, int>> saveServicioPublicoViviendaRepositoryDB(
      ServicioPublicoViviendaEntity servicioPublicoVivienda);

  Future<Either<Failure, List<ServicioPublicoViviendaEntity>>>
      getServiciosPublicosRepositoryDB();

  Future<Either<Failure, int>> saveServiciosPublicosViviendaRepositoryDB(
      int datoViviendaId, List<LstServPublico> lstServPublico);

  Future<Either<Failure, List<LstServPublico>>>
      getServiciosPublicosViviendaRepositoryDB(int? datoViviendaId);
}
