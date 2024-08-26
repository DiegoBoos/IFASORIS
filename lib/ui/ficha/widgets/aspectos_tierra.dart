import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/core/constants.dart';

import '../../../data/models/cereal.dart';
import '../../../data/models/especie_animal.dart';
import '../../../data/models/fruto.dart';
import '../../../data/models/hortaliza.dart';
import '../../../data/models/leguminosa.dart';
import '../../../data/models/tuberculo_platano.dart';
import '../../../data/models/verdura.dart';
import '../../../domain/entities/cereal.dart';
import '../../../domain/entities/dim_ubicacion.dart';
import '../../../domain/entities/hortaliza.dart';
import '../../../domain/entities/tuberculo_platano.dart';
import '../../../domain/entities/verdura.dart';
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
import '../../utils/custom_alerts.dart';
import '../../utils/input_decoration.dart';
import '../../utils/validators/form_validators.dart';
import '../helpers/especies_animales_cria_helper.dart';
import '../helpers/frutos_helper.dart';
import '../helpers/leguminosas_helper.dart';

class AspectosTierraForm extends StatefulWidget {
  const AspectosTierraForm({super.key, required this.dimUbicacion});
  final DimUbicacionEntity dimUbicacion;

  @override
  State<AspectosTierraForm> createState() => AspectosTierraFormState();
}

class AspectosTierraFormState extends State<AspectosTierraForm> {
  int? _poseeChagra;
  int? _tipoCalendarioId;
  bool _showOtroCereal = false;
  String? _otroCereal;
  bool _showOtroVerdura = false;
  String? _otroVerdura;
  bool _showOtroTuberculoPlatano = false;
  String? _otroTuberculoPlatano;
  bool _showOtroHortaliza = false;
  String? _otroHortaliza;

  @override
  void initState() {
    super.initState();

    setState(() {
      _poseeChagra = widget.dimUbicacion.poseeChagra;
      _tipoCalendarioId = widget.dimUbicacion.tipoCalendarioId;

      if (widget.dimUbicacion.lstTuberculos != null &&
          widget.dimUbicacion.lstTuberculos!.isNotEmpty &&
          widget.dimUbicacion.lstTuberculos![0].otroTuberculoPlatano != null) {
        _showOtroTuberculoPlatano = true;
      }

      if (widget.dimUbicacion.lstHortalizas != null &&
          widget.dimUbicacion.lstHortalizas!.isNotEmpty &&
          widget.dimUbicacion.lstHortalizas![0].otroHortaliza != null) {
        _showOtroHortaliza = true;
      }

      if (widget.dimUbicacion.lstVerduras != null &&
          widget.dimUbicacion.lstVerduras!.isNotEmpty &&
          widget.dimUbicacion.lstVerduras![0].otroVerdura != null) {
        _showOtroVerdura = true;
      }

      if (widget.dimUbicacion.lstCereales != null &&
          widget.dimUbicacion.lstCereales!.isNotEmpty &&
          widget.dimUbicacion.lstCereales![0].otroCereal != null) {
        _showOtroCereal = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimUbicacionBloc = BlocProvider.of<DimUbicacionBloc>(context);
    final departamentoId =
        supabase.auth.currentUser!.userMetadata!['Departamento_id'];
    String textAspectoSocioeconomico = '';
    switch (departamentoId) {
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
                                      : RadioListTile<int?>(
                                          title: Text(e.descripcion ?? ''),
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
                    int? ningunoId;
                    int? otroId;

                    for (var e in tuberculosPlatanosLoaded) {
                      final optionType =
                          FormValidators.optionType(e.descripcion ?? '');
                      if (optionType == 'N') {
                        ningunoId = e.tuberculoPlatanoId;
                      } else if (optionType == 'O') {
                        otroId = e.tuberculoPlatanoId;
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
                                          (value! &&
                                                  formState.value != null &&
                                                  formState.value!.length >=
                                                      4 &&
                                                  tuberculoPlatano
                                                          .tuberculoPlatanoId !=
                                                      ningunoId &&
                                                  tuberculoPlatano
                                                          .tuberculoPlatanoId !=
                                                      otroId)
                                              ? CustomAlerts.showCustomDialog(
                                                  context,
                                                  'Error',
                                                  'Máximo cuatro opciones',
                                                  () => Navigator.pop(context),
                                                  false)
                                              : setState(() {
                                                  _updateTuberculoPlatano(
                                                      formState,
                                                      tuberculoPlatano,
                                                      ningunoId,
                                                      otroId,
                                                      value,
                                                      dimUbicacionBloc);
                                                });
                                        },
                                      ),
                                      Flexible(
                                        child: Text(
                                          tuberculoPlatano.descripcion ?? '',
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
                            if (_showOtroTuberculoPlatano)
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  initialValue:
                                      dimUbicacionBloc.state.lstTuberculos !=
                                                  null &&
                                              dimUbicacionBloc.state
                                                  .lstTuberculos!.isNotEmpty
                                          ? dimUbicacionBloc
                                              .state
                                              .lstTuberculos![0]
                                              .otroTuberculoPlatano
                                          : '',
                                  decoration:
                                      CustomInputDecoration.inputDecoration(
                                          hintText: 'Otro', labelText: 'Cuál'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo requerido';
                                    }
                                    return null;
                                  },
                                  onChanged: (String? value) {
                                    setState(() {
                                      _otroTuberculoPlatano = value;
                                    });

                                    dimUbicacionBloc
                                        .add(TuberculosPlatanosChanged([
                                      LstTuberculo(
                                          tuberculoPlatanoId: otroId,
                                          otroTuberculoPlatano:
                                              _otroTuberculoPlatano)
                                    ]));
                                  },
                                ),
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
                    int? ningunoId;

                    for (var e in leguminosasLoaded) {
                      final optionType =
                          FormValidators.optionType(e.descripcion ?? '');
                      if (optionType == 'N') {
                        ningunoId = e.leguminosaId;
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
                                              ningunoId,
                                              context,
                                              value,
                                              leguminosa.leguminosaId!,
                                              dimUbicacionBloc);
                                        },
                                      ),
                                      Flexible(
                                        child: Text(
                                          leguminosa.descripcion ?? '',
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
                    int? ningunoId;
                    int? otroId;

                    for (var e in hortalizasLoaded) {
                      final optionType =
                          FormValidators.optionType(e.descripcion ?? '');
                      if (optionType == 'N') {
                        ningunoId = e.hortalizaId;
                      } else if (optionType == 'O') {
                        otroId = e.hortalizaId;
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
                                            (value! &&
                                                    formState.value != null &&
                                                    formState.value!.length >=
                                                        5 &&
                                                    hortaliza.hortalizaId !=
                                                        ningunoId &&
                                                    hortaliza.hortalizaId !=
                                                        otroId)
                                                ? CustomAlerts.showCustomDialog(
                                                    context,
                                                    'Error',
                                                    'Máximo cinco opciones',
                                                    () =>
                                                        Navigator.pop(context),
                                                    false)
                                                : setState(() {
                                                    _updateHortaliza(
                                                        formState,
                                                        hortaliza,
                                                        ningunoId,
                                                        otroId,
                                                        value,
                                                        dimUbicacionBloc);
                                                  });
                                          }),
                                      Flexible(
                                        child: Text(
                                          hortaliza.descripcion ?? '',
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
                            if (_showOtroHortaliza)
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  initialValue:
                                      dimUbicacionBloc.state.lstHortalizas !=
                                                  null &&
                                              dimUbicacionBloc.state
                                                  .lstHortalizas!.isNotEmpty
                                          ? dimUbicacionBloc.state
                                              .lstHortalizas![0].otroHortaliza
                                          : '',
                                  decoration:
                                      CustomInputDecoration.inputDecoration(
                                          hintText: 'Otro', labelText: 'Cuál'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo requerido';
                                    }
                                    return null;
                                  },
                                  onChanged: (String? value) {
                                    setState(() {
                                      _otroHortaliza = value;
                                    });

                                    dimUbicacionBloc.add(HortalizasChanged([
                                      LstHortaliza(
                                          hortalizaId: otroId,
                                          otroHortaliza: _otroHortaliza)
                                    ]));
                                  },
                                ),
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
                    int? ningunoId;
                    int? otroId;

                    for (var e in verdurasLoaded) {
                      final optionType =
                          FormValidators.optionType(e.descripcion ?? '');
                      if (optionType == 'N') {
                        ningunoId = e.verduraId;
                      } else if (optionType == 'O') {
                        otroId = e.verduraId;
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
                                            (value! &&
                                                    formState.value != null &&
                                                    formState.value!.length >=
                                                        3 &&
                                                    verdura.verduraId !=
                                                        ningunoId &&
                                                    verdura.verduraId != otroId)
                                                ? CustomAlerts.showCustomDialog(
                                                    context,
                                                    'Error',
                                                    'Máximo tres opciones',
                                                    () =>
                                                        Navigator.pop(context),
                                                    false)
                                                : setState(() {
                                                    _updateVerdura(
                                                        formState,
                                                        verdura,
                                                        ningunoId,
                                                        otroId,
                                                        value,
                                                        dimUbicacionBloc);
                                                  });
                                          }),
                                      Flexible(
                                        child: Text(
                                          verdura.descripcion ?? '',
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
                            if (_showOtroVerdura)
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  initialValue:
                                      dimUbicacionBloc.state.lstVerduras !=
                                                  null &&
                                              dimUbicacionBloc
                                                  .state.lstVerduras!.isNotEmpty
                                          ? dimUbicacionBloc
                                              .state.lstVerduras![0].otroVerdura
                                          : '',
                                  decoration:
                                      CustomInputDecoration.inputDecoration(
                                          hintText: 'Otro', labelText: 'Cuál'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo requerido';
                                    }
                                    return null;
                                  },
                                  onChanged: (String? value) {
                                    setState(() {
                                      _otroVerdura = value;
                                    });

                                    dimUbicacionBloc.add(VerdurasChanged([
                                      LstVerdura(
                                          verduraId: otroId,
                                          otroVerdura: _otroVerdura)
                                    ]));
                                  },
                                ),
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
                    int? ningunoId;

                    for (var e in frutosLoaded) {
                      final optionType =
                          FormValidators.optionType(e.descripcion ?? '');
                      if (optionType == 'N') {
                        ningunoId = e.frutoId;
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
                                                ningunoId,
                                                context,
                                                value,
                                                fruto.frutoId!,
                                                dimUbicacionBloc);
                                          }),
                                      Flexible(
                                        child: Text(
                                          fruto.descripcion ?? '',
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
                    int? ningunoId;
                    int? otroId;

                    for (var e in cerealesLoaded) {
                      final optionType =
                          FormValidators.optionType(e.descripcion ?? '');
                      if (optionType == 'N') {
                        ningunoId = e.cerealId;
                      } else if (optionType == 'O') {
                        otroId = e.cerealId;
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
                                            var selectedItems =
                                                List<LstCereal>.from(
                                                    formState.value ?? []);
                                            (value! &&
                                                    formState.value != null &&
                                                    formState.value!.length >=
                                                        3 &&
                                                    cereal.cerealId !=
                                                        ningunoId &&
                                                    cereal.cerealId != otroId)
                                                ? CustomAlerts.showCustomDialog(
                                                    context,
                                                    'Error',
                                                    'Máximo tres opciones',
                                                    () =>
                                                        Navigator.pop(context),
                                                    false)
                                                : setState(() {
                                                    _updateCereales(
                                                        cereal,
                                                        ningunoId,
                                                        otroId,
                                                        selectedItems,
                                                        value,
                                                        formState,
                                                        dimUbicacionBloc);
                                                  });
                                          }),
                                      Flexible(
                                        child: Text(
                                          cereal.descripcion ?? '',
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
                            if (_showOtroCereal)
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  initialValue:
                                      dimUbicacionBloc.state.lstCereales !=
                                                  null &&
                                              dimUbicacionBloc
                                                  .state.lstCereales!.isNotEmpty
                                          ? dimUbicacionBloc
                                              .state.lstCereales![0].otroCereal
                                          : '',
                                  decoration:
                                      CustomInputDecoration.inputDecoration(
                                          hintText: 'Otro', labelText: 'Cuál'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo requerido';
                                    }
                                    return null;
                                  },
                                  onChanged: (String? value) {
                                    setState(() {
                                      _otroCereal = value;
                                    });

                                    dimUbicacionBloc.add(CerealesChanged([
                                      LstCereal(
                                          cerealId: otroId,
                                          otroCereal: _otroCereal)
                                    ]));
                                  },
                                ),
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
              int? ningunoId;

              for (var e in especiesAnimalesLoaded) {
                final optionType =
                    FormValidators.optionType(e.descripcion ?? '');
                if (optionType == 'N') {
                  ningunoId = e.especieAnimalCriaId;
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
                                          ningunoId,
                                          context,
                                          value,
                                          especieAnimal.especieAnimalCriaId!,
                                          dimUbicacionBloc);
                                    }),
                                Flexible(
                                  child: Text(
                                    especieAnimal.descripcion ?? '',
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
                        child: Text(tipoCalendario.descripcion ?? ''),
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

  void _updateCereales(
      CerealEntity cereal,
      int? ningunoId,
      int? otroId,
      List<LstCereal> selectedItems,
      bool value,
      FormFieldState<List<LstCereal>> formState,
      DimUbicacionBloc dimUbicacionBloc) {
    if (cereal.cerealId == ningunoId) {
      selectedItems.clear();
      selectedItems.add(LstCereal(cerealId: cereal.cerealId));
      _showOtroCereal = false;
      _otroCereal = null;
    } else if (cereal.cerealId == otroId) {
      selectedItems.clear();
      selectedItems.add(LstCereal(cerealId: cereal.cerealId));
      _showOtroCereal = true;
    } else if (value == true) {
      selectedItems
          .removeWhere((e) => e.cerealId == otroId || e.cerealId == ningunoId);
      selectedItems.add(LstCereal(cerealId: cereal.cerealId));
      _showOtroCereal = false;
      _otroCereal = null;
    } else {
      selectedItems.removeWhere(
        (e) => e.cerealId == cereal.cerealId,
      );
    }
    formState.didChange(selectedItems);

    if (!_showOtroCereal) {
      dimUbicacionBloc.add(CerealesChanged(selectedItems));
    }
  }

  void _updateVerdura(
      FormFieldState<List<LstVerdura>> formState,
      VerduraEntity verdura,
      int? ningunoId,
      int? otroId,
      bool value,
      DimUbicacionBloc dimUbicacionBloc) {
    var selectedItems = List<LstVerdura>.from(formState.value ?? []);

    if (verdura.verduraId == ningunoId) {
      selectedItems.clear();
      selectedItems.add(LstVerdura(verduraId: verdura.verduraId));
      _showOtroVerdura = false;
      _otroVerdura = null;
    } else if (verdura.verduraId == otroId) {
      selectedItems.clear();
      selectedItems.add(LstVerdura(verduraId: verdura.verduraId));
      _showOtroVerdura = true;
    } else if (value == true) {
      selectedItems.removeWhere(
          (e) => e.verduraId == otroId || e.verduraId == ningunoId);
      selectedItems.add(LstVerdura(verduraId: verdura.verduraId));
      _showOtroVerdura = false;
      _otroVerdura = null;
    } else {
      selectedItems.removeWhere(
        (e) => e.verduraId == verdura.verduraId,
      );
    }
    formState.didChange(selectedItems);

    if (!_showOtroVerdura) {
      dimUbicacionBloc.add(VerdurasChanged(selectedItems));
    }
  }

  void _updateHortaliza(
      FormFieldState<List<LstHortaliza>> formState,
      HortalizaEntity hortaliza,
      int? ningunoId,
      int? otroId,
      bool value,
      DimUbicacionBloc dimUbicacionBloc) {
    var selectedItems = List<LstHortaliza>.from(formState.value ?? []);

    if (hortaliza.hortalizaId == ningunoId) {
      selectedItems.clear();
      selectedItems.add(LstHortaliza(hortalizaId: hortaliza.hortalizaId));
      _showOtroHortaliza = false;
      _otroHortaliza = null;
    } else if (hortaliza.hortalizaId == otroId) {
      selectedItems.clear();
      selectedItems.add(LstHortaliza(hortalizaId: hortaliza.hortalizaId));
      _showOtroHortaliza = true;
    } else if (value == true) {
      selectedItems.removeWhere(
          (e) => e.hortalizaId == otroId || e.hortalizaId == ningunoId);
      selectedItems.add(LstHortaliza(hortalizaId: hortaliza.hortalizaId));
      _showOtroHortaliza = false;
      _otroHortaliza = null;
    } else {
      selectedItems.removeWhere(
        (e) => e.hortalizaId == hortaliza.hortalizaId,
      );
    }
    formState.didChange(selectedItems);

    if (!_showOtroHortaliza) {
      dimUbicacionBloc.add(HortalizasChanged(selectedItems));
    }
  }

  void _updateTuberculoPlatano(
      FormFieldState<List<LstTuberculo>> formState,
      TuberculoPlatanoEntity tuberculoPlatano,
      int? ningunoId,
      int? otroId,
      bool value,
      DimUbicacionBloc dimUbicacionBloc) {
    var selectedItems = List<LstTuberculo>.from(formState.value ?? []);

    if (tuberculoPlatano.tuberculoPlatanoId == ningunoId) {
      selectedItems.clear();
      selectedItems.add(LstTuberculo(
          tuberculoPlatanoId: tuberculoPlatano.tuberculoPlatanoId));
      _showOtroTuberculoPlatano = false;
      _otroTuberculoPlatano = null;
    } else if (tuberculoPlatano.tuberculoPlatanoId == otroId) {
      selectedItems.clear();
      selectedItems.add(LstTuberculo(
          tuberculoPlatanoId: tuberculoPlatano.tuberculoPlatanoId));
      _showOtroTuberculoPlatano = true;
    } else if (value == true) {
      selectedItems.removeWhere((e) =>
          e.tuberculoPlatanoId == otroId || e.tuberculoPlatanoId == ningunoId);
      selectedItems.add(LstTuberculo(
          tuberculoPlatanoId: tuberculoPlatano.tuberculoPlatanoId));
      _showOtroTuberculoPlatano = false;
      _otroTuberculoPlatano = null;
    } else {
      selectedItems.removeWhere(
        (e) => e.tuberculoPlatanoId == tuberculoPlatano.tuberculoPlatanoId,
      );
    }
    formState.didChange(selectedItems);

    if (!_showOtroTuberculoPlatano) {
      dimUbicacionBloc.add(TuberculosPlatanosChanged(selectedItems));
    }
  }
}
