part of 'costumbre_practica_cubit.dart';

abstract class CostumbresPracticanState extends Equatable {
  final List<CostumbrePracticaEntity>? costumbresPractican;

  const CostumbresPracticanState({this.costumbresPractican});

  @override
  List<Object> get props => [];
}

class CostumbresPracticanInitial extends CostumbresPracticanState {}

class CostumbresPracticanLoading extends CostumbresPracticanState {}

class CostumbresPracticanLoaded extends CostumbresPracticanState {
  final List<CostumbrePracticaEntity>? costumbresPracticanLoaded;

  const CostumbresPracticanLoaded(this.costumbresPracticanLoaded)
      : super(costumbresPractican: costumbresPracticanLoaded);
}

class CostumbresPracticanError extends CostumbresPracticanState {
  final String message;

  const CostumbresPracticanError(this.message);
}
