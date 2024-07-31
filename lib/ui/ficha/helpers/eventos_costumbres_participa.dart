import 'package:flutter/material.dart';

import '../../../data/models/evento_costumbre_participa.dart';
import '../../blocs/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_bloc.dart';

void handleEventoCostumbreParticipaSelection(
    FormFieldState<List<LstEventoCostumbreParticipa>> formState,
    int? ningunoId,
    BuildContext context,
    bool? value,
    int eventoCostumbreParticipaId,
    DimensionSocioCulturalPueblosIndigenasBloc
        dimensionSocioCulturalPueblosIndigenasBloc) {
  var selectedItems =
      List<LstEventoCostumbreParticipa>.from(formState.value ?? []);

  if (ningunoId != null) {
    _handleNingunoIdSelection(
        context, value!, selectedItems, eventoCostumbreParticipaId, ningunoId);
  } else {
    _handleRegularSelection(
        context, value!, selectedItems, eventoCostumbreParticipaId);
  }

  formState.didChange(selectedItems);
  dimensionSocioCulturalPueblosIndigenasBloc
      .add(EventosCostumbresParticipaChanged(selectedItems));
}

void _handleNingunoIdSelection(
    BuildContext context,
    bool value,
    List<LstEventoCostumbreParticipa> selectedItems,
    int eventoCostumbreParticipaId,
    int ningunoId) {
  _updateSelectedItemsWithNingunoId(
      value, selectedItems, eventoCostumbreParticipaId, ningunoId);
}

void _handleRegularSelection(
    BuildContext context,
    bool value,
    List<LstEventoCostumbreParticipa> selectedItems,
    int eventoCostumbreParticipaId) {
  _updateSelectedItemsRegular(value, selectedItems, eventoCostumbreParticipaId);
}

void _updateSelectedItemsWithNingunoId(
    bool value,
    List<LstEventoCostumbreParticipa> selectedItems,
    int eventoCostumbreParticipaId,
    int ningunoId) {
  if (eventoCostumbreParticipaId == ningunoId) {
    selectedItems.clear();
    selectedItems.add(
        LstEventoCostumbreParticipa(eventoCostumbreParticipaId: ningunoId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.eventoCostumbreParticipaId == ningunoId);
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
