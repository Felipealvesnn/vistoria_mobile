import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/MyDrawer.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/listvistoria.dart';
import 'package:vistoria_mobile/app/modules/vistoria/views/adicionar_vistoria.dart';
import '../controllers/vistoria_controller.dart';

class VistoriaView extends GetView<VistoriaController> {
  const VistoriaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          Get.size.height * 0.14, // Define a altura do AppBar
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
          child: SizedBox(
            height: Get.size.height * 0.14, // Ajusta a altura do AppBar
            child: AppBar(
              title: const Text(
                'Vistoria',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              elevation: 10, // Adiciona a elevação (sombra)
              shadowColor:
                  Colors.black.withOpacity(0.5), // Personaliza a cor da sombra
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(16),
        child: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => VistoriaFormPage());
          },
          label: const Text(
            'Adicionar Vistoria',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          icon: const Icon(Icons.add),
       //   backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.currentPage.value = 1;
          controller.hasMoreVistorias.value = true;
          controller.vistorias.clear();
          await controller.fetchVistorias();
          controller.fetchVistoriasMobileDTO();
        },
        child: Obx(() {
          if (controller.isLoadingVistoriaInicial.value) {
            // Mostra o indicador de carregamento enquanto está carregando
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Carregando vistorias...'),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }

          if (controller.vistorias.isEmpty) {
            // Mostra a mensagem somente após o carregamento estar completo
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Nenhuma vistoria encontrada.',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            );
          }

          // Exibe a lista de vistorias
          return ListVistoria(controller: controller);
        }),
      ),
    );
  }
}


