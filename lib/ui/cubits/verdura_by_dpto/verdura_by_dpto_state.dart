part of 'verdura_by_dpto_cubit.dart';

abstract class VerdurasByDptoState extends Equatable {
  final List<VerduraEntity>? verdurasByDpto;
  const VerdurasByDptoState({this.verdurasByDpto});

  @override
  List<Object> get props => [];
}

class VerdurasByDptoInitial extends VerdurasByDptoState {}

class VerdurasByDptoLoading extends VerdurasByDptoState {}

class VerdurasByDptoLoaded extends VerdurasByDptoState {
  final List<VerduraEntity>? verdurasByDptoLoaded;

  const VerdurasByDptoLoaded(this.verdurasByDptoLoaded)
      : super(verdurasByDpto: verdurasByDptoLoaded);
}

class VerdurasByDptoError extends VerdurasByDptoState {
  final String message;

  const VerdurasByDptoError(this.message);
}
