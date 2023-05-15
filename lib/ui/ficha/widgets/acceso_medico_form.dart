import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/usecases/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_exports.dart';
import '../../../domain/usecases/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_exports.dart';
import '../../../domain/usecases/medio_utiliza_ca/medio_utiliza_ca_exports.dart';
import '../../../domain/usecases/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_exports.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
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
      setState(() {
        _existeMedTradicionalComunidad =
            widget.dimUbicacion?.existeMedTradicionalComunidad;
        _especialidadMedTradId = widget.dimUbicacion?.especialidadMedTradId;
        _tiempoTardaId = widget.dimUbicacion?.tiempoTardaId;
        _medioUtilizaId = widget.dimUbicacion?.medioUtilizaId;
        _dificultaAccesoId = widget.dimUbicacion?.dificultaAccesoId;
        _costoDesplazamientoCtrl.text =
            widget.dimUbicacion?.costoDesplazamientoMedTradicional.toString() ??
                '0';
        _nombreMedTradicionalCtrl.text =
            widget.dimUbicacion?.nombreMedTradicional ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dimUbicacionBloc = BlocProvider.of<DimUbicacionBloc>(context);

    return Column(children: [
      const Divider(),
      const Text(
        'ACCESO AL MEDICO TRADICIONAL MAS CERCANO',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      const SizedBox(height: 20),
      BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
        builder: (context, state) {
          if (state is OpcionesSiNoLoaded) {
            return FormField(
              initialValue: _existeMedTradicionalComunidad,
              builder: (FormFieldState<int> formstate) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Existe médico tradicional en la comunidad'),
                    Column(
                      children: state.opcionesSiNoLoaded!
                          .map(
                            (e) => RadioListTile(
                              title: Text(
                                e.descripcion,
                              ),
                              value: e.opcionId,
                              groupValue: _existeMedTradicionalComunidad,
                              onChanged: (int? value) {
                                setState(() {
                                  _existeMedTradicionalComunidad = value;
                                  formstate.didChange(value);
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                    formstate.hasError
                        ? const Text(
                            'Seleccione una opción',
                            style: TextStyle(color: Colors.red),
                          )
                        : Container(),
                  ],
                );
              },
              validator: (value) {
                if (value == null) {
                  return 'Seleccione una opción';
                }
                return null;
              },
              onSaved: (int? value) {
                dimUbicacionBloc
                    .add(ExisteMedTradicionalComunidadChanged(value!));
              },
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
                dimUbicacionBloc.add(EspecialidadMedTradChanged(newValue!));
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
                dimUbicacionBloc.add(TiempoTardaMedTradChanged(newValue!));
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
                dimUbicacionBloc.add(MedioUtilizaMedTradChanged(newValue!));
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
                dimUbicacionBloc
                    .add(DificultadAccesoMedTradicionalChanged(newValue!));
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
          dimUbicacionBloc
              .add(CostoDesplazamientoMedTradicionalChanged(int.parse(value!)));
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
          dimUbicacionBloc.add(NombreMedTradicionalChanged(value!));
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo Requerido';
          }
          return null;
        },
      )
    ]);
  }
}
