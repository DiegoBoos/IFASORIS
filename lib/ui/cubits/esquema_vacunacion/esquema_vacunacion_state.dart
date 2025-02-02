part of 'esquema_vacunacion_cubit.dart';

abstract class EsquemasVacunacionState extends Equatable {
  final List<EsquemaVacunacionEntity>? esquemasVacunacion;

  const EsquemasVacunacionState({this.esquemasVacunacion});

  @override
  List<Object> get props => [];
}

class EsquemasVacunacionInitial extends EsquemasVacunacionState {}

class EsquemasVacunacionLoading extends EsquemasVacunacionState {}

class EsquemasVacunacionLoaded extends EsquemasVacunacionState {
  final List<EsquemaVacunacionEntity>? esquemasVacunacionLoaded;

  const EsquemasVacunacionLoaded(this.esquemasVacunacionLoaded)
      : super(esquemasVacunacion: esquemasVacunacionLoaded);
}

class EsquemasVacunacionError extends EsquemasVacunacionState {
  final String message;

  const EsquemasVacunacionError(this.message);
}
