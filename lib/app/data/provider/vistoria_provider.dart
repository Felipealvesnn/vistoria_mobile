import 'package:get/get_connect/connect.dart';
import 'package:vistoria_mobile/app/data/global/constants.dart';
import 'package:vistoria_mobile/app/utils/funcoesUtils.dart';

class vistoriaProvider extends GetConnect {
  Future getVistoria(int? page) async {
    timeout = const Duration(minutes: 10);
    final token = getUsuario();
    final headers = {"Authorization": 'Bearer ${token.token}'};

    var response = await get(
        "$baseUrlw2e/Vistorium/VistoriaMobile?page=$page&cpfUsuario=${token.cpf}",
        contentType: 'application/json',
        headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future getPlacaDetraN(String placa) async {
    timeout = const Duration(minutes: 10);
    final token = getUsuario();
    token.token = "ff";
    final headers = {"Authorization": 'Bearer ${token.token}'};

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
  
  Future postVistoria(Map<dynamic, dynamic> vistoria) async {
    timeout = const Duration(minutes: 10);
    final token = getUsuario();
    final headers = {"Authorization": 'Bearer ${token.token}'};

    var response = await post("$baseUrlw2e/Vistorium/VistoriaMobile",
        vistoria, headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
