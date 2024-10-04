import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/PdfPreviewPage.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/WidgetFotoDetalhes.dart';
import 'package:vistoria_mobile/app/modules/vistoria/controllers/vistoria_controller.dart';

class VistoriaDetalhesView extends StatefulWidget {
  final Vistoria vistoria;

  const VistoriaDetalhesView({super.key, required this.vistoria});

  @override
  State<VistoriaDetalhesView> createState() => _VistoriaDetalhesViewState();
}

class _VistoriaDetalhesViewState extends State<VistoriaDetalhesView> {
  VistoriaController controller = Get.find<VistoriaController>();
  Future<void> _fetchImages() async {
    List<FotosVistorium> imagens =
        await controller.GetimagensVistoria(widget.vistoria.vistoriaId!);
    if (imagens.isNotEmpty) {
      setState(() {
        widget.vistoria.FotosVistoria = imagens;
      });
    }
  }

  @override
  void initState() {
    _fetchImages();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String?>> dadosVeiclos = [
      //{"label": "Marca", "value": vistoria.marcaModelo},
      // {"label": "Placa", "value": vistoria.placa},
      {"label": "Chassi", "value": widget.vistoria.chassi},
      {"label": "Ano", "value": widget.vistoria.ano},
      //{"label": "Cor", "value": vistoria.cor},
      {"label": "Tipo", "value": widget.vistoria.tipo},
      //{"label": "KM", "value": vistoria.km.toString()},
    ];
    final List<Map<String, String?>> camposMoto = [
      {
        'label': 'Ruído do Motor',
        'value': widget.vistoria.ruidoMotor == true ? "OK" : "False",
        'Obs': widget.vistoria.ruidoMotorObs != null &&
                widget.vistoria.ruidoMotorObs!.isNotEmpty
            ? widget.vistoria.ruidoMotorObs!
            : "Sem observações",
      },
      {
        'label': 'Redutores de Temperatura',
        'value': widget.vistoria.redutoresTemperatura == true ? "OK" : "False",
        'Obs': widget.vistoria.redutoresTemperaturaObs != null &&
                widget.vistoria.redutoresTemperaturaObs!.isNotEmpty
            ? widget.vistoria.redutoresTemperaturaObs!
            : "Sem observações",
      },
      {
        'label': 'Kit de Tração',
        'value': widget.vistoria.kitTracao == true ? "OK" : "False",
        'Obs': widget.vistoria.kitTracaoObs != null &&
                widget.vistoria.kitTracaoObs!.isNotEmpty
            ? widget.vistoria.kitTracaoObs!
            : "Sem observações",
      },
      {
        'label': 'Chave de Ignição do Baú',
        'value': widget.vistoria.chavesIgnicaoBau == true ? "OK" : "False",
        'Obs': widget.vistoria.chavesIgnicaoBauObs != null &&
                widget.vistoria.chavesIgnicaoBauObs!.isNotEmpty
            ? widget.vistoria.chavesIgnicaoBauObs!
            : "Sem observações",
      },
      {
        'label': 'Mata Cachorro',
        'value': widget.vistoria.mataCachorro == true ? "OK" : "False",
        'Obs': widget.vistoria.mataCachorroObs != null &&
                widget.vistoria.mataCachorroObs!.isNotEmpty
            ? widget.vistoria.mataCachorroObs!
            : "Sem observações",
      },
      {
        'label': 'Corta Pipa',
        'value': widget.vistoria.cortaPipa == true ? "OK" : "False",
        'Obs': widget.vistoria.cortaPipaObs != null &&
                widget.vistoria.cortaPipaObs!.isNotEmpty
            ? widget.vistoria.cortaPipaObs!
            : "Sem observações",
      },
      {
        'label': 'Colete',
        'value': widget.vistoria.colete == true ? "OK" : "False",
        'Obs': widget.vistoria.coleteObs != null &&
                widget.vistoria.coleteObs!.isNotEmpty
            ? widget.vistoria.coleteObs!
            : "Sem observações",
      },
      {
        'label': 'Potência Mínima e Máxima',
        'value': widget.vistoria.potenciaMinimaMaxima == true ? "OK" : "False",
        'Obs': widget.vistoria.potenciaMinimaMaximaObs != null &&
                widget.vistoria.potenciaMinimaMaximaObs!.isNotEmpty
            ? widget.vistoria.potenciaMinimaMaximaObs!
            : "Sem observações",
      },
      {
        'label': 'Capacetes',
        'value': widget.vistoria.capacetes == true ? "OK" : "False",
        'Obs': widget.vistoria.capacetesObs != null &&
                widget.vistoria.capacetesObs!.isNotEmpty
            ? widget.vistoria.capacetesObs!
            : "Sem observações",
      },
    ];

    final List<Map<String, String?>> camposCarro = [
      {
        'label': 'Para-choque',
        'value': widget.vistoria.parachoques == true ? "OK" : "False",
        'Obs': widget.vistoria.parachoquesObs != null &&
                widget.vistoria.parachoquesObs!.isNotEmpty
            ? widget.vistoria.parachoquesObs!
            : "Sem observações",
      },
      {
        'label': 'Macaco',
        'value': widget.vistoria.macaco == true ? "OK" : "False",
        'Obs': widget.vistoria.macacoObs != null &&
                widget.vistoria.macacoObs!.isNotEmpty
            ? widget.vistoria.macacoObs!
            : "Sem observações",
      },
      {
        'label': 'Triângulo',
        'value': widget.vistoria.triangulo == true ? "OK" : "False",
        'Obs': widget.vistoria.trianguloObs != null &&
                widget.vistoria.trianguloObs!.isNotEmpty
            ? widget.vistoria.trianguloObs!
            : "Sem observações",
      },
      {
        'label': 'Vidros',
        'value': widget.vistoria.vidros == true ? "OK" : "False",
        'Obs': widget.vistoria.vidrosObs != null &&
                widget.vistoria.vidrosObs!.isNotEmpty
            ? widget.vistoria.vidrosObs!
            : "Sem observações",
      },
      {
        'label': 'Limpador Parabrisa',
        'value': widget.vistoria.limpadorParabrisa == true ? "OK" : "False",
        'Obs': widget.vistoria.limpadorParabrisaObs != null &&
                widget.vistoria.limpadorParabrisaObs!.isNotEmpty
            ? widget.vistoria.limpadorParabrisaObs!
            : "Sem observações",
      },
      {
        'label': 'Luz Indicadora Direção Dianteira',
        'value': widget.vistoria.luzIndicadoraDirecaoDianteira == true
            ? "OK"
            : "False",
        'Obs': widget.vistoria.luzIndicadoraDirecaoDianteiraObs != null &&
                widget.vistoria.luzIndicadoraDirecaoDianteiraObs!.isNotEmpty
            ? widget.vistoria.luzIndicadoraDirecaoDianteiraObs!
            : "Sem observações",
      },
      {
        'label': 'Luz Indicadora Direção Traseira',
        'value': widget.vistoria.luzIndicadoraDirecaoTraseira == true
            ? "OK"
            : "False",
        'Obs': widget.vistoria.luzIndicadoraDirecaoTraseiraObs != null &&
                widget.vistoria.luzIndicadoraDirecaoTraseiraObs!.isNotEmpty
            ? widget.vistoria.luzIndicadoraDirecaoTraseiraObs!
            : "Sem observações",
      },
      {
        'label': 'Indicadores Painel',
        'value': widget.vistoria.indicadoresPainel == true ? "OK" : "False",
        'Obs': widget.vistoria.indicadoresPainelObs != null &&
                widget.vistoria.indicadoresPainelObs!.isNotEmpty
            ? widget.vistoria.indicadoresPainelObs!
            : "Sem observações",
      },
      {
        'label': 'Nível de Óleo do Motor',
        'value': widget.vistoria.nivelOleoMotor == true ? "OK" : "False",
        'Obs': widget.vistoria.nivelOleoMotorObs != null &&
                widget.vistoria.nivelOleoMotorObs!.isNotEmpty
            ? widget.vistoria.nivelOleoMotorObs!
            : "Sem observações",
      },
      {
        'label': 'Nível de Fluido de Freio',
        'value': widget.vistoria.nivelFluidoFreio == true ? "OK" : "False",
        'Obs': widget.vistoria.nivelFluidoFreioObs != null &&
                widget.vistoria.nivelFluidoFreioObs!.isNotEmpty
            ? widget.vistoria.nivelFluidoFreioObs!
            : "Sem observações",
      },
      {
        'label': 'Adesivação',
        'value': widget.vistoria.adesivacao == true ? "OK" : "False",
        'Obs': widget.vistoria.adesivacaoObs != null &&
                widget.vistoria.adesivacaoObs!.isNotEmpty
            ? widget.vistoria.adesivacaoObs!
            : "Sem observações",
      },
      {
        'label': 'Freio de Serviço',
        'value': widget.vistoria.freioServico == true ? "OK" : "False",
        'Obs': widget.vistoria.freioServicoObs != null &&
                widget.vistoria.freioServicoObs!.isNotEmpty
            ? widget.vistoria.freioServicoObs!
            : "Sem observações",
      },
      {
        'label': 'Freio de Estacionamento',
        'value': widget.vistoria.freioEstacionamento == true ? "OK" : "False",
        'Obs': widget.vistoria.freioEstacionamentoObs != null &&
                widget.vistoria.freioEstacionamentoObs!.isNotEmpty
            ? widget.vistoria.freioEstacionamentoObs!
            : "Sem observações",
      },
      {
        'label': 'Nível de Água',
        'value': widget.vistoria.nivelAgua == true ? "OK" : "False",
        'Obs': widget.vistoria.nivelAguaObs != null &&
                widget.vistoria.nivelAguaObs!.isNotEmpty
            ? widget.vistoria.nivelAguaObs!
            : "Sem observações",
      },
      {
        'label': 'Faroletes',
        'value': widget.vistoria.faroletes == true ? "OK" : "False",
        'Obs': widget.vistoria.faroletesObs != null &&
                widget.vistoria.faroletesObs!.isNotEmpty
            ? widget.vistoria.faroletesObs!
            : "Sem observações",
      },
      {
        'label': 'Lanternas Direção',
        'value': widget.vistoria.lanternasDirecao == true ? "OK" : "False",
        'Obs': widget.vistoria.lanternasDirecaoObs != null &&
                widget.vistoria.lanternasDirecaoObs!.isNotEmpty
            ? widget.vistoria.lanternasDirecaoObs!
            : "Sem observações",
      },
      {
        'label': 'Lanterna Marcha Ré',
        'value': widget.vistoria.lanternaMarchaRe == true ? "OK" : "False",
        'Obs': widget.vistoria.lanternaMarchaReObs != null &&
                widget.vistoria.lanternaMarchaReObs!.isNotEmpty
            ? widget.vistoria.lanternaMarchaReObs!
            : "Sem observações",
      },
      {
        'label': 'Extintor',
        'value': widget.vistoria.extintor == true ? "OK" : "False",
        'Obs': widget.vistoria.extintorObs != null &&
                widget.vistoria.extintorObs!.isNotEmpty
            ? widget.vistoria.extintorObs!
            : "Sem observações",
      },
      {
        'label': 'Cinto de Segurança',
        'value': widget.vistoria.cintoSeguranca == true ? "OK" : "False",
        'Obs': widget.vistoria.cintoSegurancaObs != null &&
                widget.vistoria.cintoSegurancaObs!.isNotEmpty
            ? widget.vistoria.cintoSegurancaObs!
            : "Sem observações",
      },
      {
        'label': 'Step',
        'value': widget.vistoria.step == true ? "OK" : "False",
        'Obs': widget.vistoria.stepObs != null &&
                widget.vistoria.stepObs!.isNotEmpty
            ? widget.vistoria.stepObs!
            : "Sem observações",
      },
      {
        'label': 'Chave de Roda',
        'value': widget.vistoria.chaveRoda == true ? "OK" : "False",
        'Obs': widget.vistoria.chaveRodaObs != null &&
                widget.vistoria.chaveRodaObs!.isNotEmpty
            ? widget.vistoria.chaveRodaObs!
            : "Sem observações",
      },
      {
        'label': 'Cilindro de Gás',
        'value': widget.vistoria.cinlindroGas == true ? "OK" : "False",
        'Obs': widget.vistoria.cilindroGasObs != null &&
                widget.vistoria.cilindroGasObs!.isNotEmpty
            ? widget.vistoria.cilindroGasObs!
            : "Sem observações",
      },
    ];

    // Campos compartilhados entre carro e moto
    final List<Map<String, String?>> camposCarroMoto = [
      {
        'label': 'Faróis Principais Dianteiros',
        'value':
            widget.vistoria.faroisPrincipaisDianteiros == true ? "OK" : "False",
        'Obs': widget.vistoria.faroisPrincipaisDianteirosObs != null &&
                widget.vistoria.faroisPrincipaisDianteirosObs!.isNotEmpty
            ? widget.vistoria.faroisPrincipaisDianteirosObs!
            : "Sem observações",
      },
      {
        'label': 'Retrovisores',
        'value': widget.vistoria.retrovisores == true ? "OK" : "False",
        'Obs': widget.vistoria.retrovisoresObs != null &&
                widget.vistoria.retrovisoresObs!.isNotEmpty
            ? widget.vistoria.retrovisoresObs!
            : "Sem observações",
      },
      {
        'label': 'Buzina',
        'value': widget.vistoria.buzina == true ? "OK" : "False",
        'Obs': widget.vistoria.buzinaObs != null &&
                widget.vistoria.buzinaObs!.isNotEmpty
            ? widget.vistoria.buzinaObs!
            : "Sem observações",
      },
      {
        'label': 'Lanternas de Posição Traseira',
        'value':
            widget.vistoria.lanternasPosicaoTraseira == true ? "OK" : "False",
        'Obs': widget.vistoria.lanternasPosicaoTraseiraObs != null &&
                widget.vistoria.lanternasPosicaoTraseiraObs!.isNotEmpty
            ? widget.vistoria.lanternasPosicaoTraseiraObs!
            : "Sem observações",
      },
      {
        'label': 'Lanternas de Freio',
        'value': widget.vistoria.lanternasFreio == true ? "OK" : "False",
        'Obs': widget.vistoria.lanternasFreioObs != null &&
                widget.vistoria.lanternasFreioObs!.isNotEmpty
            ? widget.vistoria.lanternasFreioObs!
            : "Sem observações",
      },
      {
        'label': 'Lanterna da Placa Traseira',
        'value': widget.vistoria.lanternaPlacaTraseira == true ? "OK" : "False",
        'Obs': widget.vistoria.lanternaPlacaTraseiraObs != null &&
                widget.vistoria.lanternaPlacaTraseiraObs!.isNotEmpty
            ? widget.vistoria.lanternaPlacaTraseiraObs!
            : "Sem observações",
      },
      {
        'label': 'Pneus',
        'value': widget.vistoria.pneus == true ? "OK" : "False",
        'Obs': widget.vistoria.pneusObs != null &&
                widget.vistoria.pneusObs!.isNotEmpty
            ? widget.vistoria.pneusObs!
            : "Sem observações",
      },
      {
        'label': 'Higiene e Segurança',
        'value': widget.vistoria.higieneSeguranca == true ? "OK" : "False",
        'Obs': widget.vistoria.higieneSegurancaObs != null &&
                widget.vistoria.higieneSegurancaObs!.isNotEmpty
            ? widget.vistoria.higieneSegurancaObs!
            : "Sem observações",
      },
      {
        'label': 'Bancos - Higiene e Segurança',
        'value':
            widget.vistoria.bancosHigieneSeguranca == true ? "OK" : "False",
        'Obs': widget.vistoria.bancosHigieneSegurancaObs != null &&
                widget.vistoria.bancosHigieneSegurancaObs!.isNotEmpty
            ? widget.vistoria.bancosHigieneSegurancaObs!
            : "Sem observações",
      },
      {
        'label': 'Velocímetro',
        'value': widget.vistoria.velocimetro == true ? "OK" : "False",
        'Obs': widget.vistoria.velocimetroObs != null &&
                widget.vistoria.velocimetroObs!.isNotEmpty
            ? widget.vistoria.velocimetroObs!
            : "Sem observações",
      },
      {
        'label': 'Tacógrafo',
        'value': widget.vistoria.tacografo == true ? "OK" : "False",
        'Obs': widget.vistoria.tacografoObs != null &&
                widget.vistoria.tacografoObs!.isNotEmpty
            ? widget.vistoria.tacografoObs!
            : "Sem observações",
      },
      {
        'label': 'Bateria',
        'value': widget.vistoria.bateria == true ? "OK" : "False",
        'Obs': widget.vistoria.bateriaObs != null &&
                widget.vistoria.bateriaObs!.isNotEmpty
            ? widget.vistoria.bateriaObs!
            : "Sem observações",
      },
      {
        'label': 'Documento do Veículo Proprietário',
        'value': widget.vistoria.docVeiculoProp == true ? "OK" : "False",
        'Obs': widget.vistoria.docVeiculoPropObs != null &&
                widget.vistoria.docVeiculoPropObs!.isNotEmpty
            ? widget.vistoria.docVeiculoPropObs!
            : "Sem observações",
      },
      {
        'label': 'Motor de Partida',
        'value': widget.vistoria.motorPartida == true ? "OK" : "False",
        'Obs': widget.vistoria.motorPartidaObs != null &&
                widget.vistoria.motorPartidaObs!.isNotEmpty
            ? widget.vistoria.motorPartidaObs!
            : "Sem observações",
      },
      {
        'label': 'observacao',
        'value': widget.vistoria.observacao != null &&
                widget.vistoria.observacao!.isNotEmpty
            ? widget.vistoria.observacao!
            : "False",
        'Obs': widget.vistoria.observacao != null &&
                widget.vistoria.observacao!.isNotEmpty
            ? widget.vistoria.observacao!
            : "Sem observações",
      },
      // Campos sem observações
      {
        'label': 'Liberação de Alvará para Licenciamento de Veículo de Aluguel',
        'value': widget.vistoria.requerPrefDiretTributario01 == true
            ? "OK"
            : "False",
        'Obs': ''
      },
      {
        'label': 'Renovação de Alvará para Licenciamento de Veículo de Aluguel',
        'value': widget.vistoria.requerPrefDiretTributario02 == true
            ? "OK"
            : "False",
        'Obs': ''
      },
      {
        'label': 'Vistoria de Veículo de Aluguel',
        'value': widget.vistoria.requerPrefDiretTributario03 == true
            ? "OK"
            : "False",
        'Obs': ''
      },
      {
        'label': 'Transferência',
        'value': widget.vistoria.requerPrefDiretTributario04 == true
            ? "OK"
            : "False",
        'Obs': ''
      },
      {
        'label': 'Mudança de Placa ou Tarjeta',
        'value': widget.vistoria.requerPrefDiretTributario05 == true
            ? "OK"
            : "False",
        'Obs': ''
      },
      {
        'label': 'Outros',
        'value': widget.vistoria.requerPrefDiretTributario06 == true
            ? "OK"
            : "False",
        'Obs': ''
      },
    ];

    // Adicione condicionalmente o campo se `statusVistoria` não for "APROVADO"
    if (widget.vistoria.statusVistoria != "APROVADO") {
      camposCarroMoto.add({
        'label': 'Observação Reprovado',
        'value': widget.vistoria.statusVistoria == "APROVADO" ? "OK" : "False",
        'Obs': widget.vistoria.reprovadoObs ?? 'Sem observações',
      });
    }

    // (Outras variáveis do seu código para camposMoto, camposCarro, camposCarroMoto...)

    // Determina os campos a serem exibidos com base no tipo de veículo
    List<Map<String, String?>> camposVistoria = [];

    if (widget.vistoria.tipo == "MOTOCICLETA" ||
        widget.vistoria.tipo == "MOTONETA") {
      camposVistoria = [...dadosVeiclos, ...camposMoto, ...camposCarroMoto];
    } else {
      camposVistoria = [...dadosVeiclos, ...camposCarro, ...camposCarroMoto];
    }
    double alturaContainer = 250;
    // Top Content (com as informações da vistoria e a imagem de fundo)
    final topContent = Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 10.0),
          height: alturaContainer, //MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: (widget.vistoria.tipo == "MOTOCICLETA" ||
                      widget.vistoria.tipo == "MOTONETA")
                  ? const AssetImage("assets/images/FAN-LATERAL_4.webp")
                  : const AssetImage(
                      "assets/images/onix-hatch-showroom-1920x960.webp"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: alturaContainer, //MediaQuery.of(context).size.height * 0.35,
          // width: MediaQuery.of(context).size.width,
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
                    widget.vistoria.placa ?? "Placa False",
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
                            'Cor: ${widget.vistoria.cor ?? "False"}',
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
                      'Modelo: ${widget.vistoria.marcaModelo ?? "False"}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Realizada: ${DateFormat('dd/MM/yyyy HH:mm').format(widget.vistoria.dataVistoria!) ?? "False"}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: Text(
                      'Status: ${widget.vistoria.statusVistoria ?? "Reprovado"}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: alturaContainer, // MediaQuery.of(context).size.height * 0.35,
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
          Get.to(() => PdfPreviewPage(ocorrencia: widget.vistoria));
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
                if (widget.vistoria.FotosVistoria != null &&
                    widget.vistoria.FotosVistoria!.isNotEmpty)
                  WidgetFotoDetalhes(vistoria: widget.vistoria),
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
