import 'package:get/get.dart';
import 'package:vistoria_mobile/app/data/models/Usuario.dart';
import 'package:vistoria_mobile/app/routes/app_pages.dart';
import 'package:vistoria_mobile/app/utils/getstorages.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  Future verifyAuth() async {
    var biometria = await Storagers.boxInicial.read('biometria');
    Usuario user = Usuario();
    final usuario = await Storagers.boxUserLogado.read('user');
    if (usuario != null) {
      user = usuario is Usuario ? usuario : Usuario.fromJson(usuario);
      print(user.usuLogin);
      await Storagers.boxUserLogado.write('user', user);
    }

    if (user.usuCPF != null) {
      if (biometria ?? false) {
        await Get.offAllNamed(Routes.WELCOME);
        //return await authenticateWithBiometrics();
      }

      return Get.offAllNamed(Routes.VISTORIA);
    } else {
      await Get.offAllNamed(Routes.LOGIN);

      //return const WelcomeView();
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
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  static void logout() {}
}
