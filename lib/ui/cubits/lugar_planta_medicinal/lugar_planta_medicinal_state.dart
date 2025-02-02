part of 'lugar_planta_medicinal_cubit.dart';

abstract class LugaresPlantasMedicinalesState extends Equatable {
  final List<LugarPlantaMedicinalEntity>? lugaresPlantasMedicinales;

  const LugaresPlantasMedicinalesState({this.lugaresPlantasMedicinales});

  @override
  List<Object> get props => [];
}

class LugaresPlantasMedicinalesInitial extends LugaresPlantasMedicinalesState {}

class LugaresPlantasMedicinalesLoading extends LugaresPlantasMedicinalesState {}

class LugaresPlantasMedicinalesLoaded extends LugaresPlantasMedicinalesState {
  final List<LugarPlantaMedicinalEntity>? lugaresPlantasMedicinalesLoaded;

  const LugaresPlantasMedicinalesLoaded(this.lugaresPlantasMedicinalesLoaded)
      : super(lugaresPlantasMedicinales: lugaresPlantasMedicinalesLoaded);
}

class LugaresPlantasMedicinalesError extends LugaresPlantasMedicinalesState {
  final String message;

  const LugaresPlantasMedicinalesError(this.message);
}
