part of 'leguminosa_cubit.dart';

abstract class LeguminosasState extends Equatable {
  final List<LeguminosaEntity>? leguminosas;
  const LeguminosasState({this.leguminosas});

  @override
  List<Object> get props => [];
}

class LeguminosasInitial extends LeguminosasState {}

class LeguminosasLoading extends LeguminosasState {}

class LeguminosasLoaded extends LeguminosasState {
  final List<LeguminosaEntity>? leguminosasLoaded;

  const LeguminosasLoaded(this.leguminosasLoaded)
      : super(leguminosas: leguminosasLoaded);
}

class LeguminosasError extends LeguminosasState {
  final String message;

  const LeguminosasError(this.message);
}
