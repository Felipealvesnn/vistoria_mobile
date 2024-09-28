import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/data/repository/UsuarioRepository.dart';
import 'package:vistoria_mobile/app/modules/esqueci_a_senha/views/novaSenha.dart';
import 'package:vistoria_mobile/app/routes/app_pages.dart';
import 'package:vistoria_mobile/app/utils/getstorages.dart';

class EsqueciASenhaController extends GetxController {
  //TODO: Implement EsqueciASenhaController
  UsuarioRepository repository = UsuarioRepository();

  RxBool pinSuccess = false.obs;
  RxString email = ''.obs;
  final count = 0.obs;
  final RxBool botaoEmailEnviado = true.obs;
  final RxBool emailNaoEnviado = true.obs;
  final RxInt segundosRestantes = 0.obs;

  Timer? _timer;

  void iniciarContagemRegressiva() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (segundosRestantes.value > 0) {
        segundosRestantes.value--;
      } else {
        botaoEmailEnviado.value = true;
        _timer?.cancel();
      }
    });
  }

  String generateRandomDigits() {
    final Random random = Random();
    const String chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String result = '';

    for (int i = 0; i < 4; i++) {
      result += chars[random.nextInt(chars.length)];
    }

    return result;
  }

  Future<void> reenviar() async {
    if (segundosRestantes.value == 0) {
      try {
        // Chame sua função para resetar a senha (enviar o código de verificação)
        await resetPassword(email.value);

        // Mostra um diálogo de sucesso
        Get.dialog(
          AlertDialog(
            title: const Text("Sucesso"),
            content: const Text("Código de verificação reenviado com sucesso."),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Get.back(); // Fecha o diálogo
                },
              ),
            ],
          ),
        );
      } catch (e) {
        // Em caso de erro, exiba uma mensagem de erro
        Get.dialog(
          AlertDialog(
            title: const Text("Erro"),
            content: const Text(
                "Falha ao enviar o código de verificação. Tente novamente mais tarde."),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Get.back(); // Fecha o diálogo
                },
              ),
            ],
          ),
        );
      }
    } else {
      // Mostra um diálogo informando para aguardar
      Get.dialog(
        AlertDialog(
          title: const Text("Aguarde"),
          content: const Text(
              "Por favor, aguarde um momento antes de tentar reenviar."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Get.back(); // Fecha o diálogo
              },
            ),
          ],
        ),
      );
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      if (segundosRestantes.value == 0) {
        emailNaoEnviado.value = false;
        botaoEmailEnviado.value = false;
        final String codigo = generateRandomDigits();
        await Storagers.boxToken.write('codigo', codigo);
        await Storagers.boxUserLogado.write('emailResetar', email);
        await repository.enviarEmail(email, codigo);
        Get.toNamed(Routes.ESQUECI_A_SENHA_VERIFICACAO);
        Get.snackbar(
          'Sucesso',
          'Email enviado com sucesso, verifique sua caixa de entrada.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        segundosRestantes.value = 30;
        iniciarContagemRegressiva();
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          botaoEmailEnviado.value = true;
        });

        Get.snackbar(
          'Atenção',
          'Aguarde ${segundosRestantes.value} segundos antes de enviar outro email.',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Erro ao enviar email',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> verificarCodigo(String codigo) async {
    try {
      final String codigoSalvo = Storagers.boxToken.read('codigo');
      if (codigo.toUpperCase() == codigoSalvo) {
        Get.to(NovaSenhaPage());
      } else {
        Get.snackbar(
          'Erro',
          'Código inválido',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Erro ao verificar código',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
