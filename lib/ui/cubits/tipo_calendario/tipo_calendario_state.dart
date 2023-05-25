part of 'tipo_calendario_cubit.dart';

abstract class TiposCalendarioState extends Equatable {
  final List<TipoCalendarioEntity>? tiposCalendario;
  const TiposCalendarioState({this.tiposCalendario});

  @override
  List<Object> get props => [];
}

class TiposCalendarioInitial extends TiposCalendarioState {}

class TiposCalendarioLoading extends TiposCalendarioState {}

class TiposCalendarioLoaded extends TiposCalendarioState {
  final List<TipoCalendarioEntity>? tiposCalendarioLoaded;

  const TiposCalendarioLoaded(this.tiposCalendarioLoaded)
      : super(tiposCalendario: tiposCalendarioLoaded);
}

class TiposCalendarioError extends TiposCalendarioState {
  final String message;

  const TiposCalendarioError(this.message);
}
