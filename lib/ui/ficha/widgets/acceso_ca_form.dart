import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/usecases/costo_desplazamiento/costo_desplazamiento_exports.dart';
import '../../../domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_exports.dart';
import '../../../domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import '../../../domain/usecases/tiempo_tarda_ca/tiempo_tarda_ca_exports.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';

class AccesoCAForm extends StatefulWidget {
  const AccesoCAForm({super.key, this.dimUbicacion});
  final DimUbicacionEntity? dimUbicacion;

  @override
  State<AccesoCAForm> createState() => AccesoCAFormState();
}

class AccesoCAFormState extends State<AccesoCAForm> {
  int? _tiempoTardaId;
  int? _medioUtilizaId;
  int? _dificultaAccesoId;
  int? _costoDesplazamientoId;

  @override
  void initState() {
    super.initState();
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );
    final afiliado = afiliadoPrefsBloc.state.afiliado!;

    if (afiliado.familiaId != null) {
      setState(() {
        _tiempoTardaId = widget.dimUbicacion?.tiempoTardaId;
        _medioUtilizaId = widget.dimUbicacion?.medioUtilizaId;
        _dificultaAccesoId = widget.dimUbicacion?.dificultaAccesoId;
        _costoDesplazamientoId = widget.dimUbicacion?.costoDesplazamientoId;
      });
    }
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
        const SizedBox(height: 20),
        BlocBuilder<MedioUtilizaCACubit, MediosUtilizaCAState>(
          builder: (context, state) {
            if (state is MediosUtilizaCALoaded) {
              return DropdownButtonFormField<int>(
                value: _medioUtilizaId,
                items: state.mediosUtilizaCALoaded!
                    .map(
                      (medioUtilizaCA) => DropdownMenuItem<int>(
                        value: medioUtilizaCA.medioUtilizaId,
                        child: Text(medioUtilizaCA.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText:
                        'Medios que utiliza para el desplazamiento al centro de atención',
                    border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _medioUtilizaId = newValue;
                  });
                  dimUbicacionBloc.add(MedioUtilizaChanged(newValue!));
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
        BlocBuilder<DificultadAccesoCACubit, DificultadesAccesoCAState>(
          builder: (context, state) {
            if (state is DificultadesAccesoCALoaded) {
              return DropdownButtonFormField<int>(
                value: _dificultaAccesoId,
                items: state.dificultadesAccesoCALoaded!
                    .map(
                      (dificultadAccesoCA) => DropdownMenuItem<int>(
                        value: dificultadAccesoCA.dificultaAccesoId,
                        child: Text(dificultadAccesoCA.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Dificultad de acceso',
                    border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _dificultaAccesoId = newValue;
                  });
                  dimUbicacionBloc.add(DificultaAccesoChanged(newValue!));
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
        BlocBuilder<CostoDesplazamientoCubit, CostosDesplazamientoState>(
          builder: (context, state) {
            if (state is CostosDesplazamientoLoaded) {
              return DropdownButtonFormField<int>(
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
