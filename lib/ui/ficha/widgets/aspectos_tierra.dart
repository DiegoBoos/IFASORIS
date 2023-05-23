import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/usecases/opcion_si_no/opcion_si_no_exports.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../cubits/especie_animal_by_dpto/especie_animal_by_dpto_cubit.dart';
import '../../cubits/fruto_by_dpto/fruto_by_dpto_cubit.dart';
import '../../cubits/hortaliza_by_dpto/hortaliza_by_dpto_cubit.dart';
import '../../cubits/leguminosa_by_dpto/leguminosa_by_dpto_cubit.dart';
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
  List<int> _selectedTuberculosPlatanos = [];
  List<int> _selectedEspeciesAnimales = [];
  List<int> _selectedLeguminosasByDpto = [];
  List<int> _selectedHortalizasByDpto = [];
  List<int> _selectedVerdurasByDpto = [];
  List<int> _selectedFrutosByDpto = [];
  List<int> _selectedCerealesByDpto = [];

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
    } else if (_selectedEspeciesAnimales.length > 4) {
      return 'Máximo cuatro opciones.';
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
    } else if (_selectedVerdurasByDpto.length > 5) {
      return 'Máximo cinco opciones.';
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
    } else if (_selectedCerealesByDpto.length > 5) {
      return 'Máximo cinco opciones.';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _poseeChagra = widget.dimUbicacion?.poseeChagra;
      _selectedTuberculosPlatanos =
          widget.dimUbicacion?.tuberculosPlatanosIds ?? [];
      _selectedLeguminosasByDpto = widget.dimUbicacion?.leguminosasIds ?? [];
      _selectedHortalizasByDpto = widget.dimUbicacion?.hortalizasIds ?? [];
      _selectedVerdurasByDpto = widget.dimUbicacion?.verdurasIds ?? [];
      _selectedFrutosByDpto = widget.dimUbicacion?.frutosIds ?? [];
      _selectedCerealesByDpto = widget.dimUbicacion?.cerealesIds ?? [];
      _selectedEspeciesAnimales =
          widget.dimUbicacion?.especiesAnimalesCriaIds ?? [];
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
        _poseeChagra == 1
            ? Column(
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
                          builder: (FormFieldState<List<int>> formstate) {
                            return Column(
                              children: [
                                Wrap(
                                    children: List<Widget>.generate(
                                        state.tuberculosPlatanosByDptoLoaded!
                                            .length, (index) {
                                  final e = state
                                      .tuberculosPlatanosByDptoLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: _selectedTuberculosPlatanos
                                              .contains(e.tuberculoPlatanoId),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value!) {
                                                _selectedTuberculosPlatanos
                                                    .add(e.tuberculoPlatanoId);
                                              } else {
                                                _selectedTuberculosPlatanos
                                                    .remove(
                                                        e.tuberculoPlatanoId);
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
                          onSaved: (List<int>? value) {
                            dimUbicacionBloc
                                .add(TuberculosPlatanosChanged(value!));
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
                          builder: (FormFieldState<List<int>> formstate) {
                            return Column(
                              children: [
                                Wrap(
                                    children: List<Widget>.generate(
                                        state.leguminosasByDptoLoaded!.length,
                                        (index) {
                                  final e =
                                      state.leguminosasByDptoLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: _selectedLeguminosasByDpto
                                              .contains(e.leguminosaId),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value!) {
                                                _selectedLeguminosasByDpto
                                                    .add(e.leguminosaId);
                                              } else {
                                                _selectedLeguminosasByDpto
                                                    .remove(e.leguminosaId);
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
                                          state.leguminosasByDptoLoaded!
                                                  .length -
                                              1)
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
                          onSaved: (List<int>? value) {
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
                          builder: (FormFieldState<List<int>> formstate) {
                            return Column(
                              children: [
                                Wrap(
                                    children: List<Widget>.generate(
                                        state.hortalizasByDptoLoaded!.length,
                                        (index) {
                                  final e =
                                      state.hortalizasByDptoLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: _selectedHortalizasByDpto
                                              .contains(e.hortalizaId),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value!) {
                                                _selectedHortalizasByDpto
                                                    .add(e.hortalizaId);
                                              } else {
                                                _selectedHortalizasByDpto
                                                    .remove(e.hortalizaId);
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
                                          state.hortalizasByDptoLoaded!.length -
                                              1)
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
                          onSaved: (List<int>? value) {
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
                          builder: (FormFieldState<List<int>> formstate) {
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
                                          value: _selectedVerdurasByDpto
                                              .contains(e.verduraId),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value!) {
                                                _selectedVerdurasByDpto
                                                    .add(e.verduraId);
                                              } else {
                                                _selectedVerdurasByDpto
                                                    .remove(e.verduraId);
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
                                          state.verdurasByDptoLoaded!.length -
                                              1)
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
                          onSaved: (List<int>? value) {
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
                          builder: (FormFieldState<List<int>> formstate) {
                            return Column(
                              children: [
                                Wrap(
                                    children: List<Widget>.generate(
                                        state.frutosByDptoLoaded!.length,
                                        (index) {
                                  final e = state.frutosByDptoLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: _selectedFrutosByDpto
                                              .contains(e.frutoId),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value!) {
                                                _selectedFrutosByDpto
                                                    .add(e.frutoId);
                                              } else {
                                                _selectedFrutosByDpto
                                                    .remove(e.frutoId);
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
                          onSaved: (List<int>? value) {
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
                          builder: (FormFieldState<List<int>> formstate) {
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
                                          value: _selectedCerealesByDpto
                                              .contains(e.cerealId),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value!) {
                                                _selectedCerealesByDpto
                                                    .add(e.cerealId);
                                              } else {
                                                _selectedCerealesByDpto
                                                    .remove(e.cerealId);
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
                                          state.cerealesByDptoLoaded!.length -
                                              1)
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
                          onSaved: (List<int>? value) {
                            dimUbicacionBloc.add(CerealesChanged(value!));
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              )
            : Column(
                children: [
                  const Divider(),
                  const Text(
                    'Qué especie de animales cría',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  BlocBuilder<EspecieAnimalByDptoCubit,
                      EspeciesAnimalesByDptoState>(
                    builder: (context, state) {
                      if (state is EspeciesAnimalesByDptoLoaded) {
                        return FormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: _selectedEspeciesAnimales,
                          builder: (FormFieldState<List<int>> formstate) {
                            return Column(
                              children: [
                                Wrap(
                                    children: List<Widget>.generate(
                                        state.especiesAnimalesByDptoLoaded!
                                            .length, (index) {
                                  final e = state
                                      .especiesAnimalesByDptoLoaded![index];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                          value: _selectedEspeciesAnimales
                                              .contains(e.especieAnimalCriaId),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (e.especieAnimalCriaId == 8) {
                                                _selectedEspeciesAnimales = [
                                                  e.especieAnimalCriaId
                                                ];
                                              } else if (value!) {
                                                _selectedEspeciesAnimales
                                                    .remove(8);
                                                _selectedEspeciesAnimales
                                                    .add(e.especieAnimalCriaId);
                                              } else {
                                                _selectedEspeciesAnimales
                                                    .remove(
                                                        e.especieAnimalCriaId);
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
                                          state.especiesAnimalesByDptoLoaded!
                                                  .length -
                                              1)
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
                          onSaved: (List<int>? value) {
                            dimUbicacionBloc
                                .add(EspeciesAnimalesCriaChanged(value!));
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
      ],
    );
  }
}
