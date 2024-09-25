import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/vistoria/controllers/vistoria_controller.dart';

class CarAndMotoFieldsWidget extends StatelessWidget {
  final VistoriaController controller = Get.find<VistoriaController>();

  CarAndMotoFieldsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de campos de Carro e Moto com algumas apenas checkbox
    final List<Map<String, String?>> camposCarroMoto = [
      {
        'campo': 'faroisPrincipaisDianteiros',
        'label': 'Farois Principais Dianteiros',
        'obs': 'faroisPrincipaisDianteirosObs'
      },
      {
        'campo': 'retrovisores',
        'label': 'Retrovisores',
        'obs': 'retrovisoresObs'
      },
      {'campo': 'buzina', 'label': 'Buzina', 'obs': 'buzinaObs'},
      {
        'campo': 'lanternasPosicaoTraseira',
        'label': 'Lanternas de Posição Traseira',
        'obs': 'lanternasPosicaoTraseiraObs'
      },
      {
        'campo': 'lanternasFreio',
        'label': 'Lanternas de Freio',
        'obs': 'lanternasFreioObs'
      },
      {
        'campo': 'lanternaPlacaTraseira',
        'label': 'Lanterna da Placa Traseira',
        'obs': 'lanternaPlacaTraseiraObs'
      },
      {'campo': 'pneus', 'label': 'Pneus', 'obs': 'pneusObs'},
      {
        'campo': 'higieneSeguranca',
        'label': 'Higiene e Segurança',
        'obs': 'higieneSegurancaObs'
      },
      {
        'campo': 'bancosHigieneSeguranca',
        'label': 'Bancos - Higiene e Segurança',
        'obs': 'bancosHigieneSegurancaObs'
      },
      {'campo': 'velocimetro', 'label': 'Velocímetro', 'obs': 'velocimetroObs'},
      {'campo': 'tacografo', 'label': 'Tacógrafo', 'obs': 'tacografoObs'},
      {'campo': 'bateria', 'label': 'Bateria', 'obs': 'bateriaObs'},
      {
        'campo': 'docVeiculoProp',
        'label': 'Documento do Veículo Proprietário',
        'obs': 'docVeiculoPropObs'
      },
      {
        'campo': 'motorPartida',
        'label': 'Motor de Partida',
        'obs': 'motorPartidaObs'
      },
      // Campos sem observações
      {'campo': 'requerPrefDiretTributario01', 'label': 'Liberação de Alvará para Licenciamento de Veículo de Aluguel'},
      {'campo': 'requerPrefDiretTributario02', 'label': 'Renovação de Alvará para Licenciamento de Veículo de Aluguel'},
      {'campo': 'requerPrefDiretTributario03', 'label': 'Vistoria de Veículo de Aluguel'},
      {'campo': 'requerPrefDiretTributario04', 'label': 'Transferência'},
      {'campo': 'requerPrefDiretTributario05', 'label': 'Mudança de Placa ou Tarjeta'},
      {'campo': 'requerPrefDiretTributario06', 'label': 'Outros'},
    ];

    return Column(
      children: [
        // Itera sobre a lista de campos, criando os checkboxes para cada campo
        ...camposCarroMoto.map((campo) {
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
              // Verifica se o campo tem observações, se sim, cria o campo de observação
              if (campo['obs'] != null)
                Obx(
                  () => controller.camposMap[campo['campo']] ?? false
                      ? Container(
                          margin: const EdgeInsets.only(top: 16.0),
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
              const Divider(
                  height: 24, thickness: 2), // Espaçamento entre os campos
            ],
          );
        }).toList(),

        // Separador
        const Divider(height: 40, thickness: 2),
      ],
    );
  }
}
