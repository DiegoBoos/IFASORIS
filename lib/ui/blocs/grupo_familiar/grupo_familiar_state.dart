part of 'grupo_familiar_bloc.dart';

abstract class GrupoFamiliarState extends Equatable {
  final List<GrupoFamiliarEntity>? grupoFamiliar;

  const GrupoFamiliarState({this.grupoFamiliar});

  @override
  List<Object> get props => [];
}

class GrupoFamiliarInitial extends GrupoFamiliarState {}

class GrupoFamiliarLoading extends GrupoFamiliarState {}

class GrupoFamiliarLoaded extends GrupoFamiliarState {
  final List<GrupoFamiliarEntity>? grupoFamiliarLoaded;

  const GrupoFamiliarLoaded({this.grupoFamiliarLoaded})
      : super(grupoFamiliar: grupoFamiliarLoaded);
}
