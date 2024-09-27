import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/vistoria/controllers/vistoria_controller.dart';
import 'package:flutter/scheduler.dart';

class DynamicFieldsWidget extends StatefulWidget {
  final List<Map<String, String?>> campos;

  const DynamicFieldsWidget({super.key, required this.campos});

  @override
  _DynamicFieldsWidgetState createState() => _DynamicFieldsWidgetState();
}

class _DynamicFieldsWidgetState extends State<DynamicFieldsWidget> {
  final VistoriaController controller = Get.find<VistoriaController>();

  @override
  void initState() {
    super.initState();
    // Adiciona a inicialização após o build
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _initializeCampos();
    });
  }
  

  void _initializeCampos() {
    // Inicializa os campos fora do build
    for (var campo in widget.campos) {
      if (!controller.camposMap.containsKey(campo['campo'])) {
        controller.updateCampo(campo['campo']!, false);
      }
      // Inicializa o campo de observações como string vazia
      if (campo['obs'] != null && !controller.camposMap.containsKey(campo['obs'])) {
        controller.updateCampo(campo['obs']!, '');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Iteração sobre os campos fornecidos
        ...widget.campos.map((campo) {
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
                    child: controller.camposMap[campo['campo']] == true
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
