import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/vistoria/controllers/vistoria_controller.dart';

class CarFieldsWidget extends StatelessWidget {
  final VistoriaController controller = Get.find<VistoriaController>();

  CarFieldsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de campos de Carro com suas respectivas observações
    final List<Map<String, String>> camposCarro = [
      {'campo': 'parachoques', 'label': 'Para-choque', 'obs': 'parachoquesObs'},
      {'campo': 'macaco', 'label': 'Macaco', 'obs': 'macacoObs'},
      {'campo': 'triangulo', 'label': 'Triângulo', 'obs': 'trianguloObs'},
      {'campo': 'vidros', 'label': 'Vidros', 'obs': 'vidrosObs'},
      {
        'campo': 'luzIndicadoraDirecaoDianteira',
        'label': 'Luz Indicadora Direção Dianteira',
        'obs': 'luzIndicadoraDirecaoDianteiraObs'
      },
      {
        'campo': 'luzIndicadoraDirecaoTraseira',
        'label': 'Luz Indicadora Direção Traseira',
        'obs': 'luzIndicadoraDirecaoTraseiraObs'
      },
      {
        'campo': 'indicadoresPainel',
        'label': 'Indicadores Painel',
        'obs': 'indicadoresPainelObs'
      },
      {
        'campo': 'nivelOleoMotor',
        'label': 'Nível de Óleo do Motor',
        'obs': 'nivelOleoMotorObs'
      },
      {
        'campo': 'nivelFluidoFreio',
        'label': 'Nível de Fluido de Freio',
        'obs': 'nivelFluidoFreioObs'
      },
      {'campo': 'adesivacao', 'label': 'Adesivação', 'obs': 'adesivacaoObs'},
      {
        'campo': 'freioServico',
        'label': 'Freio de Serviço',
        'obs': 'freioServicoObs'
      },
      {
        'campo': 'freioEstacionamento',
        'label': 'Freio de Estacionamento',
        'obs': 'freioEstacionamentoObs'
      },
      {'campo': 'nivelAgua', 'label': 'Nível de Água', 'obs': 'nivelAguaObs'},
    ];

    return Column(
      children: [
        // Iteração sobre os campos de carro
        ...camposCarro.map((campo) {
          return Column(
            children: [
              // Checkbox para o campo
              Obx(
                () => CheckboxListTile(
                  title: Text(campo['label']!),
                  value: controller.camposMap[campo['campo']] ?? false,
                  onChanged: (bool? value) {
                    // Atualiza o valor do checkbox no controlador
                    controller.updateCampo(campo['campo']!, value ?? false);
                  },
                ),
              ),
              // Campo de observação que aparece quando o checkbox é marcado
              Obx(
                () => controller.camposMap[campo['campo']] ?? false
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
