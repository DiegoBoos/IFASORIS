part of 'sancion_justicia_cubit.dart';

abstract class SancionesJusticiaState extends Equatable {
  final List<SancionJusticiaEntity>? sancionesJusticia;

  const SancionesJusticiaState({this.sancionesJusticia});

  @override
  List<Object> get props => [];
}

class SancionesJusticiaInitial extends SancionesJusticiaState {}

class SancionesJusticiaLoading extends SancionesJusticiaState {}

class SancionesJusticiaLoaded extends SancionesJusticiaState {
  final List<SancionJusticiaEntity>? sancionesJusticiaLoaded;

  const SancionesJusticiaLoaded(this.sancionesJusticiaLoaded)
      : super(sancionesJusticia: sancionesJusticiaLoaded);
}

class SancionesJusticiaError extends SancionesJusticiaState {
  final String message;

  const SancionesJusticiaError(this.message);
}
