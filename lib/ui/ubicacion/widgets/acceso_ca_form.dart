import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/costo_desplazamiento/costo_desplazamiento_exports.dart';
import '../../../domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_exports.dart';
import '../../../domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import '../../../domain/usecases/tiempo_tarda_ca/tiempo_tarda_ca_exports.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../cubits/dim_ubicacion/dim_ubicacion_state.dart';

class AccesoCAForm extends StatefulWidget {
  const AccesoCAForm({super.key});

  @override
  State<AccesoCAForm> createState() => AccesoCAFormState();
}

class AccesoCAFormState extends State<AccesoCAForm> {
  String? _tiempoTardaId;
  String? _medioUtilizaId;
  String? _dificultaAccesoId;
  String? _costoDesplazamientoId;

  @override
  void initState() {
    super.initState();
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );
    final afiliado = afiliadoPrefsBloc.state.afiliado!;
    if (afiliado.familiaId != null) {
      getDimUbicacion(afiliado.familiaId!);
    }
  }

  getDimUbicacion(int familiaId) async {
    final dimUbicacionCubit = BlocProvider.of<DimUbicacionCubit>(
      context,
    );

    final dimUbicacion = await dimUbicacionCubit.getDimUbicacion(familiaId);

    setState(() {
      _tiempoTardaId = dimUbicacion?.tiempoTardaId.toString();
      _medioUtilizaId = dimUbicacion?.medioUtilizaId.toString();
      _dificultaAccesoId = dimUbicacion?.dificultaAccesoId.toString();
      _costoDesplazamientoId = dimUbicacion?.costoDesplazamientoId.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimUbicacionCubit = BlocProvider.of<DimUbicacionCubit>(context);

    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            height: 30,
            color: Colors.yellow[200],
            child: const Text(
              'ACCESO AL CENTRO DE ATENCION DE SALUD MAS CERCANO',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        const SizedBox(height: 20),
        BlocBuilder<TiempoTardaCACubit, TiemposTardaCAState>(
          builder: (context, state) {
            if (state is TiemposTardaCALoaded) {
              return DropdownButtonFormField<String>(
                value: _tiempoTardaId,
                items: state.tiemposTardaCALoaded!
                    .map(
                      (tiempoTardaCA) => DropdownMenuItem<String>(
                        value: tiempoTardaCA.tiempoTardaId.toString(),
                        child: Text(tiempoTardaCA.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText:
                        'Tiempo que tarda en llegar desde su casa al centro de atención en Salud',
                    border: OutlineInputBorder()),
                onChanged: (String? newValue) {
                  setState(() {
                    _tiempoTardaId = newValue;
                  });
                  dimUbicacionCubit.changeTiempoTardaId(newValue);
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
              return DropdownButtonFormField<String>(
                value: _medioUtilizaId,
                items: state.mediosUtilizaCALoaded!
                    .map(
                      (medioUtilizaCA) => DropdownMenuItem<String>(
                        value: medioUtilizaCA.medioUtilizaId.toString(),
                        child: Text(medioUtilizaCA.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText:
                        'Medios que utiliza para el desplazamiento al centro de atención',
                    border: OutlineInputBorder()),
                onChanged: (String? newValue) {
                  setState(() {
                    _medioUtilizaId = newValue;
                  });
                  dimUbicacionCubit.changeMedioUtilizaId(newValue);
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
              return DropdownButtonFormField<String>(
                value: _dificultaAccesoId,
                items: state.dificultadesAccesoCALoaded!
                    .map(
                      (dificultadAccesoCA) => DropdownMenuItem<String>(
                        value: dificultadAccesoCA.dificultaAccesoId.toString(),
                        child: Text(dificultadAccesoCA.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Dificultad de acceso',
                    border: OutlineInputBorder()),
                onChanged: (String? newValue) {
                  setState(() {
                    _dificultaAccesoId = newValue;
                  });
                  dimUbicacionCubit.changeDificultaAccesoId(newValue);
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
              return DropdownButtonFormField<String>(
                value: _costoDesplazamientoId,
                items: state.costosDesplazamientoLoaded!
                    .map(
                      (costoDesplazamiento) => DropdownMenuItem<String>(
                        value: costoDesplazamiento.costoDesplazamientoId
                            .toString(),
                        child: Text(costoDesplazamiento.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Costo desplazamiento',
                    border: OutlineInputBorder()),
                onChanged: (String? newValue) {
                  setState(() {
                    _costoDesplazamientoId = newValue;
                  });
                  dimUbicacionCubit.changeCostoDesplazamientoId(newValue);
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
