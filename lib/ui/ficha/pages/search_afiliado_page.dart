import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/blocs/grupo_familiar/grupo_familiar_bloc.dart';
import 'package:ifasoris/ui/utils/input_decoration.dart';

import '../../blocs/afiliado/afiliado_bloc.dart';
import 'grupo_familiar_page.dart';

class SearchAfiliadoPage extends StatefulWidget {
  const SearchAfiliadoPage({super.key});

  @override
  State<SearchAfiliadoPage> createState() => _SearchAfiliadoPageState();
}

class _SearchAfiliadoPageState extends State<SearchAfiliadoPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final afiliadoBloc = BlocProvider.of<AfiliadoBloc>(context);
    final grupoFamiliarBloc = BlocProvider.of<GrupoFamiliarBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Seleccionar afiliado'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                        onChanged: (value) => setState(() => query = value),
                        decoration: CustomInputDecoration.inputDecoration(
                            hintText: 'Digite el documento',
                            labelText: 'Buscar afiliado')),
                  ),
                  Expanded(
                      child: IconButton(
                          onPressed: () {
                            afiliadoBloc.add(QueryChanged(query));
                          },
                          icon: const Icon(Icons.search)))
                ],
              ),
              const SizedBox(height: 20),
              BlocBuilder<AfiliadoBloc, AfiliadosState>(
                builder: (context, state) {
                  if (state is AfiliadosLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is AfiliadosError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is AfiliadosLoaded) {
                    if (state.afiliadosLoaded!.isEmpty) {
                      return const Center(child: Text('No hay resultados'));
                    } else {
                      return ListView(
                          children: state.afiliadosLoaded!.map((afiliado) {
                        return Column(
                          children: [
                            ListTile(
                                title: Text(afiliado.documento),
                                subtitle: Text(
                                    '${afiliado.nombre1} | ${afiliado.nombre2}'),
                                onTap: () {
                                  final newGrupoFamiliar =
                                      GrupoFamiliarEntity(afiliado.afiliadoId);

                                  grupoFamiliarBloc
                                      .add(SaveGrupoFamiliar(newGrupoFamiliar));
                                }),
                            const Divider()
                          ],
                        );
                      }).toList());
                    }
                  }
                  return Container();
                },
              )
            ],
          ),
        ));
  }
}
