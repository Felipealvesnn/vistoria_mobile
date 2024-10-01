import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/configuracoes_controller.dart';

class ConfiguracoesView extends GetView<ConfiguracoesController> {
  const ConfiguracoesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22,),
            child: Card(
              child: Row(
                children: [
                  const Text(
                    'Usar Biometria',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 20),
                  Obx(
                    () => Switch(
                      value: controller.isBiometriaEnabled.value,
                      onChanged: (bool value) {
                        controller.isBiometriaEnabled.value = value;
                        // Adicione aqui a lógica para ativar/desativar biometria
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
