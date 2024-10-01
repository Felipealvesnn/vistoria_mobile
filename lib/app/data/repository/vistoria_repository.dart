import 'package:vistoria_mobile/app/data/global/constants.dart';
import 'package:vistoria_mobile/app/data/models/VeiculoDetran.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:vistoria_mobile/app/data/models/vistoriaMobileDTO.dart';
import 'package:vistoria_mobile/app/data/provider/vistoria_provider.dart';

class VistoriaRepository {
  final vistoriaProvider vistoriaclient = vistoriaProvider();

  Future<List<Vistoria>> getVistorias({int? page}) async {
    try {
     // Obtém a lista de notificações do provedor
      List<dynamic> jonsonVistoria = await vistoriaclient.getVistoria(page!);
       
      List<Vistoria> mockData =
          jonsonVistoria.map((json) => Vistoria.fromJson(json)).toList();

     

      // List<Vistoria> mockData =
      //     jsonMoch.map((json) => Vistoria.fromJson(json)).toList();
      

      return mockData;
    } catch (e) {
      print("Erro ao buscar notificações: $e");
      // Retorna uma lista vazia em caso de erro
      return [];
    }
  }

  Future<VeiculoDetran> getPlaca({required String placa}) async {
    var itens = await vistoriaclient.getPlacaDetraN(placa);
    VeiculoDetran veiculoDetran = VeiculoDetran.fromJson(itens);
    print(itens);
    return veiculoDetran;
  }

  Future<vistoriaMobileDTO> getvistoriaMobileDTO({int? page}) async {
    try {
      // Obtém a lista de notificações do provedor
      Map<String, dynamic> jsonList = await vistoriaclient.getvistoriaMobileDTO(page);
        vistoriaMobileDTO mockData =
           vistoriaMobileDTO.fromJson(jsonList);

      // List<vistoriaMobileDTO> mockData = vistoriaMobileDTOjson
      //     .map((json) => vistoriaMobileDTO.fromJson(json))
      //     .toList();
      // Mapeia a lista de JSON para uma lista de objetos Notificacoes

      return mockData;
    } catch (e) {
      print("Erro ao buscar notificações: $e");
      // Retorna uma lista vazia em caso de erro
      return vistoriaMobileDTO.vistoriaMobileDTO();
    }
  }
  
  Future<void> postVistoria(Map<dynamic, dynamic> vistoria) async {
    try {
      // Envia a notificação para o provedor
      await vistoriaclient.postVistoria(vistoria);
    } catch (e) {
      print("Erro ao enviar notificação: $e");
    }
  }

}
