part of 'conducta_seguir_cubit.dart';

abstract class ConductasSeguirState extends Equatable {
  final List<ConductaSeguirEntity>? conductasSeguir;

  const ConductasSeguirState({this.conductasSeguir});

  @override
  List<Object> get props => [];
}

class ConductasSeguirInitial extends ConductasSeguirState {}

class ConductasSeguirLoading extends ConductasSeguirState {}

class ConductasSeguirLoaded extends ConductasSeguirState {
  final List<ConductaSeguirEntity>? conductasSeguirLoaded;

  const ConductasSeguirLoaded(this.conductasSeguirLoaded)
      : super(conductasSeguir: conductasSeguirLoaded);
}

class ConductasSeguirError extends ConductasSeguirState {
  final String message;

  const ConductasSeguirError(this.message);
}
