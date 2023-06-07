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
import '../../../domain/usecases/opcion_si_no/opcion_si_no_exports.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../cubits/especie_animal_by_dpto/especie_animal_by_dpto_cubit.dart';
import '../../cubits/fruto_by_dpto/fruto_by_dpto_cubit.dart';
import '../../cubits/hortaliza_by_dpto/hortaliza_by_dpto_cubit.dart';
import '../../cubits/leguminosa_by_dpto/leguminosa_by_dpto_cubit.dart';
import '../../cubits/tipo_calendario/tipo_calendario_cubit.dart';
import '../../cubits/tuberculo_platano_by_dpto/tuberculo_platano_by_dpto_cubit.dart';
import '../../cubits/verdura_by_dpto/verdura_by_dpto_cubit.dart';
import '../../cubits/cereal_by_dpto/cereal_by_dpto_cubit.dart';

class AspectosTierraForm extends StatefulWidget {
  const AspectosTierraForm({super.key, this.dimUbicacion});
  final DimUbicacionEntity? dimUbicacion;

  @override
  State<AspectosTierraForm> createState() => AspectosTierraFormState();
}

class AspectosTierraFormState extends State<AspectosTierraForm> {
  int? _poseeChagra;
  int? _tipoCalendarioId;
  List<LstTuberculo> _selectedTuberculosPlatanos = [];
  List<LstAnimalCria> _selectedEspeciesAnimales = [];
  List<LstLeguminosa> _selectedLeguminosasByDpto = [];
  List<LstHortaliza> _selectedHortalizasByDpto = [];
  List<LstVerdura> _selectedVerdurasByDpto = [];
  List<LstFruto> _selectedFrutosByDpto = [];
  List<LstCereal> _selectedCerealesByDpto = [];

  String? _validateTuberculosPlatanos() {
    if (_selectedTuberculosPlatanos.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedTuberculosPlatanos.length > 4) {
      return 'Máximo cuatro opciones.';
    }
    return null;
  }

  String? _validateEspeciesAnimales() {
    if (_selectedEspeciesAnimales.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedEspeciesAnimales.length > 5) {
      return 'Máximo cinco opciones.';
    }
    return null;
  }

  String? _validateLeguminosas() {
    if (_selectedLeguminosasByDpto.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedLeguminosasByDpto.length > 5) {
      return 'Máximo cinco opciones.';
    }
    return null;
  }

  String? _validateHortalizas() {
    if (_selectedHortalizasByDpto.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedHortalizasByDpto.length > 5) {
      return 'Máximo cinco opciones.';
    }
    return null;
  }

  String? _validateVerduras() {
    if (_selectedVerdurasByDpto.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedVerdurasByDpto.length > 3) {
      return 'Máximo tres opciones.';
    }
    return null;
  }

  String? _validateFrutos() {
    if (_selectedFrutosByDpto.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedFrutosByDpto.length > 5) {
      return 'Máximo cinco opciones.';
    }
    return null;
  }

  String? _validateCereales() {
    if (_selectedCerealesByDpto.isEmpty) {
      return 'Seleccione al menos una opción.';
    } else if (_selectedCerealesByDpto.length > 3) {
      return 'Máximo tres opciones.';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _poseeChagra = widget.dimUbicacion?.poseeChagra;
      _tipoCalendarioId = widget.dimUbicacion?.tipoCalendarioId;
    });
    getOptions();
  }

  Future<void> getOptions() async {
    final tuberculoPlatanoByDptoCubit =
        BlocProvider.of<TuberculoPlatanoByDptoCubit>(
      context,
    );

    final leguminosaByDptoCubit = BlocProvider.of<LeguminosaByDptoCubit>(
      context,
    );

    final hortalizaByDptoCubit = BlocProvider.of<HortalizaByDptoCubit>(
      context,
    );
    final verduraByDptoCubit = BlocProvider.of<VerduraByDptoCubit>(
      context,
    );
    final frutoByDptoCubit = BlocProvider.of<FrutoByDptoCubit>(
      context,
    );
    final cerealByDptoCubit = BlocProvider.of<CerealByDptoCubit>(
      context,
    );
    final especieAnimalByDptoCubit = BlocProvider.of<EspecieAnimalByDptoCubit>(
      context,
    );

    _selectedTuberculosPlatanos = await tuberculoPlatanoByDptoCubit
        .getUbicacionTuberculosPlatanosDB(widget.dimUbicacion?.ubicacionId);

    _selectedLeguminosasByDpto = await leguminosaByDptoCubit
        .getUbicacionLeguminosasDB(widget.dimUbicacion?.ubicacionId);

    _selectedHortalizasByDpto = await hortalizaByDptoCubit
        .getUbicacionHortalizasDB(widget.dimUbicacion?.ubicacionId);

    _selectedVerdurasByDpto = await verduraByDptoCubit
        .getUbicacionVerdurasDB(widget.dimUbicacion?.ubicacionId);

    _selectedFrutosByDpto = await frutoByDptoCubit
        .getUbicacionFrutosDB(widget.dimUbicacion?.ubicacionId);

    _selectedCerealesByDpto = await cerealByDptoCubit
        .getUbicacionCerealesDB(widget.dimUbicacion?.ubicacionId);

    _selectedEspeciesAnimales = await especieAnimalByDptoCubit
        .getUbicacionEspeciesAnimalesDB(widget.dimUbicacion?.ubicacionId);
    setState(() {});
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
        const SizedBox(height: 20),
        BlocBuilder<OpcionSiNoCubit, OpcionesSiNoState>(
          builder: (context, state) {
            if (state is OpcionesSiNoLoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _poseeChagra,
                builder: (FormFieldState<int> formstate) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Posee chagra'),
                      Column(
                        children: state.opcionesSiNoLoaded!
                            .map(
                              (e) => RadioListTile(
                                title: Text(
                                  e.descripcion,
                                ),
                                value: e.opcionId,
                                groupValue: _poseeChagra,
                                onChanged: (int? value) {
                                  setState(() {
                                    _poseeChagra = value;
                                    formstate.didChange(value);
                                    if (_poseeChagra != 1) {
                                      _selectedTuberculosPlatanos = [];
                                      dimUbicacionBloc.add(
                                          const TuberculosPlatanosChanged([]));

                                      _selectedLeguminosasByDpto = [];
                                      dimUbicacionBloc
                                          .add(const LeguminosasChanged([]));

                                      _selectedHortalizasByDpto = [];
                                      dimUbicacionBloc
                                          .add(const HortalizasChanged([]));

                                      _selectedVerdurasByDpto = [];
                                      dimUbicacionBloc
                                          .add(const VerdurasChanged([]));

                                      _selectedFrutosByDpto = [];
                                      dimUbicacionBloc
                                          .add(const FrutosChanged([]));

                                      _selectedCerealesByDpto = [];
                                      dimUbicacionBloc
                                          .add(const CerealesChanged([]));
                                    }
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
                  dimUbicacionBloc.add(PoseeChagraChanged(value!));
                },
              );
            }
            return Container();
          },
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
              BlocBuilder<TuberculoPlatanoByDptoCubit,
                  TuberculosPlatanosByDptoState>(
                builder: (context, state) {
                  if (state is TuberculosPlatanosByDptoLoaded) {
                    return FormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: _selectedTuberculosPlatanos,
                      builder: (FormFieldState<List<LstTuberculo>> formstate) {
                        return Column(
                          children: [
                            Wrap(
                                children: List<Widget>.generate(
                                    state.tuberculosPlatanosByDptoLoaded!
                                        .length, (index) {
                              final e =
                                  state.tuberculosPlatanosByDptoLoaded![index];
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                      value: _selectedTuberculosPlatanos.any(
                                          (element) =>
                                              element.tuberculoPlatanoId ==
                                              e.tuberculoPlatanoId),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            _selectedTuberculosPlatanos.add(
                                                LstTuberculo(
                                                    tuberculoPlatanoId:
                                                        e.tuberculoPlatanoId));
                                          } else {
                                            _selectedTuberculosPlatanos
                                                .removeWhere(
                                              (element) =>
                                                  element.tuberculoPlatanoId ==
                                                  e.tuberculoPlatanoId,
                                            );
                                          }
                                        });
                                      }),
                                  Flexible(
                                    child: Text(
                                      e.descripcion,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (index <
                                      state.tuberculosPlatanosByDptoLoaded!
                                              .length -
                                          1)
                                    const VerticalDivider(),
                                ],
                              );
                            })),
                            Text(
                              _validateTuberculosPlatanos() ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        );
                      },
                      validator: (_) => _validateTuberculosPlatanos(),
                      onSaved: (List<LstTuberculo>? value) {
                        dimUbicacionBloc.add(TuberculosPlatanosChanged(value!));
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
              BlocBuilder<LeguminosaByDptoCubit, LeguminosasByDptoState>(
                builder: (context, state) {
                  if (state is LeguminosasByDptoLoaded) {
                    return FormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: _selectedLeguminosasByDpto,
                      builder: (FormFieldState<List<LstLeguminosa>> formstate) {
                        return Column(
                          children: [
                            Wrap(
                                children: List<Widget>.generate(
                                    state.leguminosasByDptoLoaded!.length,
                                    (index) {
                              final e = state.leguminosasByDptoLoaded![index];
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                      value: _selectedLeguminosasByDpto.any(
                                          (element) =>
                                              element.leguminosaId ==
                                              e.leguminosaId),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            _selectedLeguminosasByDpto.add(
                                                LstLeguminosa(
                                                    leguminosaId:
                                                        e.leguminosaId));
                                          } else {
                                            _selectedLeguminosasByDpto
                                                .removeWhere(
                                              (element) =>
                                                  element.leguminosaId ==
                                                  e.leguminosaId,
                                            );
                                          }
                                        });
                                      }),
                                  Flexible(
                                    child: Text(
                                      e.descripcion,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (index <
                                      state.leguminosasByDptoLoaded!.length - 1)
                                    const VerticalDivider(),
                                ],
                              );
                            })),
                            Text(
                              _validateLeguminosas() ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        );
                      },
                      validator: (_) => _validateLeguminosas(),
                      onSaved: (List<LstLeguminosa>? value) {
                        dimUbicacionBloc.add(LeguminosasChanged(value!));
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
              BlocBuilder<HortalizaByDptoCubit, HortalizasByDptoState>(
                builder: (context, state) {
                  if (state is HortalizasByDptoLoaded) {
                    return FormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: _selectedHortalizasByDpto,
                      builder: (FormFieldState<List<LstHortaliza>> formstate) {
                        return Column(
                          children: [
                            Wrap(
                                children: List<Widget>.generate(
                                    state.hortalizasByDptoLoaded!.length,
                                    (index) {
                              final e = state.hortalizasByDptoLoaded![index];
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                      value: _selectedHortalizasByDpto.any(
                                          (element) =>
                                              element.hortalizaId ==
                                              e.hortalizaId),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            _selectedHortalizasByDpto.add(
                                                LstHortaliza(
                                                    hortalizaId:
                                                        e.hortalizaId));
                                          } else {
                                            _selectedHortalizasByDpto
                                                .removeWhere(
                                              (element) =>
                                                  element.hortalizaId ==
                                                  e.hortalizaId,
                                            );
                                          }
                                        });
                                      }),
                                  Flexible(
                                    child: Text(
                                      e.descripcion,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (index <
                                      state.hortalizasByDptoLoaded!.length - 1)
                                    const VerticalDivider(),
                                ],
                              );
                            })),
                            Text(
                              _validateHortalizas() ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        );
                      },
                      validator: (_) => _validateHortalizas(),
                      onSaved: (List<LstHortaliza>? value) {
                        dimUbicacionBloc.add(HortalizasChanged(value!));
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
              BlocBuilder<VerduraByDptoCubit, VerdurasByDptoState>(
                builder: (context, state) {
                  if (state is VerdurasByDptoLoaded) {
                    return FormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: _selectedVerdurasByDpto,
                      builder: (FormFieldState<List<LstVerdura>> formstate) {
                        return Column(
                          children: [
                            Wrap(
                                children: List<Widget>.generate(
                                    state.verdurasByDptoLoaded!.length,
                                    (index) {
                              final e = state.verdurasByDptoLoaded![index];
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                      value: _selectedVerdurasByDpto.any(
                                          (element) =>
                                              element.verduraId == e.verduraId),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            _selectedVerdurasByDpto.add(
                                                LstVerdura(
                                                    verduraId: e.verduraId));
                                          } else {
                                            _selectedVerdurasByDpto.removeWhere(
                                              (element) =>
                                                  element.verduraId ==
                                                  e.verduraId,
                                            );
                                          }
                                        });
                                      }),
                                  Flexible(
                                    child: Text(
                                      e.descripcion,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (index <
                                      state.verdurasByDptoLoaded!.length - 1)
                                    const VerticalDivider(),
                                ],
                              );
                            })),
                            Text(
                              _validateVerduras() ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        );
                      },
                      validator: (_) => _validateVerduras(),
                      onSaved: (List<LstVerdura>? value) {
                        dimUbicacionBloc.add(VerdurasChanged(value!));
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
              BlocBuilder<FrutoByDptoCubit, FrutosByDptoState>(
                builder: (context, state) {
                  if (state is FrutosByDptoLoaded) {
                    return FormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: _selectedFrutosByDpto,
                      builder: (FormFieldState<List<LstFruto>> formstate) {
                        return Column(
                          children: [
                            Wrap(
                                children: List<Widget>.generate(
                                    state.frutosByDptoLoaded!.length, (index) {
                              final e = state.frutosByDptoLoaded![index];
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                      value: _selectedFrutosByDpto.any(
                                          (element) =>
                                              element.frutoId == e.frutoId),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            _selectedFrutosByDpto.add(
                                                LstFruto(frutoId: e.frutoId));
                                          } else {
                                            _selectedFrutosByDpto.removeWhere(
                                              (element) =>
                                                  element.frutoId == e.frutoId,
                                            );
                                          }
                                        });
                                      }),
                                  Flexible(
                                    child: Text(
                                      e.descripcion,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (index <
                                      state.frutosByDptoLoaded!.length - 1)
                                    const VerticalDivider(),
                                ],
                              );
                            })),
                            Text(
                              _validateFrutos() ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        );
                      },
                      validator: (_) => _validateFrutos(),
                      onSaved: (List<LstFruto>? value) {
                        dimUbicacionBloc.add(FrutosChanged(value!));
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
              BlocBuilder<CerealByDptoCubit, CerealesByDptoState>(
                builder: (context, state) {
                  if (state is CerealesByDptoLoaded) {
                    return FormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: _selectedCerealesByDpto,
                      builder: (FormFieldState<List<LstCereal>> formstate) {
                        return Column(
                          children: [
                            Wrap(
                                children: List<Widget>.generate(
                                    state.cerealesByDptoLoaded!.length,
                                    (index) {
                              final e = state.cerealesByDptoLoaded![index];
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                      value: _selectedCerealesByDpto.any(
                                          (element) =>
                                              element.cerealId == e.cerealId),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            _selectedCerealesByDpto.add(
                                                LstCereal(
                                                    cerealId: e.cerealId));
                                          } else {
                                            _selectedCerealesByDpto.removeWhere(
                                              (element) =>
                                                  element.cerealId ==
                                                  e.cerealId,
                                            );
                                          }
                                        });
                                      }),
                                  Flexible(
                                    child: Text(
                                      e.descripcion,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (index <
                                      state.cerealesByDptoLoaded!.length - 1)
                                    const VerticalDivider(),
                                ],
                              );
                            })),
                            Text(
                              _validateCereales() ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        );
                      },
                      validator: (_) => _validateCereales(),
                      onSaved: (List<LstCereal>? value) {
                        dimUbicacionBloc.add(CerealesChanged(value!));
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
        BlocBuilder<EspecieAnimalByDptoCubit, EspeciesAnimalesByDptoState>(
          builder: (context, state) {
            if (state is EspeciesAnimalesByDptoLoaded) {
              return FormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: _selectedEspeciesAnimales,
                builder: (FormFieldState<List<LstAnimalCria>> formstate) {
                  return Column(
                    children: [
                      Wrap(
                          children: List<Widget>.generate(
                              state.especiesAnimalesByDptoLoaded!.length,
                              (index) {
                        final e = state.especiesAnimalesByDptoLoaded![index];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                                value: _selectedEspeciesAnimales.any(
                                    (element) =>
                                        element.especieAnimalCriaId ==
                                        e.especieAnimalCriaId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (e.especieAnimalCriaId == 9) {
                                      _selectedEspeciesAnimales = [
                                        LstAnimalCria(
                                            especieAnimalCriaId:
                                                e.especieAnimalCriaId)
                                      ];
                                    } else if (value!) {
                                      _selectedEspeciesAnimales.removeWhere(
                                          (element) =>
                                              element.especieAnimalCriaId == 9);
                                      _selectedEspeciesAnimales.add(
                                          LstAnimalCria(
                                              especieAnimalCriaId:
                                                  e.especieAnimalCriaId));
                                    } else {
                                      _selectedEspeciesAnimales.removeWhere(
                                        (element) =>
                                            element.especieAnimalCriaId ==
                                            e.especieAnimalCriaId,
                                      );
                                    }
                                  });
                                }),
                            Flexible(
                              child: Text(
                                e.descripcion,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (index <
                                state.especiesAnimalesByDptoLoaded!.length - 1)
                              const VerticalDivider(),
                          ],
                        );
                      })),
                      Text(
                        _validateEspeciesAnimales() ?? '',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  );
                },
                validator: (_) => _validateEspeciesAnimales(),
                onSaved: (List<LstAnimalCria>? value) {
                  dimUbicacionBloc.add(EspeciesAnimalesCriaChanged(value!));
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
