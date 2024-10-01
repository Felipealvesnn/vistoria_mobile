import 'package:get/get.dart';
import 'package:vistoria_mobile/app/routes/app_pages.dart';
import 'package:vistoria_mobile/app/utils/getstorages.dart';

class WelcomeController extends GetxController {
  //TODO: Implement WelcomeController

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

  static void logout() async {
    Storagers.boxUserLogado.erase();
    Storagers.boxCpf.erase();
    Storagers.boxToken.erase();

    await Get.offAllNamed(Routes.LOGIN);
  }

  void increment() => count.value++;
}
