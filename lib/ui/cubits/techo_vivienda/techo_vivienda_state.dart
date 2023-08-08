part of 'techo_vivienda_cubit.dart';

abstract class TechosViviendaState extends Equatable {
  final List<TechoViviendaEntity>? techosVivienda;
  const TechosViviendaState({this.techosVivienda});

  @override
  List<Object> get props => [];
}

class TechosViviendaInitial extends TechosViviendaState {}

class TechosViviendaLoading extends TechosViviendaState {}

class TechosViviendaLoaded extends TechosViviendaState {
  final List<TechoViviendaEntity>? techosViviendaLoaded;

  const TechosViviendaLoaded(this.techosViviendaLoaded)
      : super(techosVivienda: techosViviendaLoaded);
}

class TechosViviendaError extends TechosViviendaState {
  final String message;

  const TechosViviendaError(this.message);
}
