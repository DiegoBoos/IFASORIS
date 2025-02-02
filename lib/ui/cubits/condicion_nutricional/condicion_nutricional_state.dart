part of 'condicion_nutricional_cubit.dart';

abstract class CondicionesNutricionalesState extends Equatable {
  final List<CondicionNutricionalEntity>? condicionesNutricionales;

  const CondicionesNutricionalesState({this.condicionesNutricionales});

  @override
  List<Object> get props => [];
}

class CondicionesNutricionalesInitial extends CondicionesNutricionalesState {}

class CondicionesNutricionalesLoading extends CondicionesNutricionalesState {}

class CondicionesNutricionalesLoaded extends CondicionesNutricionalesState {
  final List<CondicionNutricionalEntity>? condicionesNutricionalesLoaded;

  const CondicionesNutricionalesLoaded(this.condicionesNutricionalesLoaded)
      : super(condicionesNutricionales: condicionesNutricionalesLoaded);
}

class CondicionesNutricionalesError extends CondicionesNutricionalesState {
  final String message;

  const CondicionesNutricionalesError(this.message);
}
