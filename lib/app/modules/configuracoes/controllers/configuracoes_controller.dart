import 'package:get/get.dart';
import 'package:vistoria_mobile/app/utils/getstorages.dart';

class ConfiguracoesController extends GetxController {
  //TODO: Implement ConfiguracoesController
  RxBool isBiometriaEnabled = false.obs;

  final count = 0.obs;
  @override
  void onInit() async {
    isBiometriaEnabled.value =
        await Storagers.boxInicial.read('biometria') ?? false;
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

  mudarBiometria() {
    Storagers.boxInicial.write('biometria', isBiometriaEnabled.value);
  }

  void increment() => count.value++;
}
