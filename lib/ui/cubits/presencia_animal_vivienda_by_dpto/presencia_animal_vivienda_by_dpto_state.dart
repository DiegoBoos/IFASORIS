part of 'presencia_animal_vivienda_by_dpto_cubit.dart';

abstract class PresenciaAnimalesViviendaByDptoState extends Equatable {
  final List<PresenciaAnimalViviendaEntity>? presenciaAnimalesViviendaByDpto;
  const PresenciaAnimalesViviendaByDptoState(
      {this.presenciaAnimalesViviendaByDpto});

  @override
  List<Object> get props => [];
}

class PresenciaAnimalesViviendaByDptoInitial
    extends PresenciaAnimalesViviendaByDptoState {}

class PresenciaAnimalesViviendaByDptoLoading
    extends PresenciaAnimalesViviendaByDptoState {}

class PresenciaAnimalesViviendaByDptoLoaded
    extends PresenciaAnimalesViviendaByDptoState {
  final List<PresenciaAnimalViviendaEntity>?
      presenciaAnimalesViviendaByDptoLoaded;

  const PresenciaAnimalesViviendaByDptoLoaded(
      this.presenciaAnimalesViviendaByDptoLoaded)
      : super(
            presenciaAnimalesViviendaByDpto:
                presenciaAnimalesViviendaByDptoLoaded);
}

class PresenciaAnimalesViviendaByDptoError
    extends PresenciaAnimalesViviendaByDptoState {
  final String message;

  const PresenciaAnimalesViviendaByDptoError(this.message);
}
