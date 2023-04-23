import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_exports.dart';
import '../../../domain/usecases/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_exports.dart';
import '../../../domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import '../../../domain/usecases/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_exports.dart';

class AccesoMedicoForm extends StatefulWidget {
  const AccesoMedicoForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AccesoMedicoForm> createState() => AccesoMedicoFormState();
}

class AccesoMedicoFormState extends State<AccesoMedicoForm> {
  String? _opcionRadioSeleccionada;
  String? _especialidadMTSeleccionada;
  String? _tiempoTardaMTSeleccionado;
  String? _medioUtilizaSeleccionado;
  String? _dificultadAccesoSeleccionado;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            height: 30,
            color: Colors.yellow[200],
            child: const Text(
              'ACCESO AL MEDICO TRADICIONAL MAS CERCANO',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        const SizedBox(height: 10),
        Row(
          children: [
            const Expanded(
                child: Text('Existe médico tradicional en su comunidad')),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('SI'),
                value: 'si',
                groupValue: _opcionRadioSeleccionada,
                onChanged: (value) {
                  setState(() {
                    _opcionRadioSeleccionada = value;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('NO'),
                value: 'no',
                groupValue: _opcionRadioSeleccionada,
                onChanged: (value) {
                  setState(() {
                    _opcionRadioSeleccionada = value;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        BlocBuilder<EspecialidadMedTradicionalByDptoCubit,
            EspecialidadesMedTradicionalByDptoState>(
          builder: (context, state) {
            if (state is EspecialidadesMedTradicionalByDptoLoaded) {
              return DropdownButtonFormField<String>(
                value: _especialidadMTSeleccionada,
                onChanged: (newValue) {
                  setState(() {
                    _especialidadMTSeleccionada = newValue;
                  });
                },
                items: state.especialidadesmedtradicionalByDptoLoaded!
                    .map(
                      (especialidadMedTradicional) => DropdownMenuItem<String>(
                        value: especialidadMedTradicional.especialidadMedTradId
                            .toString(),
                        child: Text(especialidadMedTradicional.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Especialidad del médico tradicional',
                    border: OutlineInputBorder()),
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 10),
        BlocBuilder<TiempoTardaMedTradicionalCubit,
            TiemposTardaMedTradicionalState>(
          builder: (context, state) {
            if (state is TiemposTardaMedTradicionalLoaded) {
              return DropdownButtonFormField<String>(
                value: _tiempoTardaMTSeleccionado,
                onChanged: (newValue) {
                  setState(() {
                    _tiempoTardaMTSeleccionado = newValue;
                  });
                },
                items: state.tiemposTardaMedTradicionalLoaded!
                    .map(
                      (tiempoTardaMedTradicional) => DropdownMenuItem<String>(
                        value: tiempoTardaMedTradicional.tiempoTardaMedTradId
                            .toString(),
                        child: Text(tiempoTardaMedTradicional.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText:
                        'Tiempo que tarda en llegar desde su casa al medico tradicional',
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
                value: _medioUtilizaSeleccionado,
                onChanged: (newValue) {
                  setState(() {
                    _medioUtilizaSeleccionado = newValue;
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
                        'Medios que utiliza para el desplazamiento al médico tradicional',
                    border: OutlineInputBorder()),
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 10),
        BlocBuilder<DificultadAccesoMedTradicionalByDptoCubit,
            DificultadesAccesoMedTradicionalByDptoState>(
          builder: (context, state) {
            if (state is DificultadesAccesoMedTradicionalByDptoLoaded) {
              return DropdownButtonFormField<String>(
                value: _dificultadAccesoSeleccionado,
                onChanged: (newValue) {
                  setState(() {
                    _dificultadAccesoSeleccionado = newValue;
                  });
                },
                items: state.dificultadesAccesoMedTradicionalByDptoLoaded!
                    .map(
                      (dificultadAccesoMedTradicionalByDpto) =>
                          DropdownMenuItem<String>(
                        value: dificultadAccesoMedTradicionalByDpto
                            .dificultadAccesoMedTradId
                            .toString(),
                        child: Text(
                            dificultadAccesoMedTradicionalByDpto.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText:
                        'Que dificultad de acceso tiene, para llegar donde el médico tradicional',
                    border: OutlineInputBorder()),
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Costo del desplazamiento a médico tradicional',
              border: OutlineInputBorder()),
          onChanged: (value) {},
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Nombre del médico tradicional',
              border: OutlineInputBorder()),
          onChanged: (value) {},
        ),
      ],
    );
  }
}
