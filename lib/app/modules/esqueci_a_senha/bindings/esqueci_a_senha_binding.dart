import 'package:get/get.dart';

import '../controllers/esqueci_a_senha_controller.dart';

class EsqueciASenhaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EsqueciASenhaController>(
      () => EsqueciASenhaController(),
    );
  }
}
