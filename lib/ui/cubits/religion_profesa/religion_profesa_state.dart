part of 'religion_profesa_cubit.dart';

abstract class ReligionesProfesaState extends Equatable {
  final List<ReligionProfesaEntity>? religionesProfesa;

  const ReligionesProfesaState({this.religionesProfesa});

  @override
  List<Object> get props => [];
}

class ReligionesProfesaInitial extends ReligionesProfesaState {}

class ReligionesProfesaLoading extends ReligionesProfesaState {}

class ReligionesProfesaLoaded extends ReligionesProfesaState {
  final List<ReligionProfesaEntity>? religionesProfesaLoaded;

  const ReligionesProfesaLoaded(this.religionesProfesaLoaded)
      : super(religionesProfesa: religionesProfesaLoaded);
}

class ReligionesProfesaError extends ReligionesProfesaState {
  final String message;

  const ReligionesProfesaError(this.message);
}
