part of 'ultima_vez_inst_salud_cubit.dart';

abstract class UltimasVecesInstSaludState extends Equatable {
  final List<UltimaVezInstSaludEntity>? ultimasVecesInstSalud;

  const UltimasVecesInstSaludState({this.ultimasVecesInstSalud});

  @override
  List<Object> get props => [];
}

class UltimasVecesInstSaludInitial extends UltimasVecesInstSaludState {}

class UltimasVecesInstSaludLoading extends UltimasVecesInstSaludState {}

class UltimasVecesInstSaludLoaded extends UltimasVecesInstSaludState {
  final List<UltimaVezInstSaludEntity>? ultimasVecesInstSaludLoaded;

  const UltimasVecesInstSaludLoaded(this.ultimasVecesInstSaludLoaded)
      : super(ultimasVecesInstSalud: ultimasVecesInstSaludLoaded);
}

class UltimasVecesInstSaludError extends UltimasVecesInstSaludState {
  final String message;

  const UltimasVecesInstSaludError(this.message);
}
