import 'package:flutter/material.dart';

import '../../../data/models/servicio_publico_vivienda_model.dart';
import '../../blocs/dim_vivienda/dim_vivienda_bloc.dart';

void handleServiciosPublicosSelection(
    FormFieldState<List<LstServPublico>> formState,
    int? optionId,
    BuildContext context,
    bool? value,
    int servicioPublicoViviendaId,
    DimViviendaBloc dimViviendaBloc) {
  var selectedItems = List<LstServPublico>.from(formState.value ?? []);

  if (optionId != null) {
    _handleOptionIdSelection(
        context, value!, selectedItems, servicioPublicoViviendaId, optionId);
  } else {
    _handleRegularSelection(
        context, value!, selectedItems, servicioPublicoViviendaId);
  }

  formState.didChange(selectedItems);
  dimViviendaBloc.add(ServiciosPublicosViviendaChanged(selectedItems));
}

void _handleOptionIdSelection(
    BuildContext context,
    bool value,
    List<LstServPublico> selectedItems,
    int servicioPublicoViviendaId,
    int optionId) {
  _updateSelectedItemsWithOptionId(
      value, selectedItems, servicioPublicoViviendaId, optionId);
}

void _handleRegularSelection(BuildContext context, bool value,
    List<LstServPublico> selectedItems, int servicioPublicoViviendaId) {
  _updateSelectedItemsRegular(value, selectedItems, servicioPublicoViviendaId);
}

void _updateSelectedItemsWithOptionId(
    bool value,
    List<LstServPublico> selectedItems,
    int servicioPublicoViviendaId,
    int optionId) {
  if (servicioPublicoViviendaId == optionId) {
    selectedItems.clear();
    selectedItems.add(LstServPublico(servicioPublicoViviendaId: optionId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.servicioPublicoViviendaId == optionId);
    selectedItems.add(
        LstServPublico(servicioPublicoViviendaId: servicioPublicoViviendaId));
  } else {
    selectedItems.removeWhere(
        (e) => e.servicioPublicoViviendaId == servicioPublicoViviendaId);
  }
}

void _updateSelectedItemsRegular(bool value, List<LstServPublico> selectedItems,
    int servicioPublicoViviendaId) {
  if (value) {
    selectedItems.add(
        LstServPublico(servicioPublicoViviendaId: servicioPublicoViviendaId));
  } else {
    selectedItems.removeWhere(
        (e) => e.servicioPublicoViviendaId == servicioPublicoViviendaId);
  }
}
