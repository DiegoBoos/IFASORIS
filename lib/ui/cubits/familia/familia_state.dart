part of 'familia_cubit.dart';

abstract class FamiliaState extends Equatable {
  final FamiliaEntity? familia;
  const FamiliaState({this.familia});

  @override
  List<Object?> get props => [];
}

class FamiliaInitial extends FamiliaState {}

class FamiliaLoading extends FamiliaState {}

class FamiliaLoaded extends FamiliaState {
  final FamiliaEntity familiaLoaded;

  const FamiliaLoaded(this.familiaLoaded) : super(familia: familiaLoaded);
}

class FamiliaCreated extends FamiliaState {
  final FamiliaEntity familiaCreated;

  const FamiliaCreated(this.familiaCreated) : super(familia: familiaCreated);
}

class FamiliaEliminada extends FamiliaState {
  final int fichaId;

  const FamiliaEliminada(this.fichaId);
}

class FamiliaError extends FamiliaState {
  final String message;

  const FamiliaError(this.message);

  @override
  List<Object?> get props => [message];
}
