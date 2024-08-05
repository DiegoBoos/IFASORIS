import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/estilo_vida_saludable/estilo_vida_saludable_exports.dart';
import 'package:ifasoris/ui/cubits/consumo_alcohol/consumo_alcohol_cubit.dart';

import '../../../domain/entities/grupo_familiar.dart';
import '../../cubits/actividad_fisica/actividad_fisica_cubit.dart';
import '../../cubits/alimentacion/alimentacion_cubit.dart';
import '../../cubits/cigarrillo_dia/cigarrillo_dia_cubit.dart';
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';

class EstilosVidaSaludableForm extends StatefulWidget {
  const EstilosVidaSaludableForm(
      {super.key,
      required this.currentAfiliado,
      required this.estiloVidaSaludable});

  final GrupoFamiliarEntity currentAfiliado;
  final EstiloVidaSaludableEntity estiloVidaSaludable;

  @override
  State<EstilosVidaSaludableForm> createState() =>
      _EstilosVidaSaludableFormState();
}

class _EstilosVidaSaludableFormState extends State<EstilosVidaSaludableForm> {
  final _nombresApellidosCtrl = TextEditingController();
  int? _actividadFisicaId;
  int? _alimentacionId;
  int? _consumoCigarrillo;
  int? _numeroCigarrillosDiaId;
  int? _consumoAlcoholId;
  int? _consumoSustanciaId;

  @override
  void initState() {
    super.initState();
    _nombresApellidosCtrl.text = '${widget.currentAfiliado.nombre1} '
        '${widget.currentAfiliado.nombre2} '
        '${widget.currentAfiliado.apellido1} '
        '${widget.currentAfiliado.apellido2}';

    setState(() {
      _actividadFisicaId = widget.estiloVidaSaludable.actividadFisicaId;
      _alimentacionId = widget.estiloVidaSaludable.alimentacionId;
      _consumoCigarrillo = widget.estiloVidaSaludable.consumeCigarrillo;
      _numeroCigarrillosDiaId =
          widget.estiloVidaSaludable.numeroCigarrilloDiaId == 0
              ? null
              : widget.estiloVidaSaludable.numeroCigarrilloDiaId;
      _consumoAlcoholId = widget.estiloVidaSaludable.consumoAlcoholId;
      _consumoSustanciaId =
          widget.estiloVidaSaludable.consumoSustanciasPsicoactivas;
    });
  }

  @override
  Widget build(BuildContext context) {
    final estiloVidaSaludableBloc =
        BlocProvider.of<EstiloVidaSaludableBloc>(context);
    return ListView(children: [
      const Divider(),
      const Text(
        'IV. ESTILOS DE VIDA SALUDABLE',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      const SizedBox(height: 20),
      TextFormField(
        enabled: false,
        controller: _nombresApellidosCtrl,
        decoration: const InputDecoration(
          labelText: 'Integrante Grupo Familiar',
          border: OutlineInputBorder(),
        ),
      ),
      const Divider(),
      const Text(
        'Actividad física',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<ActividadFisicaCubit, ActividadesFisicasState>(
        builder: (context, state) {
          if (state is ActividadesFisicasLoaded) {
            final actividadesFisicas = state.actividadesFisicasLoaded!;

            return DropdownButtonFormField<int>(
              value: _actividadFisicaId,
              items: actividadesFisicas
                  .map(
                    (actividadFisica) => DropdownMenuItem<int>(
                      value: actividadFisica.actividadFisicaId,
                      child: Text(actividadFisica.descripcion ?? ,
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                  labelText: 'Seleccione una opción',
                  border: OutlineInputBorder()),
              onChanged: (int? newValue) {
                setState(() {
                  _actividadFisicaId = newValue;
                });
                estiloVidaSaludableBloc.add(ActividadFisicaChanged(newValue!));
              },
              validator: (value) {
                if (value == null) {
                  return 'Campo Requerido';
                }
                return null;
              },
            );
          } else {
            return Container();
          }
        },
      ),
      const Divider(),
      const Text(
        'Alimentación',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<AlimentacionCubit, AlimentacionesState>(
        builder: (context, state) {
          if (state is AlimentacionesLoaded) {
            final alimentacionesLoaded = state.alimentacionesLoaded!;
            return DropdownButtonFormField<int>(
              isExpanded: true,
              value: _alimentacionId,
              items: alimentacionesLoaded
                  .map(
                    (alimentacion) => DropdownMenuItem<int>(
                      value: alimentacion.alimentacionId,
                      child: Text(alimentacion.descripcion ?? ,
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                  labelText: 'Seleccione una opción',
                  border: OutlineInputBorder()),
              onChanged: (int? newValue) {
                setState(() {
                  _alimentacionId = newValue;
                });
                estiloVidaSaludableBloc.add(AlimentacionChanged(newValue!));
              },
              validator: (value) {
                if (value == null) {
                  return 'Campo Requerido';
                }
                return null;
              },
            );
          } else {
            return Container();
          }
        },
      ),
      const Divider(),
      const Text(
        'Consumo de cigarrillo',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
        builder: (context, state) {
          if (state is OpcionesSiNoLoaded) {
            final opcionesSiNoLoaded = state.opcionesSiNoLoaded!;

            return FormField(
              initialValue: _consumoCigarrillo,
              builder: (FormFieldState<int> formstate) => Column(
                children: [
                  Column(
                      children: opcionesSiNoLoaded
                          .map(
                            (e) => e.opcionId == 3
                                ? Container()
                                : RadioListTile<int?>(
                                    title: Text(e.descripcion ?? ,
                                    value: e.opcionId,
                                    groupValue: _consumoCigarrillo,
                                    onChanged: (int? newValue) {
                                      if (newValue == 2) {
                                        setState(() {
                                          _consumoCigarrillo = newValue!;
                                          _numeroCigarrillosDiaId = null;
                                        });
                                        estiloVidaSaludableBloc.add(
                                            const NumeroCigarrillosDiaChanged(
                                                0));
                                      } else {
                                        setState(() {
                                          _consumoCigarrillo = newValue!;
                                        });
                                      }
                                      estiloVidaSaludableBloc.add(
                                          ConsumeCigarrilloChanged(newValue!));
                                      formstate.didChange(newValue);
                                    },
                                  ),
                          )
                          .toList()),
                  formstate.hasError
                      ? const Text(
                          'Seleccione una opción',
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                ],
              ),
              validator: (value) {
                if (value == null) {
                  return 'Campo requerido';
                }
                return null;
              },
            );
          } else {
            return Container();
          }
        },
      ),
      if (_consumoCigarrillo == 1)
        Column(
          children: [
            const Divider(),
            const Text(
              'Número de cigarrillos por día',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            BlocBuilder<CigarrilloDiaCubit, CigarrillosDiaState>(
              builder: (context, state) {
                if (state is CigarrillosDiaLoaded) {
                  final cigarrillosDiaLoaded = state.cigarrillosDiaLoaded!;

                  return DropdownButtonFormField<int>(
                    value: _numeroCigarrillosDiaId,
                    items: cigarrillosDiaLoaded
                        .map(
                          (numeroCigarrilloDia) => DropdownMenuItem<int>(
                            value: numeroCigarrilloDia.numeroCigarrilloDiaId,
                            child: Text(numeroCigarrilloDia.descripcion ?? ,
                          ),
                        )
                        .toList(),
                    decoration: const InputDecoration(
                        labelText: 'Seleccione una opción',
                        border: OutlineInputBorder()),
                    onChanged: (int? newValue) {
                      setState(() {
                        _numeroCigarrillosDiaId = newValue!;
                      });
                      estiloVidaSaludableBloc
                          .add(NumeroCigarrillosDiaChanged(newValue!));
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Campo Requerido';
                      }
                      return null;
                    },
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      const Divider(),
      const Text(
        'Consumo de alcohol',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<ConsumoAlcoholCubit, ConsumosAlcoholState>(
        builder: (context, state) {
          if (state is ConsumosAlcoholLoaded) {
            final consumosAlcoholLoaded = state.consumosAlcoholLoaded!;

            return DropdownButtonFormField<int>(
              value: _consumoAlcoholId,
              items: consumosAlcoholLoaded
                  .map(
                    (consumoAlcohol) => DropdownMenuItem<int>(
                      value: consumoAlcohol.consumoAlcoholId,
                      child: Text(consumoAlcohol.descripcion ?? ,
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                  labelText: 'Seleccione una opción',
                  border: OutlineInputBorder()),
              onChanged: (int? newValue) {
                setState(() {
                  _consumoAlcoholId = newValue!;
                });
                estiloVidaSaludableBloc.add(ConsumoAlcoholChanged(newValue!));
              },
              validator: (value) {
                if (value == null) {
                  return 'Campo Requerido';
                }
                return null;
              },
            );
          } else {
            return Container();
          }
        },
      ),
      const Divider(),
      const Text(
        'Consumo de otras sustancias Psicoactivas',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Divider(),
      BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
        builder: (context, state) {
          if (state is OpcionesSiNoLoaded) {
            final opcionesSiNoLoaded = state.opcionesSiNoLoaded!;

            return FormField(
              initialValue: _consumoSustanciaId,
              builder: (FormFieldState<int> formstate) => Column(
                children: [
                  Column(
                      children: opcionesSiNoLoaded
                          .map(
                            (e) => e.opcionId == 3
                                ? Container()
                                : RadioListTile<int?>(
                                    title: Text(e.descripcion ?? ,
                                    value: e.opcionId,
                                    groupValue: _consumoSustanciaId,
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        _consumoSustanciaId = newValue!;
                                      });

                                      estiloVidaSaludableBloc.add(
                                          ConsumoSustanciasChanged(newValue!));
                                      formstate.didChange(newValue);
                                    },
                                  ),
                          )
                          .toList()),
                  formstate.hasError
                      ? const Text(
                          'Seleccione una opción',
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                ],
              ),
              validator: (value) {
                if (value == null) {
                  return 'Campo requerido';
                }
                return null;
              },
            );
          } else {
            return Container();
          }
        },
      ),
    ]);
  }
}
