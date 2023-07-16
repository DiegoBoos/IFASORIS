part of 'cigarrillo_dia_cubit.dart';

abstract class CigarrillosDiaState extends Equatable {
  final List<CigarrilloDiaEntity>? cigarrillosDia;
  const CigarrillosDiaState({this.cigarrillosDia});

  @override
  List<Object> get props => [];
}

class CigarrillosDiaInitial extends CigarrillosDiaState {}

class CigarrillosDiaLoading extends CigarrillosDiaState {}

class CigarrillosDiaLoaded extends CigarrillosDiaState {
  final List<CigarrilloDiaEntity>? cigarrillosDiaLoaded;

  const CigarrillosDiaLoaded(this.cigarrillosDiaLoaded)
      : super(cigarrillosDia: cigarrillosDiaLoaded);
}

class CigarrillosDiaError extends CigarrillosDiaState {
  final String message;

  const CigarrillosDiaError(this.message);
}
