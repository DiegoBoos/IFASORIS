part of 'hortaliza_cubit.dart';

abstract class HortalizasState extends Equatable {
  final List<HortalizaEntity>? hortalizas;
  const HortalizasState({this.hortalizas});

  @override
  List<Object> get props => [];
}

class HortalizasInitial extends HortalizasState {}

class HortalizasLoading extends HortalizasState {}

class HortalizasLoaded extends HortalizasState {
  final List<HortalizaEntity>? hortalizasLoaded;

  const HortalizasLoaded(this.hortalizasLoaded)
      : super(hortalizas: hortalizasLoaded);
}

class HortalizasError extends HortalizasState {
  final String message;

  const HortalizasError(this.message);
}
