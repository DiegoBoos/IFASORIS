part of 'especie_animal_by_dpto_cubit.dart';

abstract class EspeciesAnimalesByDptoState extends Equatable {
  final List<EspecieAnimalEntity>? especiesAnimalesByDpto;
  const EspeciesAnimalesByDptoState({this.especiesAnimalesByDpto});

  @override
  List<Object> get props => [];
}

class EspeciesAnimalesByDptoInitial extends EspeciesAnimalesByDptoState {}

class EspeciesAnimalesByDptoLoading extends EspeciesAnimalesByDptoState {}

class EspeciesAnimalesByDptoLoaded extends EspeciesAnimalesByDptoState {
  final List<EspecieAnimalEntity>? especiesAnimalesByDptoLoaded;

  const EspeciesAnimalesByDptoLoaded(this.especiesAnimalesByDptoLoaded)
      : super(especiesAnimalesByDpto: especiesAnimalesByDptoLoaded);
}

class EspeciesAnimalesByDptoError extends EspeciesAnimalesByDptoState {
  final String message;

  const EspeciesAnimalesByDptoError(this.message);
}
