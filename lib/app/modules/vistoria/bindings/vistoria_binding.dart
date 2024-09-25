import 'package:get/get.dart';

import '../controllers/vistoria_controller.dart';

class VistoriaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VistoriaController>(
      () => VistoriaController(),
    );
  }
}
