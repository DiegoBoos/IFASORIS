import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/dimension_sociocultural_pueblos_indigenas_entity.dart';
import '../../blocs/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_bloc.dart';
import '../../blocs/encuesta/encuesta_bloc.dart';
import '../../utils/custom_snack_bar.dart';
import '../widgets/dimension_sociocultural_pueblos_indigenas_form.dart';
import '../widgets/progress_bar.dart';

class DimensionSocioculturalPueblosIndigenasPage extends StatefulWidget {
  const DimensionSocioculturalPueblosIndigenasPage({super.key});

  @override
  State<DimensionSocioculturalPueblosIndigenasPage> createState() =>
      _DimensionSocioculturalPueblosIndigenasPageState();
}

class _DimensionSocioculturalPueblosIndigenasPageState
    extends State<DimensionSocioculturalPueblosIndigenasPage> {
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

      final dimensionSocioculturalPueblosIndigenasBloc =
          BlocProvider.of<DimensionSocioculturalPueblosIndigenasBloc>(context);

      final currentDimensionSocioculturalPueblosIndigenas =
          dimensionSocioculturalPueblosIndigenasBloc.state.copyWith(
              afiliadoId: afiliados[afiliadoPageIndex].afiliadoId,
              familiaId: afiliados[afiliadoPageIndex].familiaId);

      dimensionSocioculturalPueblosIndigenasBloc.add(
          DimensionSocioculturalPueblosIndigenasSubmitted(
              currentDimensionSocioculturalPueblosIndigenas));
    }
  }

  @override
  Widget build(BuildContext context) {
    final encuestaBloc = BlocProvider.of<EncuestaBloc>(context);
    final dimensionSocioculturalPueblosIndigenasBloc =
        BlocProvider.of<DimensionSocioculturalPueblosIndigenasBloc>(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<DimensionSocioculturalPueblosIndigenasBloc,
            DimensionSocioculturalPueblosIndigenasEntity>(
          listener: (context, state) {
            final formStatus = state.formStatus;
            if (formStatus
                is DimensionSocioculturalPueblosIndigenasSubmissionSuccess) {
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

            if (formStatus
                is DimensionSocioculturalPueblosIndigenasSubmissionFailed) {
              CustomSnackBar.showSnackBar(
                  context, formStatus.message, Colors.red);

              dimensionSocioculturalPueblosIndigenasBloc
                  .add(DimensionSocioculturalPueblosIndigenasInit());
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
                      child: DimensionSocioculturalPueblosIndigenasForm(
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
