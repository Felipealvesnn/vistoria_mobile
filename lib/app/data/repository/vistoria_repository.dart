import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vistoria_mobile/app/data/global/constants.dart';
import 'package:vistoria_mobile/app/data/models/VeiculoDetran.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:vistoria_mobile/app/data/models/vistoriaMobileDTO.dart';
import 'package:vistoria_mobile/app/data/provider/vistoria_provider.dart';

class VistoriaRepository {
  final VistoriaProvider vistoriaclient = VistoriaProvider();

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

  Future<Map<String, dynamic>> getPlaca({required String placa}) async {
    // Faz a primeira requisição para verificar se o permissionário existe
    var deranPermissio = await vistoriaclient.getPermissionario(placa);

    // Verifica se a resposta contém "Sucesso": false
    if (deranPermissio['Sucesso'] == false) {
      // Lança a exceção personalizada
      throw PermissionarioNotFoundException(deranPermissio['Mensagem']);
    }

    // Se tiver sucesso, faz a segunda requisição para buscar o veículo
    var itens = await vistoriaclient.getPlacaDetran(placa);
    VeiculoDetran veiculoDetran = VeiculoDetran.fromJson(itens);

    print(itens);

    // Retorna um mapa contendo o tipo do permissionário e o veículo
    return {
      'TipoPermissionario': deranPermissio['TipoPermissionario'],
      'VeiculoDetran': veiculoDetran,
    };
  }

  Future<List<FotosVistorium>> getImagemVistoria({required int placa}) async {
    try {
      var itens = await vistoriaclient.getImagemVistoria(placa);

      // Garantir que 'itens' é uma lista de mapas
      List<FotosVistorium> fotosVistorium = (itens as List<dynamic>)
          .map((json) => FotosVistorium.fromJson(json as Map<String, dynamic>))
          .toList();

      return fotosVistorium;
    } on Exception catch (e) {
      print("Erro ao buscar notificações: $e");
      return [];
    }
  }

  Future<vistoriaMobileDTO> getvistoriaMobileDTO({int? page}) async {
    try {
      // Obtém a lista de notificações do provedor
      Map<String, dynamic> jsonList =
          await vistoriaclient.getVistoriaMobileDTO(page);
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

// Exceção personalizada
class PermissionarioNotFoundException implements Exception {
  final String message;

  PermissionarioNotFoundException(this.message);

  @override
  String toString() => message;
}
