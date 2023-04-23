import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/costo_desplazamiento/costo_desplazamiento_exports.dart';
import '../../../domain/usecases/dificultad_acceso_ca/dificultad_acceso_ca_exports.dart';
import '../../../domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import '../../../domain/usecases/tiempo_tarda_ca/tiempo_tarda_ca_exports.dart';

class AccesoCAForm extends StatefulWidget {
  const AccesoCAForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AccesoCAForm> createState() => AccesoCAFormState();
}

class AccesoCAFormState extends State<AccesoCAForm> {
  String? _tiempoTardaCASeleccionado;
  String? _medioUtilizaCASeleccionado;
  String? _dificultadAccesoSeleccionado;
  String? _costoDesplazamientoSeleccionado;

  @override
  Widget build(BuildContext context) {
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
        const SizedBox(height: 10),
        BlocBuilder<TiempoTardaCACubit, TiemposTardaCAState>(
          builder: (context, state) {
            if (state is TiemposTardaCALoaded) {
              return DropdownButtonFormField<String>(
                value: _tiempoTardaCASeleccionado,
                onChanged: (newValue) {
                  setState(() {
                    _tiempoTardaCASeleccionado = newValue;
                  });
                },
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
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 10),
        BlocBuilder<MedioUtilizaCACubit, MediosUtilizaCAState>(
          builder: (context, state) {
            if (state is MediosUtilizaCALoaded) {
              return DropdownButtonFormField<String>(
                value: _medioUtilizaCASeleccionado,
                onChanged: (newValue) {
                  setState(() {
                    _medioUtilizaCASeleccionado = newValue;
                  });
                },
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
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 10),
        BlocBuilder<DificultadAccesoCACubit, DificultadesAccesoCAState>(
          builder: (context, state) {
            if (state is DificultadesAccesoCALoaded) {
              return DropdownButtonFormField<String>(
                value: _dificultadAccesoSeleccionado,
                onChanged: (newValue) {
                  setState(() {
                    _dificultadAccesoSeleccionado = newValue;
                  });
                },
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
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 10),
        BlocBuilder<CostoDesplazamientoCubit, CostosDesplazamientoState>(
          builder: (context, state) {
            if (state is CostosDesplazamientoLoaded) {
              return DropdownButtonFormField<String>(
                value: _costoDesplazamientoSeleccionado,
                onChanged: (newValue) {
                  setState(() {
                    _costoDesplazamientoSeleccionado = newValue;
                  });
                },
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
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
