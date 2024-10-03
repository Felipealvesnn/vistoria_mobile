import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/PdfPreviewPage.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/generatePdf.dart';

class VistoriaDetalhesView extends StatelessWidget {
  final Vistoria vistoria;

  const VistoriaDetalhesView({super.key, required this.vistoria});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String?>> dadosVeiclos = [
      //{"label": "Marca", "value": vistoria.marcaModelo},
      // {"label": "Placa", "value": vistoria.placa},
      {"label": "Chassi", "value": vistoria.chassi},
      {"label": "Ano", "value": vistoria.ano},
      //{"label": "Cor", "value": vistoria.cor},
      {"label": "Tipo", "value": vistoria.tipo},
      //{"label": "KM", "value": vistoria.km.toString()},
    ];
    final List<Map<String, String?>> camposMoto = [
      {
        'label': 'Ruído do Motor',
        'value': vistoria.ruidoMotor == true ? "OK" : "False",
        'Obs':
            vistoria.ruidoMotorObs != null && vistoria.ruidoMotorObs!.isNotEmpty
                ? vistoria.ruidoMotorObs!
                : "Sem observações",
      },
      {
        'label': 'Redutores de Temperatura',
        'value': vistoria.redutoresTemperatura == true ? "OK" : "False",
        'Obs': vistoria.redutoresTemperaturaObs != null &&
                vistoria.redutoresTemperaturaObs!.isNotEmpty
            ? vistoria.redutoresTemperaturaObs!
            : "Sem observações",
      },
      {
        'label': 'Kit de Tração',
        'value': vistoria.kitTracao == true ? "OK" : "False",
        'Obs':
            vistoria.kitTracaoObs != null && vistoria.kitTracaoObs!.isNotEmpty
                ? vistoria.kitTracaoObs!
                : "Sem observações",
      },
      {
        'label': 'Chave de Ignição do Baú',
        'value': vistoria.chavesIgnicaoBau == true ? "OK" : "False",
        'Obs': vistoria.chavesIgnicaoBauObs != null &&
                vistoria.chavesIgnicaoBauObs!.isNotEmpty
            ? vistoria.chavesIgnicaoBauObs!
            : "Sem observações",
      },
      {
        'label': 'Mata Cachorro',
        'value': vistoria.mataCachorro == true ? "OK" : "False",
        'Obs': vistoria.mataCachorroObs != null &&
                vistoria.mataCachorroObs!.isNotEmpty
            ? vistoria.mataCachorroObs!
            : "Sem observações",
      },
      {
        'label': 'Corta Pipa',
        'value': vistoria.cortaPipa == true ? "OK" : "False",
        'Obs':
            vistoria.cortaPipaObs != null && vistoria.cortaPipaObs!.isNotEmpty
                ? vistoria.cortaPipaObs!
                : "Sem observações",
      },
      {
        'label': 'Colete',
        'value': vistoria.colete == true ? "OK" : "False",
        'Obs': vistoria.coleteObs != null && vistoria.coleteObs!.isNotEmpty
            ? vistoria.coleteObs!
            : "Sem observações",
      },
      {
        'label': 'Potência Mínima e Máxima',
        'value': vistoria.potenciaMinimaMaxima == true ? "OK" : "False",
        'Obs': vistoria.potenciaMinimaMaximaObs != null &&
                vistoria.potenciaMinimaMaximaObs!.isNotEmpty
            ? vistoria.potenciaMinimaMaximaObs!
            : "Sem observações",
      },
      {
        'label': 'Capacetes',
        'value': vistoria.capacetes == true ? "OK" : "False",
        'Obs':
            vistoria.capacetesObs != null && vistoria.capacetesObs!.isNotEmpty
                ? vistoria.capacetesObs!
                : "Sem observações",
      },
    ];

    final List<Map<String, String?>> camposCarro = [
      {
        'label': 'Para-choque',
        'value': vistoria.parachoques == true ? "OK" : "False",
        'Obs': vistoria.parachoquesObs != null &&
                vistoria.parachoquesObs!.isNotEmpty
            ? vistoria.parachoquesObs!
            : "Sem observações",
      },
      {
        'label': 'Macaco',
        'value': vistoria.macaco == true ? "OK" : "False",
        'Obs': vistoria.macacoObs != null && vistoria.macacoObs!.isNotEmpty
            ? vistoria.macacoObs!
            : "Sem observações",
      },
      {
        'label': 'Triângulo',
        'value': vistoria.triangulo == true ? "OK" : "False",
        'Obs':
            vistoria.trianguloObs != null && vistoria.trianguloObs!.isNotEmpty
                ? vistoria.trianguloObs!
                : "Sem observações",
      },
      {
        'label': 'Vidros',
        'value': vistoria.vidros == true ? "OK" : "False",
        'Obs': vistoria.vidrosObs != null && vistoria.vidrosObs!.isNotEmpty
            ? vistoria.vidrosObs!
            : "Sem observações",
      },
      {
        'label': 'Limpador Parabrisa',
        'value': vistoria.limpadorParabrisa == true ? "OK" : "False",
        'Obs': vistoria.limpadorParabrisaObs != null &&
                vistoria.limpadorParabrisaObs!.isNotEmpty
            ? vistoria.limpadorParabrisaObs!
            : "Sem observações",
      },
      {
        'label': 'Luz Indicadora Direção Dianteira',
        'value':
            vistoria.luzIndicadoraDirecaoDianteira == true ? "OK" : "False",
        'Obs': vistoria.luzIndicadoraDirecaoDianteiraObs != null &&
                vistoria.luzIndicadoraDirecaoDianteiraObs!.isNotEmpty
            ? vistoria.luzIndicadoraDirecaoDianteiraObs!
            : "Sem observações",
      },
      {
        'label': 'Luz Indicadora Direção Traseira',
        'value': vistoria.luzIndicadoraDirecaoTraseira == true ? "OK" : "False",
        'Obs': vistoria.luzIndicadoraDirecaoTraseiraObs != null &&
                vistoria.luzIndicadoraDirecaoTraseiraObs!.isNotEmpty
            ? vistoria.luzIndicadoraDirecaoTraseiraObs!
            : "Sem observações",
      },
      {
        'label': 'Indicadores Painel',
        'value': vistoria.indicadoresPainel == true ? "OK" : "False",
        'Obs': vistoria.indicadoresPainelObs != null &&
                vistoria.indicadoresPainelObs!.isNotEmpty
            ? vistoria.indicadoresPainelObs!
            : "Sem observações",
      },
      {
        'label': 'Nível de Óleo do Motor',
        'value': vistoria.nivelOleoMotor == true ? "OK" : "False",
        'Obs': vistoria.nivelOleoMotorObs != null &&
                vistoria.nivelOleoMotorObs!.isNotEmpty
            ? vistoria.nivelOleoMotorObs!
            : "Sem observações",
      },
      {
        'label': 'Nível de Fluido de Freio',
        'value': vistoria.nivelFluidoFreio == true ? "OK" : "False",
        'Obs': vistoria.nivelFluidoFreioObs != null &&
                vistoria.nivelFluidoFreioObs!.isNotEmpty
            ? vistoria.nivelFluidoFreioObs!
            : "Sem observações",
      },
      {
        'label': 'Adesivação',
        'value': vistoria.adesivacao == true ? "OK" : "False",
        'Obs':
            vistoria.adesivacaoObs != null && vistoria.adesivacaoObs!.isNotEmpty
                ? vistoria.adesivacaoObs!
                : "Sem observações",
      },
      {
        'label': 'Freio de Serviço',
        'value': vistoria.freioServico == true ? "OK" : "False",
        'Obs': vistoria.freioServicoObs != null &&
                vistoria.freioServicoObs!.isNotEmpty
            ? vistoria.freioServicoObs!
            : "Sem observações",
      },
      {
        'label': 'Freio de Estacionamento',
        'value': vistoria.freioEstacionamento == true ? "OK" : "False",
        'Obs': vistoria.freioEstacionamentoObs != null &&
                vistoria.freioEstacionamentoObs!.isNotEmpty
            ? vistoria.freioEstacionamentoObs!
            : "Sem observações",
      },
      {
        'label': 'Nível de Água',
        'value': vistoria.nivelAgua == true ? "OK" : "False",
        'Obs':
            vistoria.nivelAguaObs != null && vistoria.nivelAguaObs!.isNotEmpty
                ? vistoria.nivelAguaObs!
                : "Sem observações",
      },
      {
        'label': 'Faroletes',
        'value': vistoria.faroletes == true ? "OK" : "False",
        'Obs':
            vistoria.faroletesObs != null && vistoria.faroletesObs!.isNotEmpty
                ? vistoria.faroletesObs!
                : "Sem observações",
      },
      {
        'label': 'Lanternas Direção',
        'value': vistoria.lanternasDirecao == true ? "OK" : "False",
        'Obs': vistoria.lanternasDirecaoObs != null &&
                vistoria.lanternasDirecaoObs!.isNotEmpty
            ? vistoria.lanternasDirecaoObs!
            : "Sem observações",
      },
      {
        'label': 'Lanterna Marcha Ré',
        'value': vistoria.lanternaMarchaRe == true ? "OK" : "False",
        'Obs': vistoria.lanternaMarchaReObs != null &&
                vistoria.lanternaMarchaReObs!.isNotEmpty
            ? vistoria.lanternaMarchaReObs!
            : "Sem observações",
      },
      {
        'label': 'Extintor',
        'value': vistoria.extintor == true ? "OK" : "False",
        'Obs': vistoria.extintorObs != null && vistoria.extintorObs!.isNotEmpty
            ? vistoria.extintorObs!
            : "Sem observações",
      },
      {
        'label': 'Cinto de Segurança',
        'value': vistoria.cintoSeguranca == true ? "OK" : "False",
        'Obs': vistoria.cintoSegurancaObs != null &&
                vistoria.cintoSegurancaObs!.isNotEmpty
            ? vistoria.cintoSegurancaObs!
            : "Sem observações",
      },
      {
        'label': 'Step',
        'value': vistoria.step == true ? "OK" : "False",
        'Obs': vistoria.stepObs != null && vistoria.stepObs!.isNotEmpty
            ? vistoria.stepObs!
            : "Sem observações",
      },
      {
        'label': 'Chave de Roda',
        'value': vistoria.chaveRoda == true ? "OK" : "False",
        'Obs':
            vistoria.chaveRodaObs != null && vistoria.chaveRodaObs!.isNotEmpty
                ? vistoria.chaveRodaObs!
                : "Sem observações",
      },
      {
        'label': 'Cilindro de Gás',
        'value': vistoria.cinlindroGas == true ? "OK" : "False",
        'Obs': vistoria.cilindroGasObs != null &&
                vistoria.cilindroGasObs!.isNotEmpty
            ? vistoria.cilindroGasObs!
            : "Sem observações",
      },
    ];

    // Campos compartilhados entre carro e moto
    final List<Map<String, String?>> camposCarroMoto = [
      {
        'label': 'Faróis Principais Dianteiros',
        'value': vistoria.faroisPrincipaisDianteiros == true ? "OK" : "False",
        'Obs': vistoria.faroisPrincipaisDianteirosObs != null &&
                vistoria.faroisPrincipaisDianteirosObs!.isNotEmpty
            ? vistoria.faroisPrincipaisDianteirosObs!
            : "Sem observações",
      },
      {
        'label': 'Retrovisores',
        'value': vistoria.retrovisores == true ? "OK" : "False",
        'Obs': vistoria.retrovisoresObs != null &&
                vistoria.retrovisoresObs!.isNotEmpty
            ? vistoria.retrovisoresObs!
            : "Sem observações",
      },
      {
        'label': 'Buzina',
        'value': vistoria.buzina == true ? "OK" : "False",
        'Obs': vistoria.buzinaObs != null && vistoria.buzinaObs!.isNotEmpty
            ? vistoria.buzinaObs!
            : "Sem observações",
      },
      {
        'label': 'Lanternas de Posição Traseira',
        'value': vistoria.lanternasPosicaoTraseira == true ? "OK" : "False",
        'Obs': vistoria.lanternasPosicaoTraseiraObs != null &&
                vistoria.lanternasPosicaoTraseiraObs!.isNotEmpty
            ? vistoria.lanternasPosicaoTraseiraObs!
            : "Sem observações",
      },
      {
        'label': 'Lanternas de Freio',
        'value': vistoria.lanternasFreio == true ? "OK" : "False",
        'Obs': vistoria.lanternasFreioObs != null &&
                vistoria.lanternasFreioObs!.isNotEmpty
            ? vistoria.lanternasFreioObs!
            : "Sem observações",
      },
      {
        'label': 'Lanterna da Placa Traseira',
        'value': vistoria.lanternaPlacaTraseira == true ? "OK" : "False",
        'Obs': vistoria.lanternaPlacaTraseiraObs != null &&
                vistoria.lanternaPlacaTraseiraObs!.isNotEmpty
            ? vistoria.lanternaPlacaTraseiraObs!
            : "Sem observações",
      },
      {
        'label': 'Pneus',
        'value': vistoria.pneus == true ? "OK" : "False",
        'Obs': vistoria.pneusObs != null && vistoria.pneusObs!.isNotEmpty
            ? vistoria.pneusObs!
            : "Sem observações",
      },
      {
        'label': 'Higiene e Segurança',
        'value': vistoria.higieneSeguranca == true ? "OK" : "False",
        'Obs': vistoria.higieneSegurancaObs != null &&
                vistoria.higieneSegurancaObs!.isNotEmpty
            ? vistoria.higieneSegurancaObs!
            : "Sem observações",
      },
      {
        'label': 'Bancos - Higiene e Segurança',
        'value': vistoria.bancosHigieneSeguranca == true ? "OK" : "False",
        'Obs': vistoria.bancosHigieneSegurancaObs != null &&
                vistoria.bancosHigieneSegurancaObs!.isNotEmpty
            ? vistoria.bancosHigieneSegurancaObs!
            : "Sem observações",
      },
      {
        'label': 'Velocímetro',
        'value': vistoria.velocimetro == true ? "OK" : "False",
        'Obs': vistoria.velocimetroObs != null &&
                vistoria.velocimetroObs!.isNotEmpty
            ? vistoria.velocimetroObs!
            : "Sem observações",
      },
      {
        'label': 'Tacógrafo',
        'value': vistoria.tacografo == true ? "OK" : "False",
        'Obs':
            vistoria.tacografoObs != null && vistoria.tacografoObs!.isNotEmpty
                ? vistoria.tacografoObs!
                : "Sem observações",
      },
      {
        'label': 'Bateria',
        'value': vistoria.bateria == true ? "OK" : "False",
        'Obs': vistoria.bateriaObs != null && vistoria.bateriaObs!.isNotEmpty
            ? vistoria.bateriaObs!
            : "Sem observações",
      },
      {
        'label': 'Documento do Veículo Proprietário',
        'value': vistoria.docVeiculoProp == true ? "OK" : "False",
        'Obs': vistoria.docVeiculoPropObs != null &&
                vistoria.docVeiculoPropObs!.isNotEmpty
            ? vistoria.docVeiculoPropObs!
            : "Sem observações",
      },
      {
        'label': 'Motor de Partida',
        'value': vistoria.motorPartida == true ? "OK" : "False",
        'Obs': vistoria.motorPartidaObs != null &&
                vistoria.motorPartidaObs!.isNotEmpty
            ? vistoria.motorPartidaObs!
            : "Sem observações",
      },
      {
        'label': 'observacao',
        'value': vistoria.observacao != null && vistoria.observacao!.isNotEmpty
            ? vistoria.observacao!
            : "False",
        'Obs': vistoria.observacao != null && vistoria.observacao!.isNotEmpty
            ? vistoria.observacao!
            : "Sem observações",
      },
      // Campos sem observações
      {
        'label': 'Liberação de Alvará para Licenciamento de Veículo de Aluguel',
        'value': vistoria.requerPrefDiretTributario01 == true ? "OK" : "False",
        'Obs': ''
      },
      {
        'label': 'Renovação de Alvará para Licenciamento de Veículo de Aluguel',
        'value': vistoria.requerPrefDiretTributario02 == true ? "OK" : "False",
        'Obs': ''
      },
      {
        'label': 'Vistoria de Veículo de Aluguel',
        'value': vistoria.requerPrefDiretTributario03 == true ? "OK" : "False",
        'Obs': ''
      },
      {
        'label': 'Transferência',
        'value': vistoria.requerPrefDiretTributario04 == true ? "OK" : "False",
        'Obs': ''
      },
      {
        'label': 'Mudança de Placa ou Tarjeta',
        'value': vistoria.requerPrefDiretTributario05 == true ? "OK" : "False",
        'Obs': ''
      },
      {
        'label': 'Outros',
        'value': vistoria.requerPrefDiretTributario06 == true ? "OK" : "False",
        'Obs': ''
      },
    ];

    // Adicione condicionalmente o campo se `statusVistoria` não for "APROVADO"
    if (vistoria.statusVistoria != "APROVADO") {
      camposCarroMoto.add({
        'label': 'Observação Reprovado',
        'value': vistoria.statusVistoria == "APROVADO" ? "OK" : "False",
        'Obs': vistoria.reprovadoObs ?? 'Sem observações',
      });
    }

    // (Outras variáveis do seu código para camposMoto, camposCarro, camposCarroMoto...)

    // Determina os campos a serem exibidos com base no tipo de veículo
    List<Map<String, String?>> camposVistoria = [];

    if (vistoria.tipo == "MOTOCICLETA" || vistoria.tipo == "MOTONETA") {
      camposVistoria = [...dadosVeiclos, ...camposMoto, ...camposCarroMoto];
    } else {
      camposVistoria = [...dadosVeiclos, ...camposCarro, ...camposCarroMoto];
    }

    // Top Content (com as informações da vistoria e a imagem de fundo)
    final topContent = Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: (vistoria.tipo == "MOTOCICLETA" ||
                      vistoria.tipo == "MOTONETA")
                  ? const AssetImage("assets/images/FAN-LATERAL_4.webp")
                  : const AssetImage(
                      "assets/images/onix-hatch-showroom-1920x960.webp"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(58, 66, 86, .9),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 50.0),
                  Text(
                    vistoria.placa ?? "Placa False",
                    style: const TextStyle(color: Colors.white, fontSize: 40.0),
                  ),
                  const Divider(thickness: 2),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Cor: ${vistoria.cor ?? "False"}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Modelo: ${vistoria.marcaModelo ?? "False"}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Realizada: ${DateFormat('dd/MM/yyyy HH:mm').format(vistoria.dataVistoria!) ?? "False"}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Get.theme.primaryColor
                .withOpacity(0.15), // const Color.fromRGBO(58, 66, 86, .9),
          ),
        ),
        Positioned(
          left: 15,
          top: 30,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ],
    );

    final readButton = Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton.icon(
        onPressed: () {
          Get.to(() => PdfPreviewPage(ocorrencia: vistoria));
        },
        icon: const Icon(Icons.download),
        label: const Text("Baixar PDF", style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
            //backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
            ),
      ),
    );

    // Uso do CustomScrollView com Slivers
    return Scaffold(
      body: Column(
        children: [
          // Top content fixo
          topContent,
          // SliverList que será rolada
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.info_outline,
                              //  color: Colors.green,
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                    mouseCursor: MouseCursor
                                        .uncontrolled, // Remove o cursor de hover

                                    hoverColor: Colors
                                        .transparent, // Remove o efeito de hover
                                    title:
                                        Text(camposVistoria[index]["label"]!),
                                    value:
                                        camposVistoria[index]["value"] == "OK",
                                    onChanged: (bool? value) {},
                                  ),
                                ),
                              ],
                            ),
                            subtitle: camposVistoria[index].containsKey('Obs')
                                ? Text(
                                    camposVistoria[index]['Obs']!,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  )
                                : Text(
                                    camposVistoria[index]['value']!,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                          ),
                          // Adicionando o divisor entre os itens
                          if (index !=
                              camposVistoria.length -
                                  1) // Para não mostrar divisor após o último item
                            const Divider(
                              //color: Colors.grey,
                              thickness: 1,
                            ),
                        ],
                      );
                    },
                    childCount: camposVistoria.length,
                  ),
                ),
              ],
            ),
          ),
          // Bottom content fixo (botão)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: readButton,
          ),
        ],
      ),
    );
  }
}
