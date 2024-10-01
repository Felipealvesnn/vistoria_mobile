import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/data/global/constants.dart';
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
      // Inicializa o campo como "true" para os que devem ser marcados por padrão
      bool defaultValue = _shouldCheckField(campo['campo']!);

      // Verifica se o campo já existe no mapa antes de inicializar
      if (!controller.camposMap.containsKey(campo['campo'])) {
        controller.updateCampo(campo['campo']!, defaultValue);
      }

      // Inicializa o campo de observações como string vazia
      if (campo['obs'] != null &&
          !controller.camposMap.containsKey(campo['obs'])) {
        controller.updateCampo(campo['obs']!, '');
      }
    }
  }

  bool _shouldCheckField(String campo) {
    // Lista de campos que devem aparecer marcados por padrão
    const List<String> camposMarcados = [
      'capacetes',
      'faroisPrincipaisDianteiros',
      'lanternasPosicaoTraseira',
      'lanternasFreio',
      'lanternaPlacaTraseira',
      'pneus',
      // Adicione outros campos que você deseja marcar como 'true' por padrão
    ];

    return camposMarcados.contains(campo);
  }

  @override
  @override
Widget build(BuildContext context) {
  return Column(
    children: [
      // Iteração sobre os campos fornecidos
      ...widget.campos.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, String?> campo = entry.value;

        // Alterna entre cinza claro e branco para o efeito zebragem
        Color backgroundColor = (index % 2 == 0) ? CinzaCalro : Colors.white;

        return Container(
          color: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
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
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
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
                            margin: const EdgeInsets.only(top: 8.0),
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
            ],
          ),
        );
      }).toList(),
    ],
  );
}
}
