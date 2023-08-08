import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/cereal_model.dart';
import '../../../data/models/especie_animal_model.dart';
import '../../../data/models/fruto_model.dart';
import '../../../data/models/hortaliza_model.dart';
import '../../../data/models/leguminosa_model.dart';
import '../../../data/models/tuberculo_platano_model.dart';
import '../../../data/models/verdura_model.dart';
import '../../../domain/entities/dim_ubicacion_entity.dart';
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
            const Text('Posee chagra'),
            BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
              builder: (context, state) {
                if (state is OpcionesSiNoLoaded) {
                  return FormField(
                    initialValue: _poseeChagra,
                    builder: (FormFieldState<int> formstate) => Column(
                      children: [
                        Column(
                            children: state.opcionesSiNoLoaded!
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
                    return FormField<List<LstTuberculo>>(
                      initialValue: dimUbicacionBloc.state.lstTuberculos,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos una opción.';
                        } else if (value.length > 4) {
                          return 'Máximo cuatro opciones.';
                        }
                        return null;
                      },
                      builder: (FormFieldState<List<LstTuberculo>> formState) {
                        return Column(
                          children: [
                            Wrap(
                              children: List<Widget>.generate(
                                state.tuberculosPlatanosLoaded!.length,
                                (index) {
                                  final e =
                                      state.tuberculosPlatanosLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: formState.value?.any((element) =>
                                                element.tuberculoPlatanoId ==
                                                e.tuberculoPlatanoId) ??
                                            false,
                                        onChanged: (bool? value) {
                                          var selectedItems =
                                              formState.value ?? [];
                                          if (value == true) {
                                            selectedItems.add(LstTuberculo(
                                                tuberculoPlatanoId:
                                                    e.tuberculoPlatanoId));
                                          } else {
                                            selectedItems.removeWhere(
                                              (element) =>
                                                  element.tuberculoPlatanoId ==
                                                  e.tuberculoPlatanoId,
                                            );
                                          }
                                          formState.didChange(selectedItems);
                                          dimUbicacionBloc.add(
                                              TuberculosPlatanosChanged(
                                                  selectedItems));
                                        },
                                      ),
                                      Flexible(
                                        child: Text(
                                          e.descripcion,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (index <
                                          state.tuberculosPlatanosLoaded!
                                                  .length -
                                              1)
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
                    return FormField<List<LstLeguminosa>>(
                      initialValue: dimUbicacionBloc.state.lstLeguminosas,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos una opción.';
                        } else if (value.length > 5) {
                          return 'Máximo cinco opciones.';
                        }
                        return null;
                      },
                      builder: (FormFieldState<List<LstLeguminosa>> formState) {
                        return Column(
                          children: [
                            Wrap(
                              children: List<Widget>.generate(
                                state.leguminosasLoaded!.length,
                                (index) {
                                  final e = state.leguminosasLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: formState.value?.any((element) =>
                                                element.leguminosaId ==
                                                e.leguminosaId) ??
                                            false,
                                        onChanged: (bool? value) {
                                          var selectedItems =
                                              formState.value ?? [];
                                          if (value == true) {
                                            selectedItems.add(LstLeguminosa(
                                                leguminosaId: e.leguminosaId));
                                          } else {
                                            selectedItems.removeWhere(
                                              (element) =>
                                                  element.leguminosaId ==
                                                  e.leguminosaId,
                                            );
                                          }
                                          formState.didChange(selectedItems);
                                          dimUbicacionBloc.add(
                                              LeguminosasChanged(
                                                  selectedItems));
                                        },
                                      ),
                                      Flexible(
                                        child: Text(
                                          e.descripcion,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (index <
                                          state.leguminosasLoaded!.length - 1)
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
                    return FormField<List<LstHortaliza>>(
                      initialValue: dimUbicacionBloc.state.lstHortalizas,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos una opción.';
                        } else if (value.length > 5) {
                          return 'Máximo cinco opciones.';
                        }
                        return null;
                      },
                      builder: (FormFieldState<List<LstHortaliza>> formState) {
                        return Column(
                          children: [
                            Wrap(
                              children: List<Widget>.generate(
                                state.hortalizasLoaded!.length,
                                (index) {
                                  final e = state.hortalizasLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: formState.value?.any((element) =>
                                                element.hortalizaId ==
                                                e.hortalizaId) ??
                                            false,
                                        onChanged: (bool? value) {
                                          var selectedItems =
                                              formState.value ?? [];
                                          if (value == true) {
                                            selectedItems.add(LstHortaliza(
                                                hortalizaId: e.hortalizaId));
                                          } else {
                                            selectedItems.removeWhere(
                                              (element) =>
                                                  element.hortalizaId ==
                                                  e.hortalizaId,
                                            );
                                          }
                                          formState.didChange(selectedItems);
                                          dimUbicacionBloc.add(
                                              HortalizasChanged(selectedItems));
                                        },
                                      ),
                                      Flexible(
                                        child: Text(
                                          e.descripcion,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (index <
                                          state.hortalizasLoaded!.length - 1)
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
                    return FormField<List<LstVerdura>>(
                      initialValue: dimUbicacionBloc.state.lstVerduras,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos una opción.';
                        } else if (value.length > 3) {
                          return 'Máximo tres opciones.';
                        }
                        return null;
                      },
                      builder: (FormFieldState<List<LstVerdura>> formState) {
                        return Column(
                          children: [
                            Wrap(
                              children: List<Widget>.generate(
                                state.verdurasLoaded!.length,
                                (index) {
                                  final e = state.verdurasLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: formState.value?.any((element) =>
                                                element.verduraId ==
                                                e.verduraId) ??
                                            false,
                                        onChanged: (bool? value) {
                                          var selectedItems =
                                              formState.value ?? [];
                                          if (value == true) {
                                            selectedItems.add(LstVerdura(
                                                verduraId: e.verduraId));
                                          } else {
                                            selectedItems.removeWhere(
                                              (element) =>
                                                  element.verduraId ==
                                                  e.verduraId,
                                            );
                                          }
                                          formState.didChange(selectedItems);
                                          dimUbicacionBloc.add(
                                              VerdurasChanged(selectedItems));
                                        },
                                      ),
                                      Flexible(
                                        child: Text(
                                          e.descripcion,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (index <
                                          state.verdurasLoaded!.length - 1)
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
                    return FormField<List<LstFruto>>(
                      initialValue: dimUbicacionBloc.state.lstFrutos,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos una opción.';
                        } else if (value.length > 5) {
                          return 'Máximo cinco opciones.';
                        }
                        return null;
                      },
                      builder: (FormFieldState<List<LstFruto>> formState) {
                        return Column(
                          children: [
                            Wrap(
                              children: List<Widget>.generate(
                                state.frutosLoaded!.length,
                                (index) {
                                  final e = state.frutosLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: formState.value?.any((element) =>
                                                element.frutoId == e.frutoId) ??
                                            false,
                                        onChanged: (bool? value) {
                                          var selectedItems =
                                              formState.value ?? [];
                                          if (value == true) {
                                            selectedItems.add(
                                                LstFruto(frutoId: e.frutoId));
                                          } else {
                                            selectedItems.removeWhere(
                                              (element) =>
                                                  element.frutoId == e.frutoId,
                                            );
                                          }
                                          formState.didChange(selectedItems);
                                          dimUbicacionBloc.add(
                                              FrutosChanged(selectedItems));
                                        },
                                      ),
                                      Flexible(
                                        child: Text(
                                          e.descripcion,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (index <
                                          state.frutosLoaded!.length - 1)
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
                    return FormField<List<LstCereal>>(
                      initialValue: dimUbicacionBloc.state.lstCereales,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Seleccione al menos una opción.';
                        } else if (value.length > 3) {
                          return 'Máximo tres opciones.';
                        }
                        return null;
                      },
                      builder: (FormFieldState<List<LstCereal>> formState) {
                        return Column(
                          children: [
                            Wrap(
                              children: List<Widget>.generate(
                                state.cerealesLoaded!.length,
                                (index) {
                                  final e = state.cerealesLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: formState.value?.any((element) =>
                                                element.cerealId ==
                                                e.cerealId) ??
                                            false,
                                        onChanged: (bool? value) {
                                          var selectedItems =
                                              formState.value ?? [];
                                          if (value == true) {
                                            selectedItems.add(LstCereal(
                                                cerealId: e.cerealId));
                                          } else {
                                            selectedItems.removeWhere(
                                              (element) =>
                                                  element.cerealId ==
                                                  e.cerealId,
                                            );
                                          }
                                          formState.didChange(selectedItems);
                                          dimUbicacionBloc.add(
                                              CerealesChanged(selectedItems));
                                        },
                                      ),
                                      Flexible(
                                        child: Text(
                                          e.descripcion,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (index <
                                          state.cerealesLoaded!.length - 1)
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
              return FormField<List<LstAnimalCria>>(
                initialValue: dimUbicacionBloc.state.lstAnimalCria,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione al menos una opción.';
                  } else if (value.length > 5) {
                    return 'Máximo cinco opciones.';
                  }
                  return null;
                },
                builder: (FormFieldState<List<LstAnimalCria>> formState) {
                  return Column(
                    children: [
                      Wrap(
                        children: List<Widget>.generate(
                          state.especiesAnimalesLoaded!.length,
                          (index) {
                            final e = state.especiesAnimalesLoaded![index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: formState.value?.any((element) =>
                                          element.especieAnimalCriaId ==
                                          e.especieAnimalCriaId) ??
                                      false,
                                  onChanged: (bool? value) {
                                    var selectedItems =
                                        List<LstAnimalCria>.from(
                                            formState.value ?? []);
                                    if (e.especieAnimalCriaId == 9) {
                                      selectedItems = [
                                        LstAnimalCria(
                                            especieAnimalCriaId:
                                                e.especieAnimalCriaId)
                                      ];
                                    } else if (value == true) {
                                      selectedItems.removeWhere((element) =>
                                          element.especieAnimalCriaId == 9);
                                      selectedItems.add(LstAnimalCria(
                                          especieAnimalCriaId:
                                              e.especieAnimalCriaId));
                                    } else {
                                      selectedItems.removeWhere(
                                        (element) =>
                                            element.especieAnimalCriaId ==
                                            e.especieAnimalCriaId,
                                      );
                                    }
                                    formState.didChange(selectedItems);
                                    dimUbicacionBloc.add(
                                        EspeciesAnimalesCriaChanged(
                                            selectedItems));
                                  },
                                ),
                                Flexible(
                                  child: Text(
                                    e.descripcion,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (index <
                                    state.especiesAnimalesLoaded!.length - 1)
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
              return DropdownButtonFormField<int>(
                value: _tipoCalendarioId,
                items: state.tiposCalendarioLoaded!
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
