import 'package:flutter/material.dart';

import '../../../data/models/servicio_publico_vivienda_model.dart';
import '../../blocs/dim_vivienda/dim_vivienda_bloc.dart';

void handleServiciosPublicosSelection(
    FormFieldState<List<LstServPublico>> formState,
    int? ningunaId,
    BuildContext context,
    bool? value,
    int servicioPublicoViviendaId,
    DimViviendaBloc dimViviendaBloc) {
  var selectedItems = List<LstServPublico>.from(formState.value ?? []);

  if (ningunaId != null) {
    _handleNingunaIdSelection(
        context, value!, selectedItems, servicioPublicoViviendaId, ningunaId);
  } else {
    _handleRegularSelection(
        context, value!, selectedItems, servicioPublicoViviendaId);
  }

  formState.didChange(selectedItems);
  dimViviendaBloc.add(ServiciosPublicosViviendaChanged(selectedItems));
}

void _handleNingunaIdSelection(
    BuildContext context,
    bool value,
    List<LstServPublico> selectedItems,
    int servicioPublicoViviendaId,
    int ningunaId) {
  _updateSelectedItemsWithNingunaId(
      value, selectedItems, servicioPublicoViviendaId, ningunaId);
}

void _handleRegularSelection(BuildContext context, bool value,
    List<LstServPublico> selectedItems, int servicioPublicoViviendaId) {
  _updateSelectedItemsRegular(value, selectedItems, servicioPublicoViviendaId);
}

void _updateSelectedItemsWithNingunaId(
    bool value,
    List<LstServPublico> selectedItems,
    int servicioPublicoViviendaId,
    int ningunaId) {
  if (servicioPublicoViviendaId == ningunaId) {
    selectedItems.clear();
    selectedItems.add(LstServPublico(servicioPublicoViviendaId: ningunaId));
  } else if (value) {
    selectedItems.removeWhere((e) => e.servicioPublicoViviendaId == ningunaId);
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
