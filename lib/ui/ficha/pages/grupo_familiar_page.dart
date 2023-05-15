import 'package:flutter/material.dart';

class GrupoFamiliarEntity {
  final int afiliadoId;
  bool isCompleted;

  GrupoFamiliarEntity(this.afiliadoId, {this.isCompleted = false});
}

//TODO: whenever a grupofamiliar is saved, the isCompleted flag should be equal to true
//to update the ui check in the third step
class GrupoFamiliarPage extends StatelessWidget {
  const GrupoFamiliarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grupo familiar'),
      ),
      body: Container(),
    );
  }
}
