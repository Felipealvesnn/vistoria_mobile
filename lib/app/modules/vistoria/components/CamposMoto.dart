import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/DynamicFieldsWidget.dart';
import 'package:vistoria_mobile/app/modules/vistoria/controllers/vistoria_controller.dart';

class MotoFieldsWidget extends StatelessWidget {
  final VistoriaController controller = Get.find<VistoriaController>();

  MotoFieldsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> camposMoto = [
      {'campo': 'ruidoMotor', 'label': 'Ruído do Motor', 'obs': 'ruidoMotorObs'},
      {'campo': 'redutoresTemperatura', 'label': 'Redutores de Temperatura', 'obs': 'redutoresTemperaturaObs'},
      {'campo': 'kitTracao', 'label': 'Kit de Tração', 'obs': 'kitTracaoObs'},
      {'campo': 'chavesIgnicaoBau', 'label': 'Chave de Ignição do Baú', 'obs': 'chavesIgnicaoBauObs'},
      {'campo': 'mataCachorro', 'label': 'Mata Cachorro', 'obs': 'mataCachorroObs'},
      {'campo': 'cortaPipa', 'label': 'Corta Pipa', 'obs': 'cortaPipaObs'},
      {'campo': 'colete', 'label': 'Colete', 'obs': 'coleteObs'},
      {'campo': 'potenciaMinimaMaxima', 'label': 'Potência Mínima e Máxima', 'obs': 'potenciaMinimaMaximaObs'},
      {'campo': 'capacetes', 'label': 'Capacetes', 'obs': 'capacetesObs'},
    ];

   return DynamicFieldsWidget(campos: camposMoto);
  }
}
