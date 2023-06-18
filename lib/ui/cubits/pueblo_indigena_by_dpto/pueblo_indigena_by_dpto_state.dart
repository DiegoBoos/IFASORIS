part of 'pueblo_indigena_by_dpto_cubit.dart';

abstract class PueblosIndigenasByDptoState extends Equatable {
  final List<PuebloIndigenaEntity>? pueblosIndigenasByDpto;
  const PueblosIndigenasByDptoState({this.pueblosIndigenasByDpto});

  @override
  List<Object> get props => [];
}

class PueblosIndigenasByDptoInitial extends PueblosIndigenasByDptoState {}

class PueblosIndigenasByDptoLoading extends PueblosIndigenasByDptoState {}

class PueblosIndigenasByDptoLoaded extends PueblosIndigenasByDptoState {
  final List<PuebloIndigenaEntity>? pueblosIndigenasByDptoLoaded;

  const PueblosIndigenasByDptoLoaded(this.pueblosIndigenasByDptoLoaded)
      : super(pueblosIndigenasByDpto: pueblosIndigenasByDptoLoaded);
}

class PueblosIndigenasByDptoError extends PueblosIndigenasByDptoState {
  final String message;

  const PueblosIndigenasByDptoError(this.message);
}
