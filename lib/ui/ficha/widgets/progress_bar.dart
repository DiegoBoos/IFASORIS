import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/encuesta/encuesta_bloc.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final encuestaBloc = BlocProvider.of<EncuestaBloc>(context);

    return BlocConsumer<EncuestaBloc, EncuestaState>(
      listener: (context, state) {
        BlocListener<EncuestaBloc, EncuestaState>(listener: (context, state) {
          final afiliadosCompleted = state.afiliados
              .where((element) => element.isCompleted == true)
              .length;

          final newPercentage =
              (afiliadosCompleted / state.afiliados.length) * 100;

          encuestaBloc.add(UpdatePercentage(newPercentage));
        });
      },
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 35,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 3),
              borderRadius: BorderRadius.circular(50)),
          child: Stack(
            children: [
              LayoutBuilder(
                  builder: (context, constraints) => Container(
                      width: constraints.maxWidth * (state.newPercentage / 100),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.greenAccent,
                              Colors.green,
                            ],
                          )))),
              Positioned.fill(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Progreso',
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(Icons.percent)
                  ],
                ),
              )),
            ],
          ),
        );
      },
    );
  }
}
