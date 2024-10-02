import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vistoria_mobile/app/data/global/constants.dart';
import 'package:vistoria_mobile/app/data/models/VeiculoDetran.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:vistoria_mobile/app/data/models/vistoriaMobileDTO.dart';
import 'package:vistoria_mobile/app/data/provider/vistoria_provider.dart';

class VistoriaRepository {
  final vistoriaProvider vistoriaclient = vistoriaProvider();

  Future<List<Vistoria>> searchFiltroVistorias(
      {String? placa, String? dataInicial, String? dataFinal}) async {
    try {
      // Faz a requisição GET ao endpoint
      var response = await vistoriaclient.searchVistorias(
          placa: placa, dataInicial: dataInicial, dataFinal: dataFinal);

      if (response is List) {
        // Faz o cast para List<Map<String, dynamic>>
        List<Vistoria> mockData = response
            .map((json) => Vistoria.fromJson(json as Map<String, dynamic>))
            .toList();
        return mockData;
      } else {
        // Retorna uma lista vazia em caso de erro
        return [];
      }
    } catch (e) {
      print("Erro ao buscar notificações: $e");
      // Retorna uma lista vazia em caso de erro
      return [];
    }
  }

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
    // Faz a primeira requisição para verificar se o permissionário existe
    var deranPermissio = await vistoriaclient.getPpermissionario(placa);

    // Verifica se a resposta contém "Sucesso": false
    if (deranPermissio['Sucesso'] == false) {
      Get.snackbar(
        'Erro',
       'Permissionario não encontrado',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      // Caso não tenha sucesso, lança uma exceção ou retorna um valor padrão
      throw Exception(deranPermissio['Mensagem']);
      // ou
      // return VeiculoDetran(); // Retorna um objeto vazio ou de acordo com sua lógica de negócios
    }

    // Se tiver sucesso, faz a segunda requisição
    var itens = await vistoriaclient.getPlacaDetraN(placa);
    VeiculoDetran veiculoDetran = VeiculoDetran.fromJson(itens);

    print(itens);

    return veiculoDetran;
  }

  Future<vistoriaMobileDTO> getvistoriaMobileDTO({int? page}) async {
    try {
      // Obtém a lista de notificações do provedor
      Map<String, dynamic> jsonList =
          await vistoriaclient.getvistoriaMobileDTO(page);
      vistoriaMobileDTO mockData = vistoriaMobileDTO.fromJson(jsonList);

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
