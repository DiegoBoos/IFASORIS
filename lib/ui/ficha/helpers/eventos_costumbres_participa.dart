import 'package:flutter/material.dart';

import '../../../data/models/evento_costumbre_participa_model.dart';
import '../../blocs/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_bloc.dart';

void handleEventoCostumbreParticipaSelection(
    FormFieldState<List<LstEventoCostumbreParticipa>> formState,
    int? ningunaId,
    BuildContext context,
    bool? value,
    int eventoCostumbreParticipaId,
    DimensionSocioCulturalPueblosIndigenasBloc
        dimensionSocioCulturalPueblosIndigenasBloc) {
  var selectedItems =
      List<LstEventoCostumbreParticipa>.from(formState.value ?? []);

  if (ningunaId != null) {
    _handleNingunaIdSelection(
        context, value!, selectedItems, eventoCostumbreParticipaId, ningunaId);
  } else {
    _handleRegularSelection(
        context, value!, selectedItems, eventoCostumbreParticipaId);
  }

  formState.didChange(selectedItems);
  dimensionSocioCulturalPueblosIndigenasBloc
      .add(EventosCostumbresParticipaChanged(selectedItems));
}

void _handleNingunaIdSelection(
    BuildContext context,
    bool value,
    List<LstEventoCostumbreParticipa> selectedItems,
    int eventoCostumbreParticipaId,
    int ningunaId) {
  _updateSelectedItemsWithNingunaId(
      value, selectedItems, eventoCostumbreParticipaId, ningunaId);
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    List<LstEventoCostumbreParticipa> selectedItems,
    int eventoCostumbreParticipaId) {
  _updateSelectedItemsRegular(value, selectedItems, eventoCostumbreParticipaId);
}

void _updateSelectedItemsWithNingunaId(
    bool value,
    List<LstEventoCostumbreParticipa> selectedItems,
    int eventoCostumbreParticipaId,
    int ningunaId) {
  if (eventoCostumbreParticipaId == ningunaId) {
    selectedItems.clear();
    selectedItems.add(
        LstEventoCostumbreParticipa(eventoCostumbreParticipaId: ningunaId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.eventoCostumbreParticipaId == ningunaId);
    selectedItems.add(LstEventoCostumbreParticipa(
        eventoCostumbreParticipaId: eventoCostumbreParticipaId));
  } else {
    selectedItems.removeWhere(
        (e) => e.eventoCostumbreParticipaId == eventoCostumbreParticipaId);
  }
}

void _updateSelectedItemsRegular(
    bool value,
    List<LstEventoCostumbreParticipa> selectedItems,
    int eventoCostumbreParticipaId) {
  if (value) {
    selectedItems.add(LstEventoCostumbreParticipa(
        eventoCostumbreParticipaId: eventoCostumbreParticipaId));
  } else {
    selectedItems.removeWhere(
        (e) => e.eventoCostumbreParticipaId == eventoCostumbreParticipaId);
  }
}
