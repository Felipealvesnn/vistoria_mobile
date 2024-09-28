import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/data/repository/UsuarioRepository.dart';
import 'package:vistoria_mobile/app/routes/app_pages.dart';
import 'package:vistoria_mobile/app/utils/getstorages.dart';

class LoginPageController extends GetxController {
  RxBool showPassword = true.obs;
  RxBool loading = false.obs;
  RxBool isSwitched = false.obs;

  UsuarioRepository repository = UsuarioRepository();

  void login(String email, String senha) async {
    try {
      loading.value = true;
      await Get.offAllNamed(Routes.VISTORIA);
      final user = await repository.login(email, senha);

      if (user != null && user.ativo!) {
        Storagers.boxUserLogado.write("user", user);
        Storagers.boxCpf.write('boxCpf', user.cpf.toString());
        Storagers.boxToken.write('boxToken', user.token.toString());
        print(user.token);

        await Get.offAllNamed(Routes.HOME, arguments: [
          {"user": user}
        ]);
      } else if (user != null && !user.ativo!) {
        Get.snackbar(
          "Impossível autenticar",
          "Usuário Inativo",
          icon: Icon(Icons.error_outline,
              color: const Color.fromARGB(255, 214, 205, 205)),
          colorText: Colors.white,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print("Erro ao efetuar login: $e");
      // Trate o erro de acordo com suas necessidades, por exemplo, exibindo uma mensagem de erro.
    } finally {
      loading.value = false;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
