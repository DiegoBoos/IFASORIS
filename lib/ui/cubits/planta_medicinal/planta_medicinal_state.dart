part of 'planta_medicinal_cubit.dart';

abstract class PlantasMedicinalesState extends Equatable {
  final List<PlantaMedicinalEntity>? plantasMedicinales;

  const PlantasMedicinalesState({this.plantasMedicinales});

  @override
  List<Object> get props => [];
}

class PlantasMedicinalesInitial extends PlantasMedicinalesState {}

class PlantasMedicinalesLoading extends PlantasMedicinalesState {}

class PlantasMedicinalesLoaded extends PlantasMedicinalesState {
  final List<PlantaMedicinalEntity>? plantasMedicinalesLoaded;

  const PlantasMedicinalesLoaded(this.plantasMedicinalesLoaded)
      : super(plantasMedicinales: plantasMedicinalesLoaded);
}

class PlantasMedicinalesError extends PlantasMedicinalesState {
  final String message;

  const PlantasMedicinalesError(this.message);
}
