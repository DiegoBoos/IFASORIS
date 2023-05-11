import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/usecases/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_exports.dart';
import '../../../domain/usecases/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_exports.dart';
import '../../../domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import '../../../domain/usecases/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_exports.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../cubits/dim_ubicacion/dim_ubicacion_state.dart';
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';

class AccesoMedicoForm extends StatefulWidget {
  const AccesoMedicoForm({super.key, this.dimUbicacion});

  final DimUbicacionEntity? dimUbicacion;

  @override
  State<AccesoMedicoForm> createState() => AccesoMedicoFormState();
}

class AccesoMedicoFormState extends State<AccesoMedicoForm> {
  int? _existeMedTradicionalComunidad;
  int? _especialidadMedTradId;
  int? _tiempoTardaId;
  int? _medioUtilizaId;
  int? _dificultaAccesoId;
  final _costoDesplazamientoCtrl = TextEditingController();
  final _nombreMedTradicionalCtrl = TextEditingController();

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

    final dimUbicacion = dimUbicacionCubit.state.dimUbicacion;

    setState(() {
      _existeMedTradicionalComunidad =
          dimUbicacion.existeMedTradicionalComunidad;
      _especialidadMedTradId = dimUbicacion.especialidadMedTradId;
      _tiempoTardaId = dimUbicacion.tiempoTardaId;
      _medioUtilizaId = dimUbicacion.medioUtilizaId;
      _dificultaAccesoId = dimUbicacion.dificultaAccesoId;
      _costoDesplazamientoCtrl.text =
          dimUbicacion.costoDesplazamientoMedTradicional.toString();
      _nombreMedTradicionalCtrl.text = dimUbicacion.nombreMedTradicional ?? '';
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
              'ACCESO AL MEDICO TRADICIONAL MAS CERCANO',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        const SizedBox(height: 20),
        BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
          builder: (context, state) {
            if (state is OpcionesSiNoLoaded) {
              return Wrap(
                children: [
                  const Text('Existe médico tradicional en su comunidad'),
                  Wrap(
                      children: state.opcionesSiNoLoaded!
                          .map<Widget>(
                            (e) => SizedBox(
                              height: 50,
                              child: RadioListTile<int>(
                                title: Text(
                                  e.descripcion,
                                ),
                                value: e.opcionId,
                                groupValue: _existeMedTradicionalComunidad,
                                onChanged: (int? value) {
                                  setState(() {
                                    _existeMedTradicionalComunidad = value;
                                  });
                                  dimUbicacionCubit
                                      .changeExisteMedTradicionalComunidad(
                                          value);
                                },
                              ),
                            ),
                          )
                          .toList())
                ],
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 20),
        BlocBuilder<EspecialidadMedTradicionalByDptoCubit,
            EspecialidadesMedTradicionalByDptoState>(
          builder: (context, state) {
            if (state is EspecialidadesMedTradicionalByDptoLoaded) {
              return DropdownButtonFormField<int>(
                value: _especialidadMedTradId,
                items: state.especialidadesmedtradicionalByDptoLoaded!
                    .map(
                      (especialidadMedTradicional) => DropdownMenuItem<int>(
                        value: especialidadMedTradicional.especialidadMedTradId,
                        child: Text(especialidadMedTradicional.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Especialidad del médico tradicional',
                    border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _especialidadMedTradId = newValue;
                  });
                  dimUbicacionCubit.changeEspecialidadMedTradId(newValue);
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
        BlocBuilder<TiempoTardaMedTradicionalCubit,
            TiemposTardaMedTradicionalState>(
          builder: (context, state) {
            if (state is TiemposTardaMedTradicionalLoaded) {
              return DropdownButtonFormField<int>(
                value: _tiempoTardaId,
                items: state.tiemposTardaMedTradicionalLoaded!
                    .map(
                      (tiempoTardaMedTradicional) => DropdownMenuItem<int>(
                        value: tiempoTardaMedTradicional.tiempoTardaMedTradId,
                        child: Text(tiempoTardaMedTradicional.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText:
                        'Tiempo que tarda en llegar desde su casa al medico tradicional',
                    border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _tiempoTardaId = newValue;
                  });
                  dimUbicacionCubit.changeTiempoTardaMedTradId(newValue);
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
                        'Medios que utiliza para el desplazamiento al médico tradicional',
                    border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _medioUtilizaId = newValue;
                  });
                  dimUbicacionCubit.changeMedioUtilizaMedTradId(newValue);
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
        BlocBuilder<DificultadAccesoMedTradicionalByDptoCubit,
            DificultadesAccesoMedTradicionalByDptoState>(
          builder: (context, state) {
            if (state is DificultadesAccesoMedTradicionalByDptoLoaded) {
              return DropdownButtonFormField<int>(
                value: _dificultaAccesoId,
                items: state.dificultadesAccesoMedTradicionalByDptoLoaded!
                    .map(
                      (dificultadAccesoMedTradicionalByDpto) =>
                          DropdownMenuItem<int>(
                        value: dificultadAccesoMedTradicionalByDpto
                            .dificultadAccesoMedTradId,
                        child: Text(
                            dificultadAccesoMedTradicionalByDpto.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText:
                        'Que dificultad de acceso tiene, para llegar donde el médico tradicional',
                    border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _dificultaAccesoId = newValue;
                  });
                  dimUbicacionCubit
                      .changeDificultadAccesoMedTradicional(newValue);
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
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _costoDesplazamientoCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              labelText: 'Costo del desplazamiento a médico tradicional',
              border: OutlineInputBorder()),
          onSaved: (String? value) {
            dimUbicacionCubit.changeCostoDesplazamientoMedTradicional(value);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo Requerido';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _nombreMedTradicionalCtrl,
          decoration: const InputDecoration(
              labelText: 'Nombre del médico tradicional',
              border: OutlineInputBorder()),
          onSaved: (String? value) {
            dimUbicacionCubit.changeNombreMedTradicional(value);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo Requerido';
            }
            return null;
          },
        ),
      ],
    );
  }
}
