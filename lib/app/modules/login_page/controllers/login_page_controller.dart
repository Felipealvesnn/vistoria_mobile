import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/data/models/Usuario.dart';
import 'package:vistoria_mobile/app/data/repository/UsuarioRepository.dart';
import 'package:vistoria_mobile/app/routes/app_pages.dart';
import 'package:vistoria_mobile/app/utils/getstorages.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class LoginPageController extends GetxController {
  RxBool showPassword = true.obs;
  RxBool loading = false.obs;
  RxBool isSwitched = false.obs;

  UsuarioRepository repository = UsuarioRepository();

  void login(String email, String senha) async {
    try {
      loading.value = true;
      Usuario userf = Usuario(usuEmail: email, usuSenha: senha);
      final user = await repository.login(userf);

      if (user.token != null) {
        await Storagers.boxUserLogado.write("user", user.usuario);
        // Storagers.boxCpf.write('boxCpf', user.usuario.cpf.toString());
        await Storagers.boxToken.write('boxToken', user.token.toString());
        print(user.token);

        await Get.offAllNamed(Routes.VISTORIA, arguments: [
          {"user": user}
        ]);
      } else if (user.usuario != null && user.usuario!.usuAtivo == true) {
        Get.snackbar(
          "Impossível autenticar",
          "Usuário Inativo",
          icon: const Icon(Icons.error_outline,
              color: Color.fromARGB(255, 214, 205, 205)),
          colorText: Colors.white,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Impossível autenticar",
        "Usuário ou senha inválidos",
        icon: const Icon(Icons.error_outline,
            color: Color.fromARGB(255, 214, 205, 205)),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        snackPosition: SnackPosition.TOP,
      );
      print("Erro ao efetuar login: $e");
      // Trate o erro de acordo com suas necessidades, por exemplo, exibindo uma mensagem de erro.
    } finally {
      loading.value = false;
    }
  }

  Future verifyAuth() async {
    var biometria = await Storagers.boxInicial.read('biometria');
    Usuario user = Usuario();
    final usuario = await Storagers.boxUserLogado.read('user');
    if (usuario != null) {
      user = usuario is Usuario ? usuario : Usuario.fromJson(usuario);
      print(user.usuLogin);
    }

    if (user.usuCPF != null) {
      if (biometria ?? false) {
        await Get.offAllNamed(Routes.WELCOME);
        //return await authenticateWithBiometrics();
      }

      return Get.offAllNamed(Routes.VISTORIA);
    } else {
     // await Get.offAllNamed(Routes.LOGIN);

      //return const WelcomeView();
    }
  }

  Future<void> authenticateWithBiometrics() async {
    final LocalAuthentication localAuth = LocalAuthentication();

    try {
      bool canCheckBiometrics = await localAuth.canCheckBiometrics;

      if (canCheckBiometrics) {
        List<BiometricType> availableBiometrics =
            await localAuth.getAvailableBiometrics();

        if (availableBiometrics.isNotEmpty) {
          final bool isAuthenticated = await localAuth.authenticate(
            localizedReason: 'Por favor autentique para entrar no app',
            authMessages: const <AuthMessages>[IOSAuthMessages(), AndroidAuthMessages(
            signInTitle: 'Autenticação biométrica',
            biometricHint: '',
            ), ],
            options: const AuthenticationOptions(biometricOnly: true),
          );

          if (isAuthenticated) {
            Storagers.boxInicial.write('biometria', true);
            await Get.offAllNamed(Routes.VISTORIA, arguments: false);
          } else {
            return;
          }
        } else {
          // O dispositivo não suporta autenticação por impressão digital
        }
      } else {
        // O dispositivo não suporta autenticação biométrica
      }
    } on PlatformException catch (e) {
      // Lidar com exceções, se houver
      print("Erro na autenticação biométrica: $e");
    }
  }

  @override
  onInit() async {
    isSwitched.value = await Storagers.boxInicial.read('biometria') ?? false;
    await verifyAuth();

    super.onInit();
  }

  mudarBiometria() {
    Storagers.boxInicial.write('biometria', isSwitched.value);
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {}
}
