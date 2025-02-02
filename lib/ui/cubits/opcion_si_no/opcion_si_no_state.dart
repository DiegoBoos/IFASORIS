part of 'opcion_si_no_cubit.dart';

abstract class OpcionesSiNoState extends Equatable {
  final List<OpcionSiNoEntity>? opcionesSiNo;
  const OpcionesSiNoState({this.opcionesSiNo});

  @override
  List<Object> get props => [];
}

class OpcionesSiNoInitial extends OpcionesSiNoState {}

class OpcionesSiNoLoading extends OpcionesSiNoState {}

class OpcionesSiNoLoaded extends OpcionesSiNoState {
  final List<OpcionSiNoEntity>? opcionesSiNoLoaded;

  const OpcionesSiNoLoaded(this.opcionesSiNoLoaded)
      : super(opcionesSiNo: opcionesSiNoLoaded);
}

class OpcionesSiNoError extends OpcionesSiNoState {
  final String message;

  const OpcionesSiNoError(this.message);
}
