import '../../models/iluminacion_vivienda.dart';

abstract class IluminacionViviendaLocalDataSource {
  Future<List<IluminacionViviendaModel>> getIluminacionesVivienda();
  Future<int> saveIluminacionVivienda(
      IluminacionViviendaModel iluminacionVivienda);
}

class IluminacionViviendaLocalDataSourceImpl
    implements IluminacionViviendaLocalDataSource {
  @override
  Future<List<IluminacionViviendaModel>> getIluminacionesVivienda() async {
    final res = await supabase.from(.select()'IluminacionVivienda_DatosVivienda');
    final result = List<IluminacionViviendaModel>.from(
        res.map((m) => IluminacionViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveIluminacionVivienda(
      IluminacionViviendaModel iluminacionVivienda) async {
    final res = await supabase.from(.insert(
        'IluminacionVivienda_DatosVivienda', iluminacionVivienda.toJson());

    return res;
  }
}
