import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../blocs/afiliado/afiliado_bloc.dart';
import '../../blocs/afiliado_prefs/afiliado_prefs_bloc.dart';
import '../../blocs/afiliados_grupo_familiar/afiliados_grupo_familiar_bloc.dart';
import '../../search/search_afiliados.dart';
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
  void initState() {
    super.initState();

    final afiliadoPrefsBloc = BlocProvider.of<AfiliadoPrefsBloc>(
      context,
    );

    final afiliado = afiliadoPrefsBloc.state.afiliado!;
    BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context)
        .add(GetAfiliadosGrupoFamiliar(afiliado.familiaId!));
  }

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
              BlocBuilder<AfiliadosGrupoFamiliarBloc,
                  AfiliadosGrupoFamiliarState>(builder: (context, state) {
                if (state is AfiliadosGrupoFamiliarLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AfiliadosGrupoFamiliarLoaded) {
                  final afiliadosGrupoFamiliarLoaded =
                      state.afiliadosGrupoFamiliarLoaded!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: afiliadosGrupoFamiliarLoaded.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildDismissibleListTile(
                          context, afiliadosGrupoFamiliarLoaded, index);
                    },
                  );
                }
                return const Center(child: Text('No hay afiliados'));
              })
            ],
          ),
      ],
    );
  }

  Widget buildDismissibleListTile(BuildContext context,
      List<GrupoFamiliarEntity> afiliadosGrupoFamiliar, int index) {
    final afiliadoGrupoFamiliar = afiliadosGrupoFamiliar[index];

    final nombreCompleto =
        '${afiliadoGrupoFamiliar.nombre1 ?? ''} ${afiliadoGrupoFamiliar.nombre2 ?? ''} ${afiliadoGrupoFamiliar.apellido1 ?? ''} ${afiliadoGrupoFamiliar.apellido2 ?? ''}';

    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(afiliadoGrupoFamiliar.afiliadoId.toString()),
      confirmDismiss: (DismissDirection direction) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Advertencia"),
              content: Text(
                  "¿Está seguro que desea eliminar el afiliado $nombreCompleto?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () async {
                    final afiliadoGrupoFamiliarBloc =
                        BlocProvider.of<AfiliadosGrupoFamiliarBloc>(context);

                    await afiliadoGrupoFamiliarBloc
                        .deleteAfiliadoGrupoFamiliar(
                            afiliadoGrupoFamiliar.afiliadoId!,
                            afiliadoGrupoFamiliar.familiaId!)
                        .then((value) {
                      if (value != 0) {
                        setState(() {
                          afiliadosGrupoFamiliar.removeAt(index);
                        });

                        Navigator.of(context).pop();

                        CustomSnackBar.showSnackBar(context,
                            'Afiliado eliminado correctamente', Colors.red);
                      }
                    });
                  },
                  child: const Text("Eliminar"),
                ),
              ],
            );
          },
        );
      },
      background: Container(
        color: Colors.red, // Background color when swiping
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
          title: Text(nombreCompleto),
          onTap: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => GrupoFamiliarForm(
                  afiliadoGrupoFamiliar: afiliadoGrupoFamiliar,
                ),
              ),
            );
          }),
    );
  }
}
