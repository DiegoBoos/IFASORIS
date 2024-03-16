import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/utils/validators/form_validators.dart';

import '../../../data/models/cereal_model.dart';
import '../../../data/models/especie_animal_model.dart';
import '../../../data/models/fruto_model.dart';
import '../../../data/models/hortaliza_model.dart';
import '../../../data/models/leguminosa_model.dart';
import '../../../data/models/tuberculo_platano_model.dart';
import '../../../data/models/verdura_model.dart';
import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../cubits/especie_animal/especie_animal_cubit.dart';
import '../../cubits/fruto/fruto_cubit.dart';
import '../../cubits/hortaliza/hortaliza_cubit.dart';
import '../../cubits/leguminosa/leguminosa_cubit.dart';
import '../../cubits/opcion_si_no/opcion_si_no_cubit.dart';
import '../../cubits/tipo_calendario/tipo_calendario_cubit.dart';
import '../../cubits/tuberculo_platano/tuberculo_platano_cubit.dart';
import '../../cubits/verdura/verdura_cubit.dart';
import '../../cubits/cereal/cereal_cubit.dart';
import '../helpers/cereales_helper.dart';
import '../helpers/especies_animales_cria_helper.dart';
import '../helpers/frutos_helper.dart';
import '../helpers/hortalizas_helper.dart';
import '../helpers/leguminosas_helper.dart';
import '../helpers/tuberculos_platano_helper.dart';
import '../helpers/verduras_helper.dart';

class AspectosTierraForm extends StatefulWidget {
  const AspectosTierraForm({super.key, this.dimUbicacion});
  final DimUbicacionEntity? dimUbicacion;

  @override
  State<AspectosTierraForm> createState() => AspectosTierraFormState();
}

class AspectosTierraFormState extends State<AspectosTierraForm> {
  int? _poseeChagra;
  int? _tipoCalendarioId;

  @override
  void initState() {
    super.initState();

    setState(() {
      _poseeChagra = widget.dimUbicacion?.poseeChagra;
      _tipoCalendarioId = widget.dimUbicacion?.tipoCalendarioId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimUbicacionBloc = BlocProvider.of<DimUbicacionBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final usuario = authBloc.state.usuario;
    String textAspectoSocioeconomico = '';
    switch (usuario!.departamentoId) {
      case 6:
        textAspectoSocioeconomico = 'Posee huerta o chagra';
        break;
      case 8:
        textAspectoSocioeconomico = 'Posee Ya tul o  Nasa tul';
        break;
      case 27:
        textAspectoSocioeconomico = 'Posee Ya tul o  Nasa tul';
        break;
      default:
        textAspectoSocioeconomico = 'Posee Chagra';
    }

    return Column(
      children: [
        const Divider(),
        const Text(
          'ASPECTOS SOCIOECONÓMICOS DE LA TIERRA',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        Column(
          children: [
            Text(textAspectoSocioeconomico),
            BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
              builder: (context, state) {
                if (state is OpcionesSiNoLoaded) {
                  final opcionesSiNoLoaded = state.opcionesSiNoLoaded!;
                  return FormField(
                    initialValue: _poseeChagra,
                    builder: (FormFieldState<int> formstate) => Column(
                      children: [
                        Column(
                            children: opcionesSiNoLoaded
                                .map(
                                  (e) => e.opcionId == 3
                                      ? Container()
                                      : RadioListTile(
                                          title: Text(e.descripcion),
                                          value: e.opcionId,
                                          groupValue: _poseeChagra,
                                          onChanged: (int? newValue) {
                                            if (newValue == 2) {
                                              dimUbicacionBloc.add(
                                                  const TuberculosPlatanosChanged(
                                                      []));

                                              dimUbicacionBloc.add(
                                                  const LeguminosasChanged([]));

                                              dimUbicacionBloc.add(
                                                  const HortalizasChanged([]));

                                              dimUbicacionBloc.add(
                                                  const VerdurasChanged([]));

                                              dimUbicacionBloc
                                                  .add(const FrutosChanged([]));

                                              dimUbicacionBloc.add(
                                                  const CerealesChanged([]));
                                            }
                                            setState(() {
                                              _poseeChagra = newValue!;
                                            });

                                            dimUbicacionBloc.add(
                                                PoseeChagraChanged(newValue!));
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
          ],
        ),
        if (_poseeChagra == 1)
          Column(
            children: [
              const Divider(),
              const Text(
                'Tubérculos que cultiva',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              BlocBuilder<TuberculoPlatanoCubit, TuberculosPlatanosState>(
                builder: (context, state) {
                  if (state is TuberculosPlatanosLoaded) {
                    final tuberculosPlatanosLoaded =
                        state.tuberculosPlatanosLoaded!;
                    int? optionId;

                    for (var e in tuberculosPlatanosLoaded) {
                      if (FormValidators.validateDescription(e.descripcion)) {
                        optionId = e.tuberculoPlatanoId;
                      }
                    }

                    return FormField<List<LstTuberculo>>(
                      initialValue: dimUbicacionBloc.state.lstTuberculos,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos una opción.';
                        }
                        return null;
                      },
                      builder: (FormFieldState<List<LstTuberculo>> formState) {
                        return Column(
                          children: [
                            Wrap(
                              children: List<Widget>.generate(
                                tuberculosPlatanosLoaded.length,
                                (index) {
                                  final tuberculoPlatano =
                                      tuberculosPlatanosLoaded[index];

                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: formState.value?.any((e) =>
                                                e.tuberculoPlatanoId ==
                                                tuberculoPlatano
                                                    .tuberculoPlatanoId) ??
                                            false,
                                        onChanged: (bool? value) {
                                          handleTuberculoPlatanoSelection(
                                              formState,
                                              optionId,
                                              context,
                                              value,
                                              tuberculoPlatano
                                                  .tuberculoPlatanoId,
                                              dimUbicacionBloc);
                                        },
                                      ),
                                      Flexible(
                                        child: Text(
                                          tuberculoPlatano.descripcion,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (index <
                                          tuberculosPlatanosLoaded.length - 1)
                                        const VerticalDivider(),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Text(
                              formState.errorText ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
              const Divider(),
              const Text(
                'Leguminosas que cultiva',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              BlocBuilder<LeguminosaCubit, LeguminosasState>(
                builder: (context, state) {
                  if (state is LeguminosasLoaded) {
                    final leguminosasLoaded = state.leguminosasLoaded!;
                    int? optionId;

                    for (var e in leguminosasLoaded) {
                      if (FormValidators.validateDescription(e.descripcion)) {
                        optionId = e.leguminosaId;
                      }
                    }

                    return FormField<List<LstLeguminosa>>(
                      initialValue: dimUbicacionBloc.state.lstLeguminosas,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos una opción.';
                        }
                        return null;
                      },
                      builder: (FormFieldState<List<LstLeguminosa>> formState) {
                        return Column(
                          children: [
                            Wrap(
                              children: List<Widget>.generate(
                                leguminosasLoaded.length,
                                (index) {
                                  final leguminosa = leguminosasLoaded[index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: formState.value?.any((e) =>
                                                e.leguminosaId ==
                                                leguminosa.leguminosaId) ??
                                            false,
                                        onChanged: (bool? value) {
                                          handleLeguminosaSelection(
                                              formState,
                                              optionId,
                                              context,
                                              value,
                                              leguminosa.leguminosaId,
                                              dimUbicacionBloc);
                                        },
                                      ),
                                      Flexible(
                                        child: Text(
                                          leguminosa.descripcion,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (index < leguminosasLoaded.length - 1)
                                        const VerticalDivider(),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Text(
                              formState.errorText ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
              const Divider(),
              const Text(
                'Hortalizas que cultiva',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              BlocBuilder<HortalizaCubit, HortalizasState>(
                builder: (context, state) {
                  if (state is HortalizasLoaded) {
                    final hortalizasLoaded = state.hortalizasLoaded!;
                    int? optionId;

                    for (var e in hortalizasLoaded) {
                      if (FormValidators.validateDescription(e.descripcion)) {
                        optionId = e.hortalizaId;
                      }
                    }

                    return FormField<List<LstHortaliza>>(
                      initialValue: dimUbicacionBloc.state.lstHortalizas,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos una opción.';
                        }
                        return null;
                      },
                      builder: (FormFieldState<List<LstHortaliza>> formState) {
                        return Column(
                          children: [
                            Wrap(
                              children: List<Widget>.generate(
                                hortalizasLoaded.length,
                                (index) {
                                  final hortaliza = hortalizasLoaded[index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: formState.value?.any((e) =>
                                                  e.hortalizaId ==
                                                  hortaliza.hortalizaId) ??
                                              false,
                                          onChanged: (bool? value) {
                                            handleHortalizaSelection(
                                                formState,
                                                optionId,
                                                context,
                                                value,
                                                hortaliza.hortalizaId,
                                                dimUbicacionBloc);
                                          }),
                                      Flexible(
                                        child: Text(
                                          hortaliza.descripcion,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (index < hortalizasLoaded.length - 1)
                                        const VerticalDivider(),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Text(
                              formState.errorText ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
              const Divider(),
              const Text(
                'Verduras que cultiva',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              BlocBuilder<VerduraCubit, VerdurasState>(
                builder: (context, state) {
                  if (state is VerdurasLoaded) {
                    final verdurasLoaded = state.verdurasLoaded!;
                    int? optionId;

                    for (var e in verdurasLoaded) {
                      if (FormValidators.validateDescription(e.descripcion)) {
                        optionId = e.verduraId;
                      }
                    }

                    return FormField<List<LstVerdura>>(
                      initialValue: dimUbicacionBloc.state.lstVerduras,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos una opción.';
                        }
                        return null;
                      },
                      builder: (FormFieldState<List<LstVerdura>> formState) {
                        return Column(
                          children: [
                            Wrap(
                              children: List<Widget>.generate(
                                verdurasLoaded.length,
                                (index) {
                                  final verdura = verdurasLoaded[index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: formState.value?.any((e) =>
                                                  e.verduraId ==
                                                  verdura.verduraId) ??
                                              false,
                                          onChanged: (bool? value) {
                                            handleVerduraSelection(
                                                formState,
                                                optionId,
                                                context,
                                                value,
                                                verdura.verduraId,
                                                dimUbicacionBloc);
                                          }),
                                      Flexible(
                                        child: Text(
                                          verdura.descripcion,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (index < verdurasLoaded.length - 1)
                                        const VerticalDivider(),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Text(
                              formState.errorText ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
              const Divider(),
              const Text(
                'Frutos que cultiva',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              BlocBuilder<FrutoCubit, FrutosState>(
                builder: (context, state) {
                  if (state is FrutosLoaded) {
                    final frutosLoaded = state.frutosLoaded!;
                    int? optionId;

                    for (var e in frutosLoaded) {
                      if (FormValidators.validateDescription(e.descripcion)) {
                        optionId = e.frutoId;
                      }
                    }

                    return FormField<List<LstFruto>>(
                      initialValue: dimUbicacionBloc.state.lstFrutos,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos una opción.';
                        }
                        return null;
                      },
                      builder: (FormFieldState<List<LstFruto>> formState) {
                        return Column(
                          children: [
                            Wrap(
                              children: List<Widget>.generate(
                                frutosLoaded.length,
                                (index) {
                                  final fruto = frutosLoaded[index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: formState.value?.any((e) =>
                                                  e.frutoId == fruto.frutoId) ??
                                              false,
                                          onChanged: (bool? value) {
                                            handleFrutoSelection(
                                                formState,
                                                optionId,
                                                context,
                                                value,
                                                fruto.frutoId,
                                                dimUbicacionBloc);
                                          }),
                                      Flexible(
                                        child: Text(
                                          fruto.descripcion,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (index < frutosLoaded.length - 1)
                                        const VerticalDivider(),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Text(
                              formState.errorText ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
              const Divider(),
              const Text(
                'Cereales que cultiva',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              BlocBuilder<CerealCubit, CerealesState>(
                builder: (context, state) {
                  if (state is CerealesLoaded) {
                    final cerealesLoaded = state.cerealesLoaded!;
                    int? optionId;

                    for (var e in cerealesLoaded) {
                      if (FormValidators.validateDescription(e.descripcion)) {
                        optionId = e.cerealId;
                      }
                    }

                    return FormField<List<LstCereal>>(
                      initialValue: dimUbicacionBloc.state.lstCereales,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos una opción.';
                        }
                        return null;
                      },
                      builder: (FormFieldState<List<LstCereal>> formState) {
                        return Column(
                          children: [
                            Wrap(
                              children: List<Widget>.generate(
                                cerealesLoaded.length,
                                (index) {
                                  final cereal = cerealesLoaded[index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: formState.value?.any((e) =>
                                                  e.cerealId ==
                                                  cereal.cerealId) ??
                                              false,
                                          onChanged: (bool? value) {
                                            handleCerealSelection(
                                                formState,
                                                optionId,
                                                context,
                                                value,
                                                cereal.cerealId,
                                                dimUbicacionBloc);
                                          }),
                                      Flexible(
                                        child: Text(
                                          cereal.descripcion,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (index < cerealesLoaded.length - 1)
                                        const VerticalDivider(),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Text(
                              formState.errorText ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        const Divider(),
        const Text(
          'Qué especie de animales cría',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        BlocBuilder<EspecieAnimalCubit, EspeciesAnimalesState>(
          builder: (context, state) {
            if (state is EspeciesAnimalesLoaded) {
              final especiesAnimalesLoaded = state.especiesAnimalesLoaded!;
              int? optionId;

              for (var e in especiesAnimalesLoaded) {
                if (FormValidators.validateDescription(e.descripcion)) {
                  optionId = e.especieAnimalCriaId;
                }
              }

              return FormField<List<LstAnimalCria>>(
                initialValue: dimUbicacionBloc.state.lstAnimalCria,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstAnimalCria>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          especiesAnimalesLoaded.length,
                          (index) {
                            final especieAnimal = especiesAnimalesLoaded[index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                    value: formState.value?.any((e) =>
                                            e.especieAnimalCriaId ==
                                            especieAnimal
                                                .especieAnimalCriaId) ??
                                        false,
                                    onChanged: (bool? value) {
                                      handleEspecieAnimalCriaSelection(
                                          formState,
                                          optionId,
                                          context,
                                          value,
                                          especieAnimal.especieAnimalCriaId,
                                          dimUbicacionBloc);
                                    }),
                                Flexible(
                                  child: Text(
                                    especieAnimal.descripcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (index < especiesAnimalesLoaded.length - 1)
                                  const VerticalDivider(),
                              ],
                            );
                          },
                        ),
                      ),
                      Text(
                        formState.errorText ?? '',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  );
                },
              );
            }
            return Container();
          },
        ),
        const SizedBox(height: 20),
        BlocBuilder<TipoCalendarioCubit, TiposCalendarioState>(
          builder: (context, state) {
            if (state is TiposCalendarioLoaded) {
              final tiposCalendarioLoaded = state.tiposCalendarioLoaded!;

              return DropdownButtonFormField<int>(
                value: _tipoCalendarioId,
                items: tiposCalendarioLoaded
                    .map(
                      (tipoCalendario) => DropdownMenuItem<int>(
                        value: tipoCalendario.tipoCalendarioId,
                        child: Text(tipoCalendario.descripcion),
                      ),
                    )
                    .toList(),
                decoration: const InputDecoration(
                    labelText: 'Tipo calendario', border: OutlineInputBorder()),
                onChanged: (int? newValue) {
                  setState(() {
                    _tipoCalendarioId = newValue;
                  });
                  dimUbicacionBloc.add(TipoCalendarioChanged(newValue!));
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
      ],
    );
  }
}
