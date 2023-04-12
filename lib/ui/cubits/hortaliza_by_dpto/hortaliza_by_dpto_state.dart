part of 'hortaliza_by_dpto_cubit.dart';

abstract class HortalizasByDptoState extends Equatable {
  final List<HortalizaEntity>? hortalizasByDpto;
  const HortalizasByDptoState({this.hortalizasByDpto});

  @override
  List<Object> get props => [];
}

class HortalizasByDptoInitial extends HortalizasByDptoState {}

class HortalizasByDptoLoading extends HortalizasByDptoState {}

class HortalizasByDptoLoaded extends HortalizasByDptoState {
  final List<HortalizaEntity>? hortalizasByDptoLoaded;

  const HortalizasByDptoLoaded(this.hortalizasByDptoLoaded)
      : super(hortalizasByDpto: hortalizasByDptoLoaded);
}

class HortalizasByDptoError extends HortalizasByDptoState {
  final String message;

  const HortalizasByDptoError(this.message);
}
