import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/listvistoria.dart';
import 'package:vistoria_mobile/app/modules/vistoria/views/adicionar_vistoria.dart';
import '../controllers/vistoria_controller.dart';

class VistoriaView extends GetView<VistoriaController> {
  const VistoriaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            Get.size.height * 0.14), // Define a altura do AppBar
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
          child: AppBar(
            title: const Text(
              'Vistoria ',
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
      floatingActionButton: Container(
        margin:
            const EdgeInsets.all(16), // Margem para afastar o botão das bordas
        child: FloatingActionButton.extended(
          onPressed: () {
            // Aqui você pode adicionar uma nova vistoria
            Get.to(() =>VistoriaFormPage());
          },
          label: const Text(
            'Adicionar Vistoria',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          icon: const Icon(Icons.add), // Ícone antes do texto
          backgroundColor: Colors.green, // Cor de fundo
          foregroundColor: Colors.white, // Cor do texto e ícone
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Bordas arredondadas
          ),
          elevation: 6, // Sombra do botão
        ),
      ),
      body: Obx(() {
        // Verifica se a lista de vistorias está vazia
        if (controller.vistorias.isEmpty) {
          return const Center(
            child: Text(
              'Nenhuma vistoria encontrada.',
              style: TextStyle(fontSize: 20),
            ),
          );
        }

        // Exibe a lista de vistorias
        return ListVistoria(controller: controller);
      }),
    );
  }
}
