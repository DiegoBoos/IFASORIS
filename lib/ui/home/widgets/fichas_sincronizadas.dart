import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/utils/custom_svg.dart';
import '../../blocs/ficha/ficha_bloc.dart';
import '../pages/pdf_viewer_page.dart';

class FichasSincronizadas extends StatefulWidget {
  const FichasSincronizadas({super.key});
  @override
  State<FichasSincronizadas> createState() => _FichasSincronizadasState();
}

class _FichasSincronizadasState extends State<FichasSincronizadas> {
  @override
  void initState() {
    super.initState();
    final fichaBloc = BlocProvider.of<FichaBloc>(context);
    fichaBloc.add(LoadFichasSincronizadas());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FichaBloc, FichasState>(
      builder: (context, state) {
        if (state is FichasLoaded) {
          final fichasSincronizadas = state.fichasLoaded
              ?.where((element) => element.numFicha != '')
              .toList();
          if (fichasSincronizadas == null || fichasSincronizadas.isEmpty) {
            return const Center(
              child: CustomSvg(title: 'No hay fichas sincronizadas'),
            );
          } else {
            return ListView.builder(
              itemCount: fichasSincronizadas.length,
              itemBuilder: (BuildContext context, int index) {
                final ficha = fichasSincronizadas[index];
                return ListTile(
                  leading: Text("Ficha No. ${ficha.numFicha}"),
                  title: Text(ficha.familia!.apellidosFlia!),
                  trailing: IconButton(
                    icon: const Icon(Icons.picture_as_pdf),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PDFViewerPage(ficha: ficha),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
