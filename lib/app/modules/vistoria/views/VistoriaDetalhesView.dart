import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
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
        'value': vistoria.ruidoMotor == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Redutores de Temperatura',
        'value': vistoria.redutoresTemperatura == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Kit de Tração',
        'value': vistoria.kitTracao == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Chave de Ignição do Baú',
        'value': vistoria.chavesIgnicaoBau == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Mata Cachorro',
        'value': vistoria.mataCachorro == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Corta Pipa',
        'value': vistoria.cortaPipa == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Colete',
        'value': vistoria.colete == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Potência Mínima e Máxima',
        'value': vistoria.potenciaMinimaMaxima == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Capacetes',
        'value': vistoria.capacetes == true ? "OK" : "Não disponível"
      },
    ];

    // Campos específicos de Carro
    final List<Map<String, String?>> camposCarro = [
      {
        'label': 'Para-choque',
        'value': vistoria.parachoques == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Macaco',
        'value': vistoria.macaco == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Triângulo',
        'value': vistoria.triangulo == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Vidros',
        'value': vistoria.vidros == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Limpador Parabrisa',
        'value': vistoria.limpadorParabrisa == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Luz Indicadora Direção Dianteira',
        'value': vistoria.luzIndicadoraDirecaoDianteira == true
            ? "OK"
            : "Não disponível"
      },
      {
        'label': 'Luz Indicadora Direção Traseira',
        'value': vistoria.luzIndicadoraDirecaoTraseira == true
            ? "OK"
            : "Não disponível"
      },
      {
        'label': 'Indicadores Painel',
        'value': vistoria.indicadoresPainel == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Nível de Óleo do Motor',
        'value': vistoria.nivelOleoMotor == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Nível de Fluido de Freio',
        'value': vistoria.nivelFluidoFreio == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Adesivação',
        'value': vistoria.adesivacao == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Freio de Serviço',
        'value': vistoria.freioServico == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Freio de Estacionamento',
        'value': vistoria.freioEstacionamento == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Nível de Água',
        'value': vistoria.nivelAgua == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Faroletes',
        'value': vistoria.faroletes == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Lanternas Direção',
        'value': vistoria.lanternasDirecao == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Lanterna Marcha Ré',
        'value': vistoria.lanternaMarchaRe == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Extintor',
        'value': vistoria.extintor == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Cinto de Segurança',
        'value': vistoria.cintoSeguranca == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Step',
        'value': vistoria.step == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Chave de Roda',
        'value': vistoria.chaveRoda == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Cilindro de Gás',
        'value': vistoria.cinlindroGas == true ? "OK" : "Não disponível"
      },
    ];

    // Campos compartilhados entre carro e moto
    final List<Map<String, String?>> camposCarroMoto = [
      {
        'label': 'Faróis Principais Dianteiros',
        'value': vistoria.faroisPrincipaisDianteiros == true
            ? "OK"
            : "Não disponível"
      },
      {
        'label': 'Retrovisores',
        'value': vistoria.retrovisores == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Buzina',
        'value': vistoria.buzina == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Lanternas de Posição Traseira',
        'value':
            vistoria.lanternasPosicaoTraseira == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Lanternas de Freio',
        'value': vistoria.lanternasFreio == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Lanterna da Placa Traseira',
        'value':
            vistoria.lanternaPlacaTraseira == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Pneus',
        'value': vistoria.pneus == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Higiene e Segurança',
        'value': vistoria.higieneSeguranca == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Bancos - Higiene e Segurança',
        'value':
            vistoria.bancosHigieneSeguranca == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Velocímetro',
        'value': vistoria.velocimetro == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Tacógrafo',
        'value': vistoria.tacografo == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Bateria',
        'value': vistoria.bateria == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Documento do Veículo Proprietário',
        'value': vistoria.docVeiculoProp == true ? "OK" : "Não disponível"
      },
      {
        'label': 'Motor de Partida',
        'value': vistoria.motorPartida == true ? "OK" : "Não disponível"
      },
      // Campos sem observações
      {
        'label': 'Liberação de Alvará para Licenciamento de Veículo de Aluguel',
        'value': vistoria.requerPrefDiretTributario01 == true
            ? "OK"
            : "Não disponível"
      },
      {
        'label': 'Renovação de Alvará para Licenciamento de Veículo de Aluguel',
        'value': vistoria.requerPrefDiretTributario02 == true
            ? "OK"
            : "Não disponível"
      },
      {
        'label': 'Vistoria de Veículo de Aluguel',
        'value': vistoria.requerPrefDiretTributario03 == true
            ? "OK"
            : "Não disponível"
      },
      {
        'label': 'Transferência',
        'value': vistoria.requerPrefDiretTributario04 == true
            ? "OK"
            : "Não disponível"
      },
      {
        'label': 'Mudança de Placa ou Tarjeta',
        'value': vistoria.requerPrefDiretTributario05 == true
            ? "OK"
            : "Não disponível"
      },
      {
        'label': 'Outros',
        'value': vistoria.requerPrefDiretTributario06 == true
            ? "OK"
            : "Não disponível"
      },
    ];

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
                    vistoria.placa ?? "Placa não disponível",
                    style: const TextStyle(color: Colors.white, fontSize: 40.0),
                  ),
                  const Divider( thickness: 2),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Cor: ${vistoria.cor ?? "Não disponível"}',
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
                      'Modelo: ${vistoria.marcaModelo ?? "Não disponível"}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Data Vistoria: ${vistoria.dataVistoria ?? "Não disponível"}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
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
          generatePdf(vistoria);
        },
        icon: const Icon(Icons.download),
        label: const Text("Baixar PDF", style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
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
                            title: Text(
                              camposVistoria[index]["label"]!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: Text(
                              camposVistoria[index]["value"] ??
                                  "Não disponível",
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
