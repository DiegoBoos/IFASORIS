part of 'costo_desplazamiento_cubit.dart';

abstract class CostosDesplazamientoState extends Equatable {
  final List<CostoDesplazamientoEntity>? costosDesplazamiento;
  const CostosDesplazamientoState({this.costosDesplazamiento});

  @override
  List<Object> get props => [];
}

class CostosDesplazamientoInitial extends CostosDesplazamientoState {}

class CostosDesplazamientoLoading extends CostosDesplazamientoState {}

class CostosDesplazamientoLoaded extends CostosDesplazamientoState {
  final List<CostoDesplazamientoEntity>? costosDesplazamientoLoaded;

  const CostosDesplazamientoLoaded(this.costosDesplazamientoLoaded)
      : super(costosDesplazamiento: costosDesplazamientoLoaded);
}

class CostosDesplazamientoError extends CostosDesplazamientoState {
  final String message;

  const CostosDesplazamientoError(this.message);
}
