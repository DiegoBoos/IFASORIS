import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/entities/dim_vivienda_entity.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/dim_ubicacion/dim_ubicacion_bloc.dart';
import '../../blocs/dim_vivienda/dim_vivienda_bloc.dart';
import '../../cubits/slider/slider_cubit.dart';
import '../../utils/custom_snack_bar.dart';
import '../widgets/slide_show.dart';
import 'dim_ubicacion_page.dart';
import 'dim_vivienda_page.dart';
import 'grupo_familiar_page.dart';

class FichaPage extends StatefulWidget {
  const FichaPage({super.key});

  @override
  State<FichaPage> createState() => _FichaPageState();
}

class _FichaPageState extends State<FichaPage> {
  final _formKeyUbicacion = GlobalKey<FormState>();
  final _formKeyVivienda = GlobalKey<FormState>();

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
          title: const Text('Ficha'),
        ),
        body: Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(primary: Colors.green)),
            child: MultiBlocListener(
                listeners: [
                  BlocListener<DimUbicacionBloc, DimUbicacionEntity>(
                    listener: (context, state) {
                      final formStatus = state.formStatus;
                      if (formStatus is DimUbicacionSubmissionSuccess) {
                        sliderCubit.updateCurrentPage(1);
                      }
                      if (formStatus is DimUbicacionSubmissionFailed) {
                        CustomSnackBar.showSnackBar(
                            context, formStatus.message, Colors.red);
                        Navigator.popUntil(
                            context, ModalRoute.withName('home'));
                      }
                    },
                  ),
                  BlocListener<DimViviendaBloc, DimViviendaEntity>(
                    listener: (context, state) {
                      final formStatus = state.formStatus;
                      if (formStatus is DimViviendaSubmissionSuccess) {
                        sliderCubit.updateCurrentPage(2);
                      }
                      if (formStatus is DimViviendaSubmissionFailed) {
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
                      submitUbicacionForm();
                    }
                    if (page == 1) {
                      submitViviendaForm();
                    }
                  },
                  slides: [
                    DimUbicacionPage(_formKeyUbicacion),
                    DimViviendaPage(_formKeyVivienda),
                    const GrupoFamiliarPage()
                  ],
                ))));
  }

  void submitUbicacionForm() {
    final formState = _formKeyUbicacion.currentState;
    if (formState != null && formState.validate()) {
      formState.save();

      final dimUbicacionBloc = BlocProvider.of<DimUbicacionBloc>(context);
      final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);
      final afiliado = afiliadoPrefsBloc.state.afiliado!;

      dimUbicacionBloc.add(DimUbicacionAfiliadoChanged(afiliado.afiliadoId!));
      dimUbicacionBloc.add(DimUbicacionFamiliaChanged(afiliado.familiaId!));
      dimUbicacionBloc.add(DimUbicacionSubmitted());
    }
  }

  void submitViviendaForm() {
    final formState = _formKeyVivienda.currentState;
    if (formState != null && formState.validate()) {
      formState.save();

      final dimViviendaBloc = BlocProvider.of<DimViviendaBloc>(context);
      final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(context);
      final afiliado = afiliadoPrefsBloc.state.afiliado!;

      dimViviendaBloc.add(DimViviendaAfiliadoChanged(afiliado.afiliadoId!));
      dimViviendaBloc.add(DimViviendaFamiliaChanged(afiliado.familiaId!));
      dimViviendaBloc.add(DimViviendaSubmitted());
    }
  }
}
