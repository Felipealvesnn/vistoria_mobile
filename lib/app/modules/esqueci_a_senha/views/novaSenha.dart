import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vistoria_mobile/app/data/repository/UsuarioRepository.dart';
import 'package:vistoria_mobile/app/modules/login_page/views/header_widget.dart';
import 'package:vistoria_mobile/app/routes/app_pages.dart';
import 'package:vistoria_mobile/app/utils/getstorages.dart';

class NovaSenhaController extends GetxController {
  final senha = ''.obs;
  final confirmarSenha = ''.obs;
  final senhaVisivel = false.obs;
  final confirmarSenhaVisivel = false.obs;
  final Naoenviado = true.obs;
  UsuarioRepository repository = UsuarioRepository();

  void toggleSenhaVisibility() {
    senhaVisivel.value = !senhaVisivel.value;
  }

  void toggleConfirmarSenhaVisibility() {
    confirmarSenhaVisivel.value = !confirmarSenhaVisivel.value;
  }

  bool validarSenhas() {
    if (senha.value == confirmarSenha.value && senha.value.isNotEmpty) {
      return true;
    } else {
      Get.snackbar(
        'Erro',
        'Senhas não correspondem ou são inválidas',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }

  void resetarSenha() async {
    if (validarSenhas()) {
      var email = Storagers.boxUserLogado.read('emailResetar');
      try {
        // Chame seu repositório ou serviço para resetar a senha
        await repository.emailResetar(email, senha.value);
        Naoenviado.value = false;

        Get.snackbar(
          'Sucesso',
          'Senha alterada com sucesso',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        //  await Get.offAllNamed(Routes.HOME);
        await Get.offAllNamed(Routes.LOGIN);
      } catch (e) {
        Get.snackbar(
          'Erro',
          'Falha ao redefinir a senha',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        Naoenviado.value = true;
      }
    }
  }
}

class NovaSenhaPage extends StatelessWidget {
  final NovaSenhaController controller = Get.put(NovaSenhaController());
  final _headerHeight = Get.size.height / 3;

  NovaSenhaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redefinição de Senha'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child:
                  HeaderWidget(_headerHeight, true, Icons.privacy_tip_outlined),
            ),
            Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                children: [
                  const Text(
                    'Redefina sua senha',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => TextField(
                        obscureText: !controller.senhaVisivel.value,
                        onChanged: (value) => controller.senha.value = value,
                        decoration: InputDecoration(
                          labelText: 'Nova Senha',
                          suffixIcon: IconButton(
                            onPressed: () => controller.toggleSenhaVisibility(),
                            icon: Icon(controller.senhaVisivel.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => TextField(
                        obscureText: !controller.confirmarSenhaVisivel.value,
                        onChanged: (value) =>
                            controller.confirmarSenha.value = value,
                        decoration: InputDecoration(
                          labelText: 'Confirmar Nova Senha',
                          suffixIcon: IconButton(
                            onPressed: () =>
                                controller.toggleConfirmarSenhaVisibility(),
                            icon: Icon(controller.confirmarSenhaVisivel.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => ElevatedButton(
                        onPressed: controller.Naoenviado.value
                            ? () async {
                                controller.resetarSenha();
                              }
                            : null,
                        child: controller.Naoenviado.value
                            ? const Text('Salvar')
                            : const CircularProgressIndicator(),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
