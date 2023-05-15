part of 'techo_vivienda_by_dpto_cubit.dart';

abstract class TechosViviendaByDptoState extends Equatable {
  final List<TechoViviendaEntity>? techosViviendaByDpto;
  const TechosViviendaByDptoState({this.techosViviendaByDpto});

  @override
  List<Object> get props => [];
}

class TechosViviendaByDptoInitial extends TechosViviendaByDptoState {}

class TechosViviendaByDptoLoading extends TechosViviendaByDptoState {}

class TechosViviendaByDptoLoaded extends TechosViviendaByDptoState {
  final List<TechoViviendaEntity>? techosViviendaByDptoLoaded;

  const TechosViviendaByDptoLoaded(this.techosViviendaByDptoLoaded)
      : super(techosViviendaByDpto: techosViviendaByDptoLoaded);
}

class TechosViviendaByDptoError extends TechosViviendaByDptoState {
  final String message;

  const TechosViviendaByDptoError(this.message);
}
