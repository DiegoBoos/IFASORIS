part of 'presencia_animal_vivienda_cubit.dart';

abstract class PresenciaAnimalesViviendaState extends Equatable {
  final List<PresenciaAnimalViviendaEntity>? presenciaAnimalesVivienda;
  const PresenciaAnimalesViviendaState({this.presenciaAnimalesVivienda});

  @override
  List<Object> get props => [];
}

class PresenciaAnimalesViviendaInitial extends PresenciaAnimalesViviendaState {}

class PresenciaAnimalesViviendaLoading extends PresenciaAnimalesViviendaState {}

class PresenciaAnimalesViviendaLoaded extends PresenciaAnimalesViviendaState {
  final List<PresenciaAnimalViviendaEntity>? presenciaAnimalesViviendaLoaded;

  const PresenciaAnimalesViviendaLoaded(this.presenciaAnimalesViviendaLoaded)
      : super(presenciaAnimalesVivienda: presenciaAnimalesViviendaLoaded);
}

class PresenciaAnimalesViviendaError extends PresenciaAnimalesViviendaState {
  final String message;

  const PresenciaAnimalesViviendaError(this.message);
}
