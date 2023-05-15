import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/dim_ubicacion/dim_ubicacion_db_usecase.dart';

import '../../../domain/entities/dim_ubicacion_entity.dart';

part 'dim_ubicacion_cubit.dart';

abstract class DimUbicacionState extends Equatable {
  final DimUbicacionEntity dimUbicacion;
  const DimUbicacionState({required this.dimUbicacion});

  @override
  List<Object?> get props => [dimUbicacion];
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

  @override
  List<Object?> get props => [dimUbicacionLoaded];
}

class DimUbicacionChanged extends DimUbicacionState {
  final DimUbicacionEntity dimUbicacionChanged;

  const DimUbicacionChanged(this.dimUbicacionChanged)
      : super(dimUbicacion: dimUbicacionChanged);

  @override
  List<Object?> get props => [dimUbicacionChanged];
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
      ubicacionId: 0,
      familiaId: 0,
      nombreRecibeVisita: '',
      tipoDocRecibeVisita: '',
      documentoRecibeVisita: '',
      nombreMedTradicional: '',
      costoDesplazamientoMedTradicional: 0,
      resguardoId: 0,
      autoridadIndigenaId: 0,
      tuberculoPlatanoId: 0,
      poseeChagra: 0,
      leguminosaId: 0,
      hortalizaId: 0,
      verduraId: 0,
      frutoId: 0,
      cerealId: 0,
      especieAnimalCriaId: 0,
      produccionMinera: 0,
      tipoCalendarioId: 0);
}
