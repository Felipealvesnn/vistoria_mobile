import 'package:get/get_connect/connect.dart';
import 'package:vistoria_mobile/app/data/global/constants.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:vistoria_mobile/app/utils/funcoesUtils.dart';
import 'package:vistoria_mobile/app/utils/getstorages.dart';

class vistoriaProvider extends GetConnect {
  // Método para buscar vistorias por placa, dataInicial ou dataFinal
  Future searchVistorias(
      {String? placa, String? dataInicial, String? dataFinal}) async {
    timeout = const Duration(minutes: 10);
    final token = Storagers.boxToken.read("boxToken");

    final headers = {"Authorization": 'Bearer $token'};

    // Monta a URL de acordo com os parâmetros fornecidos
    String url = "${baseUrlw2e}getVistoriasFiltro";
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
      url += "?${queryParams.join('&')}";
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

    // Adiciona os parâmetros de paginação na URL
    var response = await get(
      "$baseUrlw2e/Vistoria?pageNumber=$pageNumber&pageSize=$pageSize",
      contentType: 'application/json',
      headers: headers,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future getvistoriaMobileDTO(int? page) async {
    timeout = const Duration(minutes: 10);
    final token = Storagers.boxToken.read("boxToken");

    final headers = {"Authorization": 'Bearer $token'};

    var response = await get("$baseUrlw2e/getmobile",
        contentType: 'application/json', headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future getPlacaDetraN(String placa) async {
    timeout = const Duration(minutes: 10);
    final token = Storagers.boxToken.read("boxToken");
    final headers = {"Authorization": 'Bearer $token'};

    var response = await get(
        "$pesquisarplacaURl/ConsultaPlaca?placa=$placa&blitz=n&blitzID=n",
        contentType: 'application/json',
        headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data!');
    }
  }
  
   Future getPpermissionario(String placa) async {
    timeout = const Duration(minutes: 10);
    final token = Storagers.boxToken.read("boxToken");
    final headers = {"Authorization": 'Bearer $token'};

    var response = await get(
        "$baseUrlw2e/getPermissionario?placa=$placa",
        contentType: 'application/json',
        headers: headers);

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

      // Configura os headers
      final headers = {"Authorization": 'Bearer $token'};

      // Faz a requisição POST
      var response =
          await post("$baseUrlw2e/Create", vistoria, headers: headers);

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
