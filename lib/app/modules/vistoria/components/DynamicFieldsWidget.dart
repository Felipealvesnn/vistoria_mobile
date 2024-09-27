import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/vistoria/controllers/vistoria_controller.dart';

class DynamicFieldsWidget extends StatelessWidget {
  final List<Map<String, String?>> campos;
  final VistoriaController controller = Get.find<VistoriaController>();

  // Construtor para receber a lista de campos dinamicamente
  DynamicFieldsWidget({super.key, required this.campos});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Iteração sobre os campos fornecidos
        ...campos.map((campo) {
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
              if (campo['obs'] != null)
                Obx(
                  () => AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: controller.camposMap[campo['campo']] ?? false
                        ? Container(
                            margin: const EdgeInsets.only(top: 16.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: '${campo['label']} Observações',
                                border: const OutlineInputBorder(),
                              ),
                              onChanged: (String? value) {
                                // Atualiza a observação no controlador
                                controller.updateCampo(
                                    campo['obs']!, value ?? '');
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
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
