import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:vistoria_mobile/app/modules/vistoria/controllers/vistoria_controller.dart';

class DadosVeiculoWidget extends StatelessWidget {
  final VistoriaController controller = Get.find<VistoriaController>();

  DadosVeiculoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de campos de Dados do Veículo com suas respectivas observações
    final List<Map<String, dynamic>> camposVeiculo = [
      {'controller': controller.chassiController, 'label': 'Chassi', 'obs': 'chassiObs'},
      {'controller': controller.marcaModeloController, 'label': 'Marca/Modelo', 'obs': 'marcaModeloObs'},
      {'controller': controller.anoController, 'label': 'Ano', 'obs': 'anoObs'},
      {'controller': controller.corController, 'label': 'Cor', 'obs': 'corObs'},
      {'controller': controller.tipoVeiculoController, 'label': 'Tipo de Veículo', 'obs': 'tipoVeiculoObs'},
      {'controller': controller.kmController, 'label': 'KM', 'obs': 'kmObs'},
    ];

    return Column(
      children: [
        // Iteração sobre os campos de dados do veículo
        ...camposVeiculo.map((campo) {
          return Column(
            children: [
              // Campo de texto com controlador
              TextFormField(
                controller: campo['controller'],
                decoration: InputDecoration(
                  labelText: campo['label'],
                  border: const OutlineInputBorder(),
                ),
                onChanged: (String? value) {
                  // Atualiza o valor do campo no controlador
                  controller.updateCampo(campo['obs'], value ?? '');
                },
              ),
              // Campo de observação, se necessário
              Obx(
                () => controller.camposMap[campo['obs']] != null
                    ? Container(
                        margin: const EdgeInsets.only(top: 16.0),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: '${campo['label']} Observações',
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            // Atualiza a observação no controlador
                            controller.updateCampo(campo['obs'], value ?? '');
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              // Espaçamento entre os campos
              const Divider(height: 24, thickness: 2),
            ],
          );
        }).toList(),
      ],
    );
  }
}
