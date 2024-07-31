import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/dim_ubicacion/dim_ubicacion_db_usecase.dart';

import '../../../domain/entities/dim_ubicacion.dart';

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
  return const DimUbicacionEntity(
    familiaId: 0,
    nombreRecibeVisita: '',
    tipoDocRecibeVisita: '',
    documentoRecibeVisita: '',
    resguardoId: 0,
    produccionMinera: 0,
  );
}
