import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/dim_ubicacion.dart';
import '../../../domain/entities/dim_vivienda.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';
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
  final _pageController = PageController();
  final _formKeyUbicacion = GlobalKey<FormState>();
  final _formKeyVivienda = GlobalKey<FormState>();

  @override
  void initState() {
    loadForms();
    super.initState();
  }

  void loadForms() {
    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );
    final dimUbicacionBloc = BlocProvider.of<DimUbicacionBloc>(context);
    final dimViviendaBloc = BlocProvider.of<DimViviendaBloc>(context);
    final afiliadoGrupoFamiliarBloc =
        BlocProvider.of<AfiliadosGrupoFamiliarBloc>(
      context,
    );

    final afiliado = afiliadoPrefsBloc.state.afiliado!;
    final dimUbicacionFormStatus = dimUbicacionBloc.state.formStatus;
    final dimViviendaFormStatus = dimViviendaBloc.state.formStatus;

    // Si las dos dimensiones ya se cargaron, se verifica si el afiliados es cabeza de familia
    if ((dimUbicacionFormStatus is DimUbicacionFormLoaded ||
            dimViviendaFormStatus is DimUbicacionFormSubmissionSuccess) &&
        (dimViviendaFormStatus is DimViviendaFormLoaded ||
            dimViviendaFormStatus is DimViviendaSubmissionSuccess)) {
      afiliadoGrupoFamiliarBloc
          .add(ExisteAfiliadoCabezaFamilia(afiliado.familiaId!));
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Ficha'),
            leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => CustomSnackBar.exitDialog(context)),
          ),
          body: BlocProvider(
            create: (context) => SliderCubit(),
            child: Builder(builder: (context) {
              final sliderCubit =
                  BlocProvider.of<SliderCubit>(context, listen: true);
              final currentPage = sliderCubit.state.sliderModel.currentPage;

              return MultiBlocListener(
                  listeners: [
                    BlocListener<DimUbicacionBloc, DimUbicacionEntity>(
                      listener: (context, state) {
                        final formStatus = state.formStatus;

                        if (formStatus is DimUbicacionSubmissionSuccess) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );

                          sliderCubit.updateCurrentPage(currentPage + 1);
                        }
                        if (formStatus is DimUbicacionSubmissionFailed) {
                          CustomSnackBar.showSnackBar(
                              context, formStatus.message, Colors.red);
                          Navigator.popUntil(
                              context, ModalRoute.withName('splash'));
                        }
                      },
                    ),
                    BlocListener<DimViviendaBloc, DimViviendaEntity>(
                      listener: (context, state) {
                        final formStatus = state.formStatus;

                        if (formStatus is DimViviendaSubmissionSuccess) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );

                          sliderCubit.updateCurrentPage(currentPage + 1);
                        }
                        if (formStatus is DimViviendaSubmissionFailed) {
                          CustomSnackBar.showSnackBar(
                              context, formStatus.message, Colors.red);
                        }
                      },
                    ),
                    BlocListener<AfiliadosGrupoFamiliarBloc,
                            AfiliadosGrupoFamiliarState>(
                        listener: (context, state) {
                      // Si el afiliado es cabeza de familia, se pasa a la tercera página
                      if (state is AfiliadoCabezaFamiliaLoaded) {
                        _pageController.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                        sliderCubit.updateCurrentPage(2);
                      }
                    }),
                  ],
                  child: Column(
                    children: [
                      Expanded(
                        child: Slideshow(
                          pageController: _pageController,
                          slides: [
                            DimUbicacionPage(
                              _formKeyUbicacion,
                            ),
                            DimViviendaPage(
                              _formKeyVivienda,
                            ),
                            const GrupoFamiliarPage()
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (currentPage > 0)
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _pageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeInOut,
                                    );

                                    sliderCubit
                                        .updateCurrentPage(currentPage - 1);
                                  },
                                  child: const Text('Anterior'),
                                ),
                              ),
                            if (currentPage > 0 && currentPage < 2)
                              const SizedBox(width: 20),
                            if (currentPage < 2)
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (currentPage == 0) {
                                      submitUbicacionForm();
                                    }

                                    if (currentPage == 1) {
                                      submitViviendaForm();
                                    }
                                  },
                                  child: const Text('Siguiente'),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ));
            }),
          )),
    );
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
