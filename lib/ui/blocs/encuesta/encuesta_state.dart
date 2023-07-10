part of 'encuesta_bloc.dart';

class EncuestaState {
  final List<GrupoFamiliarEntity> afiliados;
  final double newPercentage;

  EncuestaState({this.afiliados = const [], this.newPercentage = 0.0});

  EncuestaState copyWith(
      {List<GrupoFamiliarEntity>? afiliados, double? newPercentage}) {
    return EncuestaState(
      afiliados: afiliados ?? this.afiliados,
      newPercentage: newPercentage ?? this.newPercentage,
    );
  }
}
