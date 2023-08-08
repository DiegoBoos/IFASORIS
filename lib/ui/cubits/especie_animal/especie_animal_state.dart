part of 'especie_animal_cubit.dart';

abstract class EspeciesAnimalesState extends Equatable {
  final List<EspecieAnimalEntity>? especiesAnimales;
  const EspeciesAnimalesState({this.especiesAnimales});

  @override
  List<Object> get props => [];
}

class EspeciesAnimalesInitial extends EspeciesAnimalesState {}

class EspeciesAnimalesLoading extends EspeciesAnimalesState {}

class EspeciesAnimalesLoaded extends EspeciesAnimalesState {
  final List<EspecieAnimalEntity>? especiesAnimalesLoaded;

  const EspeciesAnimalesLoaded(this.especiesAnimalesLoaded)
      : super(especiesAnimales: especiesAnimalesLoaded);
}

class EspeciesAnimalesError extends EspeciesAnimalesState {
  final String message;

  const EspeciesAnimalesError(this.message);
}
