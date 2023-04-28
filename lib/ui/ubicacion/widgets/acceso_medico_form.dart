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
  String? _existeMedTradicionalComunidad;
  String? _especialidadMedTradId;
  String? _tiempoTardaId;
  String? _medioUtilizaId;
  String? _dificultaAccesoId;
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

    final dimUbicacion = await dimUbicacionCubit.getDimUbicacion(familiaId);

    setState(() {
      _existeMedTradicionalComunidad =
          dimUbicacion?.existeMedTradicionalComunidad.toString();
      _especialidadMedTradId = dimUbicacion?.especialidadMedTradId.toString();
      _tiempoTardaId = dimUbicacion?.tiempoTardaId.toString();
      _medioUtilizaId = dimUbicacion?.medioUtilizaId.toString();
      _dificultaAccesoId = dimUbicacion?.dificultaAccesoId.toString();
      _costoDesplazamientoCtrl.text =
          dimUbicacion?.costoDesplazamientoMedTradicional.toString() ?? '';
      _nombreMedTradicionalCtrl.text = dimUbicacion?.nombreMedTradicional ?? '';
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
                              child: RadioListTile<String>(
                                title: Text(
                                  e.descripcion,
                                ),
                                value: e.opcionId.toString(),
                                groupValue: _existeMedTradicionalComunidad,
                                onChanged: (String? value) {
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
              return DropdownButtonFormField<String>(
                value: _especialidadMedTradId,
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
                onChanged: (String? newValue) {
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
              return DropdownButtonFormField<String>(
                value: _tiempoTardaId,
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
                onChanged: (String? newValue) {
                  setState(() {
                    _tiempoTardaId = newValue;
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
                        'Medios que utiliza para el desplazamiento al médico tradicional',
                    border: OutlineInputBorder()),
                onChanged: (String? newValue) {
                  setState(() {
                    _medioUtilizaId = newValue;
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
        BlocBuilder<DificultadAccesoMedTradicionalByDptoCubit,
            DificultadesAccesoMedTradicionalByDptoState>(
          builder: (context, state) {
            if (state is DificultadesAccesoMedTradicionalByDptoLoaded) {
              return DropdownButtonFormField<String>(
                value: _dificultaAccesoId,
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
