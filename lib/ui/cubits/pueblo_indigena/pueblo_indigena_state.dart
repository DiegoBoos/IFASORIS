part of 'pueblo_indigena_cubit.dart';

abstract class PueblosIndigenasState extends Equatable {
  final List<PuebloIndigenaEntity>? pueblosIndigenas;
  const PueblosIndigenasState({this.pueblosIndigenas});

  @override
  List<Object> get props => [];
}

class PueblosIndigenasInitial extends PueblosIndigenasState {}

class PueblosIndigenasLoading extends PueblosIndigenasState {}

class PueblosIndigenasLoaded extends PueblosIndigenasState {
  final List<PuebloIndigenaEntity>? pueblosIndigenasLoaded;

  const PueblosIndigenasLoaded(this.pueblosIndigenasLoaded)
      : super(pueblosIndigenas: pueblosIndigenasLoaded);
}

class PueblosIndigenasError extends PueblosIndigenasState {
  final String message;

  const PueblosIndigenasError(this.message);
}
