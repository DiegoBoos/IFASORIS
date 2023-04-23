import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/domain/usecases/afiliado/afiliado_exports.dart';
import 'package:ifasoris/services/shared_preferences_service.dart';

class SearchAfiliados extends SearchDelegate {
  final AfiliadoBloc afiliadoBloc;
  final prefs = SharedPreferencesService();

  SearchAfiliados(this.afiliadoBloc);

  @override
  String get searchFieldLabel => 'Buscar afiliado';

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    // Crea los resultados que vamos a mostrar
    return BlocBuilder<AfiliadoBloc, AfiliadosState>(
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
                    subtitle: Text('${afiliado.nombre1} | ${afiliado.nombre2}'),
                    onTap: () {
                      prefs.set('afiliado', afiliado);
                      close(context, null);
                    },
                  ),
                  const Divider()
                ],
              );
            }).toList());
          }
        }
        return Container();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  @override
  void showResults(BuildContext context) {
    afiliadoBloc.add(QueryChanged(query));
    super.showResults(context);
  }
}
