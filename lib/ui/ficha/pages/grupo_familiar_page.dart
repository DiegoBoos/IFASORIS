import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/search/search_afiliados.dart';
import '../../blocs/afiliado/afiliado_bloc.dart';
import '../../blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';
import '../../utils/custom_snack_bar.dart';
import '../widgets/grupo_familiar_form.dart';

class GrupoFamiliarPage extends StatefulWidget {
  const GrupoFamiliarPage({
    required this.registraAfiliados,
    super.key,
  });

  final int registraAfiliados;

  @override
  State<GrupoFamiliarPage> createState() => _GrupoFamiliarState();
}

class _GrupoFamiliarState extends State<GrupoFamiliarPage> {
  @override
  Widget build(BuildContext context) {
    final afiliadoBloc = BlocProvider.of<AfiliadoBloc>(context);

    return Column(
      children: [
        if (widget.registraAfiliados == 0)
          Column(
            children: [
              MaterialButton(
                  elevation: 0,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () => showSearch(
                      context: context,
                      delegate: SearchAfiliados(
                          afiliadoBloc: afiliadoBloc, isGrupoFamiliar: true)),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: const Text(
                      'Agregar afiliado',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              BlocConsumer<AfiliadosGrupoFamiliarBloc,
                  AfiliadosGrupoFamiliarState>(
                listener: (context, state) {
                  if (state is AfiliadosGrupoFamiliarLoaded) {
                    CustomSnackBar.showSnackBar(
                        context, state.message, Colors.green);
                  }
                },
                builder: (context, state) {
                  if (state is AfiliadosGrupoFamiliarLoaded ||
                      state is GrupoFamiliarSubmissionSuccess) {
                    final afiliadosGrupoFamiliar =
                        state.afiliadosGrupoFamiliar!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: afiliadosGrupoFamiliar.length,
                      itemBuilder: (BuildContext context, int index) {
                        final afiliadoGrupoFamiliar =
                            afiliadosGrupoFamiliar[index];
                        return ListTile(
                            title: Text(
                                '${afiliadoGrupoFamiliar.nombre1 ?? ''} ${afiliadoGrupoFamiliar.nombre2 ?? ''} ${afiliadoGrupoFamiliar.apellido1 ?? ''} ${afiliadoGrupoFamiliar.apellido2 ?? ''}'),
                            onTap: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      GrupoFamiliarForm(
                                          afiliadoGrupoFamiliar:
                                              afiliadoGrupoFamiliar),
                                ),
                              );
                            });
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
      ],
    );
  }
}
