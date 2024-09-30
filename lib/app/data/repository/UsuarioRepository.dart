import 'package:vistoria_mobile/app/data/models/Usuario.dart';
import 'package:vistoria_mobile/app/data/provider/usuario_provider.dart';

class UsuarioRepository {
  UsuarioProvider _usuarioProvider = UsuarioProvider();
  
  Future<usuarioDtop> login(Usuario usu) async {
    try {
      var usuar = await _usuarioProvider.postVistoria(usu);
      usuarioDtop usuario = usuarioDtop.fromMap(usuar);
      return usuario;
    } on Exception catch (e) {
      // Captura a exceção e faz o tratamento adequado (log, mensagem de erro, etc.)
      print('Failed to login: $e');
      throw Exception('Falha ao realizar login.'); // Ou trate de outra forma
    } catch (error) {
      // Captura erros genéricos, caso ocorram
      print('Unexpected error: $error');
      throw Exception('Ocorreu um erro inesperado.');
    }
  }

  Future emailResetar(String email, String senha) async {}

  Future enviarEmail(String email, String codigo) async {}
}
