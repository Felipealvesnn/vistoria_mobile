import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/DynamicFieldsWidget.dart';
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
        'campo': 'limpadorParabrisa',
        'label': 'limpador Parabrisa',
        'obs': 'limpadorParabrisaObs'
      },
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
      {'campo': 'faroletes', 'label': 'Faroletes', 'obs': 'faroletesObs'},
      {
        'campo': 'lanternasDirecao',
        'label': 'Lanternas Direção',
        'obs': 'lanternasDirecaoObs'
      },
      {
        'campo': 'lanternaMarchaRe',
        'label': 'Lanterna Marcha Ré',
        'obs': 'lanternaMarchaReObs'
      },
      {'campo': 'extintor', 'label': 'Extintor', 'obs': 'extintorObs'},
      {
        'campo': 'cintoSeguranca',
        'label': 'Cinto de Segurança',
        'obs': 'cintoSegurancaObs'
      },
      {'campo': 'step', 'label': 'Step', 'obs': 'stepObs'},
      {'campo': 'chaveRoda', 'label': 'Chave de Roda', 'obs': 'chaveRodaObs'},
      {
        'campo': 'cinlindroGas',
        'label': 'Cilindro de Gás',
        'obs': 'cilindroGasObs'
      },
    ];

    return DynamicFieldsWidget(campos: camposCarro);
  }
}
