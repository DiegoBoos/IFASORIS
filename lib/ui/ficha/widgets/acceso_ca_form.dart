import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/usecases/costo_desplazamiento/costo_desplazamiento_exports.dart';
import '../../../domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_exports.dart';
import '../../../domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import '../../../domain/usecases/tiempo_tarda_ca/tiempo_tarda_ca_exports.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';

class AccesoCAForm extends StatefulWidget {
  const AccesoCAForm({super.key, this.dimUbicacion});
  final DimUbicacionEntity? dimUbicacion;

  @override
  State<AccesoCAForm> createState() => AccesoCAFormState();
}

class AccesoCAFormState extends State<AccesoCAForm> {
  int? _tiempoTardaId;
  List<int> _selectedMediosUtilizaCA = [];
  List<int> _selectedDificultadesAccesoCA = [];
  int? _costoDesplazamientoId;

  String? _validateMediosUtilizaCA() {
    if (_selectedMediosUtilizaCA.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedMediosUtilizaCA.length > 3) {
      return 'Máximo tres opciones.';
    }
    return null;
  }

  String? _validateDificultadesAccesoCA() {
    if (_selectedDificultadesAccesoCA.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedDificultadesAccesoCA.length > 3) {
      return 'Máximo tres opciones.';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _tiempoTardaId = widget.dimUbicacion?.tiempoTardaId;
      _selectedMediosUtilizaCA = widget.dimUbicacion?.mediosUtilizaIds ?? [];
      _selectedDificultadesAccesoCA =
          widget.dimUbicacion?.dificultadesAccesoIds ?? [];
      _costoDesplazamientoId = widget.dimUbicacion?.costoDesplazamientoId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimUbicacionBloc = BlocProvider.of<DimUbicacionBloc>(context);

    return Column(
      children: [
        const Divider(),
        const Text(
          'ACCESO AL CENTRO DE ATENCION DE SALUD MAS CERCANO',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        const SizedBox(height: 20),
        BlocBuilder<TiempoTardaCACubit, TiemposTardaCAState>(
          builder: (context, state) {
            if (state is TiemposTardaCALoaded) {
              return DropdownButtonFormField<int>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                value: _tiempoTardaId,
                items: state.tiemposTardaCALoaded!
                    .map(
                      (tiempoTardaCA) => DropdownMenuItem<int>(
                        value: tiempoTardaCA.tiempoTardaId,
                        child: Text(tiempoTardaCA.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText:
                        'Tiempo que tarda en llegar desde su casa al centro de atención en Salud',
                    border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _tiempoTardaId = newValue;
                  });
                  dimUbicacionBloc.add(TiempoTardaChanged(newValue!));
                },
                validator: (value) {
                  if (value == null) {
                    return 'Campo Requerido';
                  }
                  return null;
                },
              );
            }
            return Container();
          },
        ),
        const Divider(),
        const Text(
          'Medios que utiliza para el desplazamiento al centro de atención',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<MedioUtilizaCACubit, MediosUtilizaCAState>(
          builder: (context, state) {
            if (state is MediosUtilizaCALoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _selectedMediosUtilizaCA,
                builder: (FormFieldState<List<int>> formstate) {
                  return Column(
                    children: [
                      Wrap(
                          children: List<Widget>.generate(
                              state.mediosUtilizaCALoaded!.length, (index) {
                        final e = state.mediosUtilizaCALoaded![index];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                                value: _selectedMediosUtilizaCA
                                    .contains(e.medioUtilizaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value!) {
                                      _selectedMediosUtilizaCA
                                          .add(e.medioUtilizaId);
                                    } else {
                                      _selectedMediosUtilizaCA
                                          .remove(e.medioUtilizaId);
                                    }
                                  });
                                }),
                            Flexible(
                              child: Text(
                                e.descripcion,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (index < state.mediosUtilizaCALoaded!.length - 1)
                              const VerticalDivider(),
                          ],
                        );
                      })),
                      Text(
                        _validateMediosUtilizaCA() ?? '',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  );
                },
                validator: (_) => _validateMediosUtilizaCA(),
                onSaved: (List<int>? value) {
                  dimUbicacionBloc.add(MediosUtilizaCAChanged(value!));
                },
              );
            }
            return Container();
          },
        ),
        const Divider(),
        const Text(
          'Dificultad de acceso',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<DificultadAccesoCACubit, DificultadesAccesoCAState>(
          builder: (context, state) {
            if (state is DificultadesAccesoCALoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _selectedDificultadesAccesoCA,
                builder: (FormFieldState<List<int>> formstate) {
                  return Column(
                    children: [
                      Wrap(
                          children: List<Widget>.generate(
                              state.dificultadesAccesoCALoaded!.length,
                              (index) {
                        final e = state.dificultadesAccesoCALoaded![index];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                                value: _selectedDificultadesAccesoCA
                                    .contains(e.dificultaAccesoId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.dificultaAccesoId == 5) {
                                      _selectedDificultadesAccesoCA = [
                                        e.dificultaAccesoId
                                      ];
                                    } else if (value!) {
                                      _selectedDificultadesAccesoCA.remove(5);
                                      _selectedDificultadesAccesoCA
                                          .add(e.dificultaAccesoId);
                                    } else {
                                      _selectedDificultadesAccesoCA
                                          .remove(e.dificultaAccesoId);
                                    }
                                  });
                                }),
                            Flexible(
                              child: Text(
                                e.descripcion,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (index <
                                state.dificultadesAccesoCALoaded!.length - 1)
                              const VerticalDivider(),
                          ],
                        );
                      })),
                      Text(
                        _validateDificultadesAccesoCA() ?? '',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  );
                },
                validator: (_) => _validateDificultadesAccesoCA(),
                onSaved: (List<int>? value) {
                  dimUbicacionBloc.add(DificultadesAccesoCAChanged(value!));
                },
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 20),
        BlocBuilder<CostoDesplazamientoCubit, CostosDesplazamientoState>(
          builder: (context, state) {
            if (state is CostosDesplazamientoLoaded) {
              return DropdownButtonFormField<int>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                value: _costoDesplazamientoId,
                items: state.costosDesplazamientoLoaded!
                    .map(
                      (costoDesplazamiento) => DropdownMenuItem<int>(
                        value: costoDesplazamiento.costoDesplazamientoId,
                        child: Text(costoDesplazamiento.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Costo desplazamiento',
                    border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _costoDesplazamientoId = newValue;
                  });
                  dimUbicacionBloc.add(CostoDesplazamientoChanged(newValue!));
                },
                validator: (value) {
                  if (value == null) {
                    return 'Campo Requerido';
                  }
                  return null;
                },
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
