import 'package:vistoria_mobile/app/data/global/constants.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:vistoria_mobile/app/data/models/vistoriaMobileDTO.dart';
import 'package:vistoria_mobile/app/data/provider/vistoria_provider.dart';

class VistoriaRepository {
  final vistoriaProvider vistoriaclient = vistoriaProvider();

  Future<List<Vistoria>> getVistorias({int? page}) async {
    try {
      // Obtém a lista de notificações do provedor
      // List<dynamic> jsonList = await vistoriaclient.getVistoria(page);
      //   List<Vistoria> vistoriaList =
      //     jsonList.map((json) => Vistoria.fromJson(json)).toList();

      List<Vistoria> mockData =
          jsonMoch.map((json) => Vistoria.fromJson(json)).toList();
      // Mapeia a lista de JSON para uma lista de objetos Notificacoes

      return mockData;
    } catch (e) {
      print("Erro ao buscar notificações: $e");
      // Retorna uma lista vazia em caso de erro
      return [];
    }
  }

  Future<dynamic> getPlaca({required int placa}) async {
    var itens = await vistoriaclient.getPlacaDetraN(placa);
    return itens;
  }

  Future<List<vistoriaMobileDTO>> getvistoriaMobileDTO({int? page}) async {
    try {
      // Obtém a lista de notificações do provedor
      // List<dynamic> jsonList = await vistoriaclient.getVistoria(page);
      //   List<Vistoria> vistoriaList =
      //     jsonList.map((json) => Vistoria.fromJson(json)).toList();

      List<vistoriaMobileDTO> mockData = vistoriaMobileDTOjson
          .map((json) => vistoriaMobileDTO.fromJson(json))
          .toList();
      // Mapeia a lista de JSON para uma lista de objetos Notificacoes

      return mockData;
    } catch (e) {
      print("Erro ao buscar notificações: $e");
      // Retorna uma lista vazia em caso de erro
      return [];
    }
  }
}
