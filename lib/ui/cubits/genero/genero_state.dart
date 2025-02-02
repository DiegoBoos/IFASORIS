part of 'genero_cubit.dart';

abstract class GenerosState extends Equatable {
  final List<GeneroEntity>? generos;
  const GenerosState({this.generos});

  @override
  List<Object> get props => [];
}

class GenerosInitial extends GenerosState {}

class GenerosLoading extends GenerosState {}

class GenerosLoaded extends GenerosState {
  final List<GeneroEntity>? generosLoaded;

  const GenerosLoaded(this.generosLoaded) : super(generos: generosLoaded);
}

class GenerosError extends GenerosState {
  final String message;

  const GenerosError(this.message);
}
