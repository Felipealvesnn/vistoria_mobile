import 'dart:convert';

import 'package:pdf/pdf.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'dart:typed_data';

Future<Uint8List> generatePdf(Vistoria vistoria) async {
  final pdf = pw.Document();

  // Carregar a imagem para o cabeçalho do PDF
  final imageLogo = pw.MemoryImage(
      (await rootBundle.load('assets/icon/icon.png')).buffer.asUint8List());

  // Carregar a fonte customizada
  final font = pw.Font.ttf(
      await rootBundle.load("assets/fonts/ttf/JetBrainsMono-Bold.ttf"));

  // Definindo campos de acordo com o tipo de veículo

  final List<Map<String, String?>> dadosVeiclos = [
    {"label": "Marca", "value": vistoria.marcaModelo},
    {"label": "Placa", "value": vistoria.placa},
    {"label": "Chassi", "value": vistoria.chassi},
    {"label": "Ano", "value": vistoria.ano},
    //{"label": "Cor", "value": vistoria.cor},
    {"label": "Vistoria feita por", "value": vistoria.usuarioNome},
    {"label": "Tipo", "value": vistoria.tipo},
    //{"label": "KM", "value": vistoria.km.toString()},
  ];

  if (vistoria.agenteCod != '0' && vistoria.agenteCod != null) {
    dadosVeiclos.add(
      {"label": "Codigo agente", "value": vistoria.agenteCod},
    );
  }

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
      'Obs': vistoria.kitTracaoObs != null && vistoria.kitTracaoObs!.isNotEmpty
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
      'Obs': vistoria.cortaPipaObs != null && vistoria.cortaPipaObs!.isNotEmpty
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
      'Obs': vistoria.capacetesObs != null && vistoria.capacetesObs!.isNotEmpty
          ? vistoria.capacetesObs!
          : "Sem observações",
    },
  ];

  final List<Map<String, String?>> camposCarro = [
    {
      'label': 'Para-choque',
      'value': vistoria.parachoques == true ? "OK" : "False",
      'Obs':
          vistoria.parachoquesObs != null && vistoria.parachoquesObs!.isNotEmpty
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
      'Obs': vistoria.trianguloObs != null && vistoria.trianguloObs!.isNotEmpty
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
      'value': vistoria.luzIndicadoraDirecaoDianteira == true ? "OK" : "False",
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
      'Obs': vistoria.nivelAguaObs != null && vistoria.nivelAguaObs!.isNotEmpty
          ? vistoria.nivelAguaObs!
          : "Sem observações",
    },
    {
      'label': 'Faroletes',
      'value': vistoria.faroletes == true ? "OK" : "False",
      'Obs': vistoria.faroletesObs != null && vistoria.faroletesObs!.isNotEmpty
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
      'Obs': vistoria.chaveRodaObs != null && vistoria.chaveRodaObs!.isNotEmpty
          ? vistoria.chaveRodaObs!
          : "Sem observações",
    },
    {
      'label': 'Cilindro de Gás',
      'value': vistoria.cinlindroGas == true ? "OK" : "False",
      'Obs':
          vistoria.cilindroGasObs != null && vistoria.cilindroGasObs!.isNotEmpty
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
      'Obs':
          vistoria.velocimetroObs != null && vistoria.velocimetroObs!.isNotEmpty
              ? vistoria.velocimetroObs!
              : "Sem observações",
    },
    {
      'label': 'Tacógrafo',
      'value': vistoria.tacografo == true ? "OK" : "False",
      'Obs': vistoria.tacografoObs != null && vistoria.tacografoObs!.isNotEmpty
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
    },
    {
      'label': 'Renovação de Alvará para Licenciamento de Veículo de Aluguel',
      'value': vistoria.requerPrefDiretTributario02 == true ? "OK" : "False",
    },
    {
      'label': 'Vistoria de Veículo de Aluguel',
      'value': vistoria.requerPrefDiretTributario03 == true ? "OK" : "False",
    },
    {
      'label': 'Transferência',
      'value': vistoria.requerPrefDiretTributario04 == true ? "OK" : "False",
    },
    {
      'label': 'Mudança de Placa ou Tarjeta',
      'value': vistoria.requerPrefDiretTributario05 == true ? "OK" : "False",
    },
    {
      'label': 'Outros',
      'value': vistoria.requerPrefDiretTributario06 == true ? "OK" : "False",
    },
  ];

  if (vistoria.statusVistoria != "APROVADO") {
    camposCarroMoto.add({
      'label': 'Observação Reprovado',
      'value': vistoria.statusVistoria == "APROVADO" ? "OK" : "False",
      'Obs': vistoria.reprovadoObs ?? 'Sem observações',
    });
  }

  // Determina os campos a serem exibidos com base no tipo de veículo
  List<Map<String, String?>> camposVistoria = [];

  if (vistoria.tipo == "MOTOCICLETA" || vistoria.tipo == "MOTONETA") {
    // Mostrar campos de moto + campos compartilhados
    camposVistoria = [...camposMoto, ...camposCarroMoto];
  } else {
    // Mostrar campos de carro + campos compartilhados
    camposVistoria = [...camposCarro, ...camposCarroMoto];
  }
  // final pdfPageWidth = PdfPageFormat.a4.availableWidth;
  final pdfPageHeightrs = PdfPageFormat.a4.availableHeight;

  Uint8List loadImageDataFromBase64(String base64String) {
    return base64Decode(base64String);
  }

// Definição do tema da página
  const pageTheme = pw.PageTheme(
    margin: pw.EdgeInsets.all(20),
    pageFormat: PdfPageFormat.a4,
  );

// Obter as dimensões disponíveis
  final pdfPageWidth = pageTheme.pageFormat.availableWidth;
  final pdfPageHeight = pageTheme.pageFormat.availableHeight;

// Função para adicionar páginas com imagens
// Função para adicionar páginas com imagens
  // Função para adicionar páginas com imagens
  void addImagePage(
      pw.Document pdf, pw.MemoryImage image1, pw.MemoryImage? image2) {
    pdf.addPage(
      pw.Page(
        pageTheme: pageTheme,
        build: (context) {
          // Verifica se há uma ou duas imagens
          if (image2 == null) {
            // Se houver apenas uma imagem, ela deve ocupar toda a página
            return pw.Center(
              child: pw.Image(
                image1,
                width: pdfPageWidth,
                height: pdfPageHeight,
                fit: pw.BoxFit
                    .contain, // Ajusta para ocupar a folha mantendo a proporção sem cortar
              ),
            );
          } else {
            // Se houver duas imagens, exibir em coluna e garantir que estejam deitadas
            return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                // Primeiro contêiner de imagem
                pw.Center(
                    child: pw.Container(
                  height: pdfPageHeight / 2 -
                      20, // Metade da altura disponível (com espaçamento)
                  width: pdfPageWidth,
                  child: pw.Image(
                    image1,
                    fit: pw.BoxFit
                        .contain, // Ajustar para que a imagem caiba no espaço sem cortar
                  ),
                )),
                pw.SizedBox(height: 20), // Espaço entre as imagens
                // Segundo contêiner de imagem (se existir)
                pw.Container(
                  height: pdfPageHeight / 2 -
                      20, // Metade da altura disponível (com espaçamento)
                  width: pdfPageWidth,
                  child: pw.Image(
                    image2,
                    fit: pw.BoxFit
                        .contain, // Ajustar para que a imagem caiba no espaço sem cortar
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

// Header function
  pw.Widget buildHeader(pw.Context context) {
    return pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("V I S T O R I A",
                  style: pw.TextStyle(font: font, fontSize: 24)),
              pw.SizedBox(
                height: 100,
                width: 100,
                child: pw.Image(imageLogo),
              )
            ],
          ),
          pw.SizedBox(height: 20),
        ]);
  }

  // Footer function
  pw.Widget buildFooter(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(30),
      child: pw.Text(
        'Para maiores informações, acesse: www.w2e.ce.gov.br',
        style: pw.TextStyle(
          font: font,
          fontSize: 12,
          fontStyle: pw.FontStyle.italic,
        ),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  String getSymbol(dynamic value) {
    if (value == true || value == 'OK' || value == 'OK') {
      return 'OK'; //'✔'; // Símbolo de check (OK)
    } else {
      return '✗'; // Símbolo de X (não)
    }
  }

  // Build the content
  pdf.addPage(
    pw.MultiPage(
      pageTheme: const pw.PageTheme(
        margin: pw.EdgeInsets.all(20),
      ),
      header: buildHeader,
      footer: buildFooter,
      build: (context) {
        List<pw.Widget> widgets = [];

        // Adiciona as informações como Rows ao PDF com bordas
        for (int i = 0; i < dadosVeiclos.length; i += 2) {
          final first = dadosVeiclos[i];
          final second =
              (i + 1 < dadosVeiclos.length) ? dadosVeiclos[i + 1] : null;

          widgets.add(
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                // Primeiro item com borda
                pw.Expanded(
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      '${first['label']}: ${first['value'] ?? 'False'}',
                      textAlign: pw.TextAlign.left,
                    ),
                  ),
                ),
                // Segundo item com borda, se existir
                if (second != null)
                  pw.Expanded(
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(8),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black),
                      ),
                      child: pw.Text(
                        '${second['label']}: ${second['value'] ?? 'False'}',
                        textAlign: pw.TextAlign.left,
                      ),
                    ),
                  ),
              ],
            ),
          );

          // Espaçamento entre as linhas
          widgets.add(pw.SizedBox(height: 10));
        }

        widgets.add(pw.SizedBox(height: 20)); // Add spacing between tables

        // Prepare data for camposVistoria table
        List<List<String>> camposVistoriaData = camposVistoria.map((campo) {
          return [
            campo['label'] ?? '',
            campo['Obs'] ?? '',
            getSymbol(campo['value']) ?? 'Não disponível',
          ];
        }).toList();

        // Add the camposVistoria table
        // Add the camposVistoria table with the new header
        widgets.add(
          pw.Table.fromTextArray(
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.center,
              2: pw.Alignment.center,
            },
            border: pw.TableBorder.all(color: PdfColors.black),
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(1),
            },
            cellPadding: const pw.EdgeInsets.all(10),
            headerStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              font: font,
            ),
            cellStyle: pw.TextStyle(
              font: font, // Fonte para as células de dados
            ),
            headers: [
              'Campo',
              'Observação',
              'Valor',
            ],
            data: camposVistoriaData,
          ),
        );

        // Iterar sobre as imagens em pares

        return widgets;
      },
    ),
  );

  List<pw.MemoryImage> imageList = [];

  if (vistoria.FotosVistoria != null && vistoria.FotosVistoria!.isNotEmpty) {
    for (var foto in vistoria.FotosVistoria!) {
      Uint8List imageData;

      // Carregar os dados da imagem (adapte conforme necessário)
      imageData = loadImageDataFromBase64(foto.nomeFoto!);

      // Decodificar a imagem
      img.Image originalImage = img.decodeImage(imageData)!;

      // Codificar a imagem como JPEG (sem rotacionar neste momento)
      Uint8List imageDataFinal =
          Uint8List.fromList(img.encodeJpg(originalImage));

      // Criar uma pw.MemoryImage e adicionar à lista
      final image = pw.MemoryImage(imageDataFinal);
      imageList.add(image);
    }
  }

// Adicionar páginas com as imagens em pares (2 por página)
  for (int i = 0; i < imageList.length; i += 2) {
    final image1 = imageList[i];
    final image2 = (i + 1 < imageList.length) ? imageList[i + 1] : null;

    // Verificar se há duas imagens, e se for o caso, rotacionar ambas se necessário
    if (image2 != null) {
      // Carregar os dados das imagens e decodificar
      img.Image decodedImage1 = img.decodeImage(image1.bytes)!;
      img.Image decodedImage2 = img.decodeImage(image2.bytes)!;

      // Rotacionar a imagem 1 se necessário
      if (decodedImage1.height > decodedImage1.width) {
        decodedImage1 = img.copyRotate(decodedImage1,angle:   90);
      }

      // Rotacionar a imagem 2 se necessário
      if (decodedImage2.height > decodedImage2.width) {
        decodedImage2 = img.copyRotate(decodedImage2,angle:   90);
      }

      // Codificar novamente as imagens rotacionadas como JPEG
      Uint8List rotatedImageData1 =
          Uint8List.fromList(img.encodeJpg(decodedImage1));
      Uint8List rotatedImageData2 =
          Uint8List.fromList(img.encodeJpg(decodedImage2));

      // Atualizar as imagens para a lista rotacionada
      final rotatedImage1 = pw.MemoryImage(rotatedImageData1);
      final rotatedImage2 = pw.MemoryImage(rotatedImageData2);

      // Adicionar uma nova página com duas imagens
      addImagePage(pdf, rotatedImage1, rotatedImage2);
    } else {
      // Adicionar uma nova página com apenas uma imagem (sem rotacionar)
      addImagePage(pdf, image1, null);
    }
  }

  return pdf.save();
}
