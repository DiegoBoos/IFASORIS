part of 'leguminosa_by_dpto_cubit.dart';

abstract class LeguminosasByDptoState extends Equatable {
  final List<LeguminosaEntity>? leguminosasByDpto;
  const LeguminosasByDptoState({this.leguminosasByDpto});

  @override
  List<Object> get props => [];
}

class LeguminosasByDptoInitial extends LeguminosasByDptoState {}

class LeguminosasByDptoLoading extends LeguminosasByDptoState {}

class LeguminosasByDptoLoaded extends LeguminosasByDptoState {
  final List<LeguminosaEntity>? leguminosasByDptoLoaded;

  const LeguminosasByDptoLoaded(this.leguminosasByDptoLoaded)
      : super(leguminosasByDpto: leguminosasByDptoLoaded);
}

class LeguminosasByDptoError extends LeguminosasByDptoState {
  final String message;

  const LeguminosasByDptoError(this.message);
}
