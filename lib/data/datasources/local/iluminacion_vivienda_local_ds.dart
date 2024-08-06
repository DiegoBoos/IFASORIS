import '../../../core/constants.dart';
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
    final res =
        await supabase.from('IluminacionVivienda_DatosVivienda').select();
    final result = List<IluminacionViviendaModel>.from(
        res.map((m) => IluminacionViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveIluminacionVivienda(
      IluminacionViviendaModel iluminacionVivienda) async {
    final res = await supabase
        .from('IluminacionVivienda_DatosVivienda')
        .insert(iluminacionVivienda.toJson());

    return res;
  }
}
