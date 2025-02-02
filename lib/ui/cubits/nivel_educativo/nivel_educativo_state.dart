part of 'nivel_educativo_cubit.dart';

abstract class NivelesEducativosState extends Equatable {
  final List<NivelEducativoEntity>? nivelesEducativos;
  const NivelesEducativosState({this.nivelesEducativos});

  @override
  List<Object> get props => [];
}

class NivelesEducativosInitial extends NivelesEducativosState {}

class NivelesEducativosLoading extends NivelesEducativosState {}

class NivelesEducativosLoaded extends NivelesEducativosState {
  final List<NivelEducativoEntity>? nivelesEducativosLoaded;

  const NivelesEducativosLoaded(this.nivelesEducativosLoaded)
      : super(nivelesEducativos: nivelesEducativosLoaded);
}

class NivelesEducativosError extends NivelesEducativosState {
  final String message;

  const NivelesEducativosError(this.message);
}
