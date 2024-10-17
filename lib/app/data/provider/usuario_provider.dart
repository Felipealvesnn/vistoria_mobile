import 'package:get/get_connect/connect.dart';
import 'package:vistoria_mobile/app/data/global/constants.dart';
import 'package:vistoria_mobile/app/data/models/Usuario.dart';
import 'package:vistoria_mobile/app/utils/funcoesUtils.dart';

class UsuarioProvider extends GetConnect {
  Future postVistoria(Usuario usu) async {
    timeout = const Duration(minutes: 10);
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "sdfsdf"
    };

    final body = usu.toJson();

     var response = await post(
      "$baseUrlw2e/login?cliente=$nomeCliente", // Nome do cliente adicionado como query parameter
      body,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
