import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/vistoria/controllers/vistoria_controller.dart';

class DadosVeiculoWidget extends StatelessWidget {
  final VistoriaController controller = Get.find<VistoriaController>();

  DadosVeiculoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de campos de Dados do Veículo com suas respectivas observações
    final List<Map<String, String>> camposVeiculo = [
      {'campo': 'chassi', 'label': 'Chassi', 'obs': 'chassiObs'},
      {'campo': 'marcaModelo', 'label': 'Marca/Modelo', 'obs': 'marcaModeloObs'},
      {'campo': 'ano', 'label': 'Ano', 'obs': 'anoObs'},
      {'campo': 'cor', 'label': 'Cor', 'obs': 'corObs'},
      {'campo': 'tipoVeiculo', 'label': 'Tipo de Veículo', 'obs': 'tipoVeiculoObs'},
      {'campo': 'km', 'label': 'KM', 'obs': 'kmObs'},
    ];

    return Column(
      children: [
        // Iteração sobre os campos de dados do veículo
        ...camposVeiculo.map((campo) {
          return Column(
            children: [
              // Campo de texto (ao invés de checkbox)
              // Obx(
              //   () => 
                TextFormField(
                  decoration: InputDecoration(
                    labelText: campo['label']!,
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (String? value) {
                    // Atualiza o valor do campo no controlador
                    controller.updateCampo(campo['campo']!, value ?? '');
                  },
                ),
              //),
              // Campo de observação, se necessário
              Obx(
                () => controller.camposMap[campo['campo']] != null
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
                            controller.updateCampo(campo['obs']!, value ?? '');
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
