import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/blocs/estilo_vida_saludable/estilo_vida_saludable_bloc.dart';

import '../../../domain/entities/estilo_vida_saludable_entity.dart';
import '../../blocs/encuesta/encuesta_bloc.dart';
import '../../utils/custom_snack_bar.dart';
import '../widgets/estilos_vida_saludable_form.dart';
import '../widgets/progress_bar.dart';

class ComponentesGrupoFamiliarPage extends StatefulWidget {
  const ComponentesGrupoFamiliarPage({super.key});

  @override
  State<ComponentesGrupoFamiliarPage> createState() =>
      _ComponentesGrupoFamiliarPageState();
}

class _ComponentesGrupoFamiliarPageState
    extends State<ComponentesGrupoFamiliarPage> {
  int afiliadoPageIndex = 0;
  final afiliadoPageController = PageController(initialPage: 0);
  late List<GlobalKey<FormState>> formKeys;

  @override
  void initState() {
    super.initState();
    final encuestaBloc = BlocProvider.of<EncuestaBloc>(context);

    formKeys = List.generate(
      encuestaBloc.state.afiliados.length,
      (_) => GlobalKey<FormState>(), // Generate unique form keys
    );
  }

  void _submitForm() {
    final currentForm = formKeys[afiliadoPageIndex].currentState;
    if (currentForm != null && currentForm.validate()) {
      currentForm.save();

      final encuestaBloc = BlocProvider.of<EncuestaBloc>(context);
      final afiliados = encuestaBloc.state.afiliados;

      final estiloVidaSaludableBloc =
          BlocProvider.of<EstiloVidaSaludableBloc>(context);

      final currentEstiloVidaSaludable = estiloVidaSaludableBloc.state.copyWith(
          afiliadoId: afiliados[afiliadoPageIndex].afiliadoId,
          familiaId: afiliados[afiliadoPageIndex].familiaId);

      estiloVidaSaludableBloc
          .add(EstiloVidaSaludableSubmitted(currentEstiloVidaSaludable));
    }
  }

  @override
  Widget build(BuildContext context) {
    final encuestaBloc = BlocProvider.of<EncuestaBloc>(context);
    final estiloVidaSaludableBloc =
        BlocProvider.of<EstiloVidaSaludableBloc>(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<EstiloVidaSaludableBloc, EstiloVidaSaludableEntity>(
          listener: (context, state) {
            final formStatus = state.formStatus;
            if (formStatus is EstiloVidaSaludableSubmissionSuccess) {
              CustomSnackBar.showSnackBar(
                  context, 'Datos guardados correctamente', Colors.green);

              /*  estiloVidaSaludableBloc.add(EstiloVidaSaludableInit()); */

              if (afiliadoPageIndex < encuestaBloc.state.afiliados.length - 1) {
                afiliadoPageController.animateToPage(
                  afiliadoPageIndex + 1,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInExpo,
                );
              } else {
                Navigator.pop(context);
              }
            }

            if (formStatus is EstiloVidaSaludableSubmissionFailed) {
              CustomSnackBar.showSnackBar(
                  context, formStatus.message, Colors.red);

              estiloVidaSaludableBloc.add(EstiloVidaSaludableInit());
            }
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Componentes')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const ProgressBar(),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: afiliadoPageController,
                  itemCount: encuestaBloc.state.afiliados.length,
                  onPageChanged: (index) {
                    setState(() {
                      afiliadoPageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final currentAfiliado = encuestaBloc.state.afiliados[index];

                    return Form(
                      key: formKeys[index],
                      child: EstilosVidaSaludableForm(
                        currentAfiliado: currentAfiliado,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
