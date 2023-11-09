import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/atencion_salud_entity.dart';
import '../../../domain/entities/cuidado_salud_cond_riesgo_entity.dart';
import '../../../domain/entities/dimension_sociocultural_pueblos_indigenas_entity.dart';
import '../../../domain/entities/estilo_vida_saludable_entity.dart';
import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../cubits/slider/slider_cubit.dart';
import '../../utils/custom_snack_bar.dart';
import '../widgets/slide_show.dart';
import '../../blocs/grupo_familiar/grupo_familiar_bloc.dart';
import '../../blocs/estilo_vida_saludable/estilo_vida_saludable_bloc.dart'
    as evs;
import '../../blocs/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_bloc.dart'
    as cscr;
import '../../blocs/atencion_salud/atencion_salud_bloc.dart' as ats;
import '../../blocs/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_bloc.dart'
    as dspi;
import 'atencion_salud_page.dart';
import 'cuidado_salud_cond_riesgo_page.dart';
import 'dimension_sociocultural_pueblos_indigenas_page.dart';
import 'estilos_vida_saludable_page.dart';

class ComponentesAfiliado extends StatefulWidget {
  const ComponentesAfiliado({
    required this.afiliado,
    super.key,
  });

  final GrupoFamiliarEntity afiliado;

  @override
  State<ComponentesAfiliado> createState() => _ComponentesAfiliadoState();
}

class _ComponentesAfiliadoState extends State<ComponentesAfiliado> {
  final formKeyEstilosVidaSaludable = GlobalKey<FormState>();
  final formKeyCuidadoSaludCondRiesgo = GlobalKey<FormState>();
  final formKeyDimSocioCulturalPueblosIndigenas = GlobalKey<FormState>();
  final formKeyAtencionSalud = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final sliderCubit = BlocProvider.of<SliderCubit>(context);
    sliderCubit.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sliderCubit = BlocProvider.of<SliderCubit>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Componentes Afiliado'),
        ),
        body: MultiBlocListener(
            listeners: [
              BlocListener<evs.EstiloVidaSaludableBloc,
                  EstiloVidaSaludableEntity>(
                listener: (context, state) {
                  final formStatus = state.formStatus;
                  if (formStatus is evs.EstiloVidaSaludableSubmissionSuccess) {
                    sliderCubit.updateCurrentPage(1);
                  }

                  if (formStatus is evs.EstiloVidaSaludableSubmissionFailed) {
                    CustomSnackBar.showSnackBar(
                        context, formStatus.message, Colors.red);
                  }
                },
              ),
              BlocListener<cscr.CuidadoSaludCondRiesgoBloc,
                  CuidadoSaludCondRiesgoEntity>(
                listener: (context, state) {
                  final formStatus = state.formStatus;
                  if (formStatus
                      is cscr.CuidadoSaludCondRiesgoSubmissionSuccess) {
                    sliderCubit.updateCurrentPage(2);
                  }

                  if (formStatus
                      is cscr.CuidadoSaludCondRiesgoSubmissionFailed) {
                    CustomSnackBar.showSnackBar(
                        context, formStatus.message, Colors.red);
                  }
                },
              ),
              BlocListener<dspi.DimensionSocioCulturalPueblosIndigenasBloc,
                  DimensionSocioCulturalPueblosIndigenasEntity>(
                listener: (context, state) {
                  final formStatus = state.formStatus;
                  if (formStatus is dspi
                      .DimensionSocioCulturalPueblosIndigenasSubmissionSuccess) {
                    sliderCubit.updateCurrentPage(3);
                  }

                  if (formStatus is dspi
                      .DimensionSocioCulturalPueblosIndigenasSubmissionFailed) {
                    CustomSnackBar.showSnackBar(
                        context, formStatus.message, Colors.red);
                  }
                },
              ),
              BlocListener<ats.AtencionSaludBloc, AtencionSaludEntity>(
                listener: (context, state) {
                  final formStatus = state.formStatus;
                  if (formStatus is ats.AtencionSaludSubmissionSuccess) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return buildCompleted();
                        });
                  }

                  if (formStatus is ats.AtencionSaludSubmissionFailed) {
                    CustomSnackBar.showSnackBar(
                        context, formStatus.message, Colors.red);
                  }
                },
              ),
            ],
            child: Slideshow(
              puntosArriba: true,
              onSlideChanged: () {
                final page = sliderCubit.state.sliderModel.currentPage;
                if (page == 0) {
                  _submitEstilosVidaSaludableForm();
                }
                if (page == 1) {
                  _submitCuidadoSaludCondRiesgoForm();
                }
                if (page == 2) {
                  _submitDimSocioCulturalPueblosIndigenasForm();
                }
                if (page == 3) {
                  _submitAtencionSaludForm();
                }
              },
              slides: [
                EstilosVidaSaludablePage(
                  formKey: formKeyEstilosVidaSaludable,
                  afiliado: widget.afiliado,
                ),
                CuidadoSaludCondRiesgoPage(
                  formKey: formKeyCuidadoSaludCondRiesgo,
                  afiliado: widget.afiliado,
                ),
                DimensionSocioCulturalPueblosIndigenasPage(
                  formKey: formKeyDimSocioCulturalPueblosIndigenas,
                  afiliado: widget.afiliado,
                ),
                AtencionSaludPage(
                  formKey: formKeyAtencionSalud,
                  afiliado: widget.afiliado,
                ),
              ],
            )));
  }

  void _submitEstilosVidaSaludableForm() {
    final formState = formKeyEstilosVidaSaludable.currentState;
    if (formState != null && formState.validate()) {
      formState.save();

      final estiloVidaSaludableBloc =
          BlocProvider.of<evs.EstiloVidaSaludableBloc>(context);

      estiloVidaSaludableBloc
          .add(evs.AfiliadoChanged(widget.afiliado.afiliadoId!));
      estiloVidaSaludableBloc
          .add(evs.FamiliaChanged(widget.afiliado.familiaId!));
      estiloVidaSaludableBloc.add(evs.EstiloVidaSaludableSubmitted());
    }
  }

  void _submitCuidadoSaludCondRiesgoForm() {
    final formState = formKeyCuidadoSaludCondRiesgo.currentState;
    if (formState != null && formState.validate()) {
      formState.save();

      final cuidadoSaludCondRiesgoBloc =
          BlocProvider.of<cscr.CuidadoSaludCondRiesgoBloc>(context);

      cuidadoSaludCondRiesgoBloc
          .add(cscr.AfiliadoChanged(widget.afiliado.afiliadoId!));

      cuidadoSaludCondRiesgoBloc
          .add(cscr.FamiliaChanged(widget.afiliado.familiaId!));

      cuidadoSaludCondRiesgoBloc.add(cscr.CuidadoSaludCondRiesgoSubmitted());
    }
  }

  void _submitDimSocioCulturalPueblosIndigenasForm() {
    final formState = formKeyDimSocioCulturalPueblosIndigenas.currentState;
    if (formState != null && formState.validate()) {
      formState.save();

      final dimensionSocioCulturalPueblosIndigenasBloc =
          BlocProvider.of<dspi.DimensionSocioCulturalPueblosIndigenasBloc>(
              context);

      dimensionSocioCulturalPueblosIndigenasBloc
          .add(dspi.AfiliadoChanged(widget.afiliado.afiliadoId!));
      dimensionSocioCulturalPueblosIndigenasBloc
          .add(dspi.FamiliaChanged(widget.afiliado.familiaId!));
      dimensionSocioCulturalPueblosIndigenasBloc
          .add(dspi.DimensionSocioCulturalPueblosIndigenasSubmitted());
    }
  }

  void _submitAtencionSaludForm() {
    final formState = formKeyAtencionSalud.currentState;
    if (formState != null && formState.validate()) {
      formState.save();

      final atencionSaludBloc = BlocProvider.of<ats.AtencionSaludBloc>(context);

      atencionSaludBloc.add(ats.AfiliadoChanged(widget.afiliado.afiliadoId!));
      atencionSaludBloc.add(ats.FamiliaChanged(widget.afiliado.familiaId!));
      atencionSaludBloc.add(ats.AtencionSaludSubmitted());
    }
  }

  Widget buildCompleted() {
    return AlertDialog(
      title: const Text('Ficha guardada'),
      content: const Text('Registro completado.'),
      actions: [
        TextButton(
          onPressed: () async {
            final grupoFamiliarBloc =
                BlocProvider.of<GrupoFamiliarBloc>(context);

            await grupoFamiliarBloc
                .completeGrupoFamiliar(widget.afiliado.afiliadoId!)
                .then((value) {
              Navigator.pushReplacementNamed(context, 'home');
            });
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
