import 'package:get/get_connect/connect.dart';
import 'package:vistoria_mobile/app/data/global/constants.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:vistoria_mobile/app/utils/funcoesUtils.dart';
import 'package:vistoria_mobile/app/utils/getstorages.dart';


class VistoriaProvider extends GetConnect {
  // Método para buscar vistorias por placa, dataInicial ou dataFinal
  Future searchVistorias(
      {String? placa, String? dataInicial, String? dataFinal}) async {
    timeout = const Duration(minutes: 10);
    final token = Storagers.boxToken.read("boxToken");

    final headers = {"Authorization": 'Bearer $token'};

    // Monta a URL de acordo com os parâmetros fornecidos e o nome do cliente
    String url = "${baseUrlw2e}getVistoriasFiltro?cliente=$nomeCliente";
    List<String> queryParams = [];

    if (placa != null && placa.isNotEmpty) {
      queryParams.add("placa=$placa");
    }
    if (dataInicial != null && dataInicial.isNotEmpty) {
      queryParams.add("dataInicial=$dataInicial");
    }
    if (dataFinal != null && dataFinal.isNotEmpty) {
      queryParams.add("dataFinal=$dataFinal");
    }

    // Adiciona os parâmetros à URL
    if (queryParams.isNotEmpty) {
      url += "&${queryParams.join('&')}";
    }

    // Faz a requisição GET ao endpoint
    var response = await get(
      url,
      contentType: 'application/json',
      headers: headers,
    );

    if (response.statusCode == 200) {
      return response.body["Vistorias"];
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future getVistoria(int pageNumber) async {
    
    timeout = const Duration(minutes: 10);
    int pageSize = 10;
    final token = Storagers.boxToken.read("boxToken");

    final headers = {"Authorization": 'Bearer $token'};

    // Adiciona os parâmetros de paginação na URL, incluindo o nome do cliente
    var response = await get(
      "$baseUrlw2e/Vistoria?cliente=$nomeCliente&pageNumber=$pageNumber&pageSize=$pageSize",
      contentType: 'application/json',
      headers: headers,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future getVistoriaMobileDTO(int? page) async {
    timeout = const Duration(minutes: 10);
    final token = Storagers.boxToken.read("boxToken");

    final headers = {"Authorization": 'Bearer $token'};

    var response = await get("$baseUrlw2e/getmobile?cliente=$nomeCliente",
        contentType: 'application/json', headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future getPlacaDetran(String placa) async {
    timeout = const Duration(minutes: 10);
    final token = Storagers.boxToken.read("boxToken");
    final headers = {"Authorization": 'Bearer $token'};

    var response = await get(
        "$pesquisarplacaURl/ConsultaPlaca?cliente=$nomeCliente&placa=$placa&blitz=n&blitzID=n",
        contentType: 'application/json',
        headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future getPermissionario(String placa) async {
    timeout = const Duration(minutes: 10);
    final token = Storagers.boxToken.read("boxToken");
    final headers = {"Authorization": 'Bearer $token'};

    var response = await get("$baseUrlw2e/getPermissionario?cliente=$nomeCliente&placa=$placa",
        contentType: 'application/json', headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future getImagemVistoria(int id) async {
    timeout = const Duration(minutes: 10);
    final token = Storagers.boxToken.read("boxToken");
    final headers = {"Authorization": 'Bearer $token'};

    var response = await get("$baseUrlw2e/GetmagemVistoria?cliente=$nomeCliente&id=$id",
        contentType: 'application/json', headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<dynamic> postVistoria(Map<dynamic, dynamic> vistoria) async {
    try {
      timeout = const Duration(minutes: 10);

      // Lê o token armazenado
      final token = Storagers.boxToken.read("boxToken");

      // Verifica se o token está presente e não está vazio
      if (token == null || token.isEmpty) {
        throw Exception('Token de autenticação não encontrado ou inválido!');
      }

      // Verifica se os dados de vistoria estão presentes
      if (vistoria.isEmpty) {
        throw Exception('Dados de vistoria não podem estar vazios!');
      }
      print(vistoria.toString());

      // Configura os headers
      final headers = {"Authorization": 'Bearer $token'};

      // Faz a requisição POST, incluindo o nome do cliente
      var response =
          await post("$baseUrlw2e/Create?cliente=$nomeCliente", vistoria, headers: headers);

      // Verifica se a resposta foi bem-sucedida
      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Lança uma exceção para qualquer status de erro
        throw Exception(
            'Falha ao carregar dados! Código de status: ${response.statusCode}');
      }
    } catch (e) {
      // Lança a exceção capturada para tratamento posterior
      throw Exception('Erro ao enviar dados de vistoria: $e');
    }
  }
}
