import 'package:equatable/equatable.dart';

import '../../../domain/entities/dim_ubicacion_entity.dart';

abstract class DimUbicacionState extends Equatable {
  final DimUbicacionEntity dimUbicacion;
  const DimUbicacionState({required this.dimUbicacion});

  @override
  List<Object?> get props => [];
}

class DimUbicacionInitial extends DimUbicacionState {
  DimUbicacionInitial() : super(dimUbicacion: initObject());
}

class DimUbicacionLoading extends DimUbicacionState {
  const DimUbicacionLoading({required super.dimUbicacion});
}

class DimUbicacionLoaded extends DimUbicacionState {
  final DimUbicacionEntity dimUbicacionLoaded;

  const DimUbicacionLoaded(this.dimUbicacionLoaded)
      : super(dimUbicacion: dimUbicacionLoaded);
}

class DimUbicacionChanged extends DimUbicacionState {
  final DimUbicacionEntity dimUbicacionChanged;

  const DimUbicacionChanged(this.dimUbicacionChanged)
      : super(dimUbicacion: dimUbicacionChanged);
}

class DimUbicacionSaved extends DimUbicacionState {
  const DimUbicacionSaved({required super.dimUbicacion});
}

class DimUbicacionError extends DimUbicacionState {
  final String message;

  DimUbicacionError(this.message) : super(dimUbicacion: initObject());

  @override
  List<Object?> get props => [message];
}

DimUbicacionEntity initObject() {
  return DimUbicacionEntity(
      familiaId: 0,
      nombreRecibeVisita: '',
      tipoDocRecibeVisita: '',
      documentoRecibeVisita: '',
      perteneceResguardo: 0,
      viaAccesoId: 0,
      resguardoId: 0,
      autoridadIndigenaId: 0,
      estadoViaId: 0,
      medioComunicacionId: 0,
      tiempoTardaId: 0,
      medioUtilizaId: 0,
      dificultaAccesoId: 0,
      costoDesplazamientoId: 0,
      existeMedTradicionalComunidad: 0,
      especialidadMedTradId: 0,
      tiempoTardaMedTradId: 0,
      medioUtilizaMedTradId: 0,
      dificultadAccesoMedTradId: 0,
      costoDesplazamientoMedTradicional: 0,
      nombreMedTradicional: 0,
      poseeChagra: 0,
      tuberculoPlatanoId: 0,
      leguminosaId: 0,
      hortalizaId: 0,
      verduraId: 0,
      frutoId: 0,
      cerealId: 0,
      especieAnimalCriaId: 0,
      produccionMinera: 0,
      tipoCalendarioId: 0);
}
