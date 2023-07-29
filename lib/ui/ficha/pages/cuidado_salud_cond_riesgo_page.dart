import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/cuidado_salud_cond_riesgo_entity.dart';
import '../../blocs/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_bloc.dart';
import '../../blocs/encuesta/encuesta_bloc.dart';
import '../../utils/custom_snack_bar.dart';
import '../widgets/cuidado_salud_cond_riesgo_form.dart';
import '../widgets/progress_bar.dart';

class CuidadoSaludCondRiesgoPage extends StatefulWidget {
  const CuidadoSaludCondRiesgoPage({super.key});

  @override
  State<CuidadoSaludCondRiesgoPage> createState() =>
      _CuidadoSaludCondRiesgoPageState();
}

class _CuidadoSaludCondRiesgoPageState
    extends State<CuidadoSaludCondRiesgoPage> {
  int afiliadoPageIndex = 0;
  final afiliadoPageController = PageController(initialPage: 0);
  late List<GlobalKey<FormState>> formKeys;

  @override
  void initState() {
    super.initState();
    final encuestaBloc = BlocProvider.of<EncuestaBloc>(context);

    formKeys = List.generate(
      encuestaBloc.state.afiliados.length,
      (_) => GlobalKey<FormState>(),
    );
  }

  void _submitForm() {
    final currentForm = formKeys[afiliadoPageIndex].currentState;
    if (currentForm != null && currentForm.validate()) {
      currentForm.save();

      final encuestaBloc = BlocProvider.of<EncuestaBloc>(context);
      final afiliados = encuestaBloc.state.afiliados;

      final cuidadoSaludCondRiesgoBloc =
          BlocProvider.of<CuidadoSaludCondRiesgoBloc>(context);

      final currentCuidadoSaludCondRiesgo = cuidadoSaludCondRiesgoBloc.state
          .copyWith(
              afiliadoId: afiliados[afiliadoPageIndex].afiliadoId,
              familiaId: afiliados[afiliadoPageIndex].familiaId);

      cuidadoSaludCondRiesgoBloc
          .add(CuidadoSaludCondRiesgoSubmitted(currentCuidadoSaludCondRiesgo));
    }
  }

  @override
  Widget build(BuildContext context) {
    final encuestaBloc = BlocProvider.of<EncuestaBloc>(context);
    final cuidadoSaludCondRiesgoBloc =
        BlocProvider.of<CuidadoSaludCondRiesgoBloc>(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<CuidadoSaludCondRiesgoBloc, CuidadoSaludCondRiesgoEntity>(
          listener: (context, state) {
            final formStatus = state.formStatus;
            if (formStatus is CuidadoSaludCondRiesgoSubmissionSuccess) {
              CustomSnackBar.showSnackBar(
                  context,
                  'Datos de cuidado salud condiciones riesgo guardados correctamente',
                  Colors.green);

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

            if (formStatus is CuidadoSaludCondRiesgoSubmissionFailed) {
              CustomSnackBar.showSnackBar(
                  context, formStatus.message, Colors.red);

              cuidadoSaludCondRiesgoBloc.add(CuidadoSaludCondRiesgoInit());
            }
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Estilos de vida saludable')),
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
                      child: CuidadoSaludCondRiesgoForm(
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
