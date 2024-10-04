import 'package:get/get.dart';

import '../controllers/vistoria_detalhes_controller.dart';

class VistoriaDetalhesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VistoriaDetalhesController>(
      () => VistoriaDetalhesController(),
    );
  }
}
