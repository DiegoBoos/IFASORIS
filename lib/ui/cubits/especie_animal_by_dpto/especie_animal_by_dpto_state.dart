part of 'especie_animal_by_dpto_cubit.dart';

abstract class EspeciesAnimalesByDptoState extends Equatable {
  final List<EspecieAnimalEntity>? especiesanimalesByDpto;
  const EspeciesAnimalesByDptoState({this.especiesanimalesByDpto});

  @override
  List<Object> get props => [];
}

class EspeciesAnimalesByDptoInitial extends EspeciesAnimalesByDptoState {}

class EspeciesAnimalesByDptoLoading extends EspeciesAnimalesByDptoState {}

class EspeciesAnimalesByDptoLoaded extends EspeciesAnimalesByDptoState {
  final List<EspecieAnimalEntity>? especiesanimalesByDptoLoaded;

  const EspeciesAnimalesByDptoLoaded(this.especiesanimalesByDptoLoaded)
      : super(especiesanimalesByDpto: especiesanimalesByDptoLoaded);
}

class EspeciesAnimalesByDptoError extends EspeciesAnimalesByDptoState {
  final String message;

  const EspeciesAnimalesByDptoError(this.message);
}
