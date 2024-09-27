import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../data/models/vistoria.dart';

void generatePdf(Vistoria vistoria) async {
  final pdf = pw.Document();

  // Definindo campos de acordo com o tipo de veículo
  final List<Map<String, String?>> dadosVeiclos = [
    {"label": "Marca", "value": vistoria.marcaModelo},
    {"label": "Placa", "value": vistoria.placa},
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
    {'label': 'Step', 'value': vistoria.step == true ? "OK" : "Não disponível"},
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
      'value':
          vistoria.faroisPrincipaisDianteiros == true ? "OK" : "Não disponível"
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
      'value': vistoria.lanternaPlacaTraseira == true ? "OK" : "Não disponível"
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
      'value': vistoria.bancosHigieneSeguranca == true ? "OK" : "Não disponível"
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
      'value':
          vistoria.requerPrefDiretTributario01 == true ? "OK" : "Não disponível"
    },
    {
      'label': 'Renovação de Alvará para Licenciamento de Veículo de Aluguel',
      'value':
          vistoria.requerPrefDiretTributario02 == true ? "OK" : "Não disponível"
    },
    {
      'label': 'Vistoria de Veículo de Aluguel',
      'value':
          vistoria.requerPrefDiretTributario03 == true ? "OK" : "Não disponível"
    },
    {
      'label': 'Transferência',
      'value':
          vistoria.requerPrefDiretTributario04 == true ? "OK" : "Não disponível"
    },
    {
      'label': 'Mudança de Placa ou Tarjeta',
      'value':
          vistoria.requerPrefDiretTributario05 == true ? "OK" : "Não disponível"
    },
    {
      'label': 'Outros',
      'value':
          vistoria.requerPrefDiretTributario06 == true ? "OK" : "Não disponível"
    },
  ];

  // Determina os campos a serem exibidos com base no tipo de veículo
  List<Map<String, String?>> camposVistoria = [];

  if (vistoria.tipo == "MOTOCICLETA" || vistoria.tipo == "MOTONETA") {
    // Mostrar campos de moto + campos compartilhados
    camposVistoria = [...dadosVeiclos, ...camposMoto, ...camposCarroMoto];
  } else {
    // Mostrar campos de carro + campos compartilhados
    camposVistoria = [...dadosVeiclos, ...camposCarro, ...camposCarroMoto];
  }

  // Criando o conteúdo do PDF
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Detalhes da Vistoria', style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 16),
            ...camposVistoria.map((campo) => pw.Row(
                  children: [
                    pw.Text('${campo['label']}: ',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text(campo['value'] ?? "Não disponível"),
                  ],
                )),
          ],
        );
      },
    ),
  );

  // Imprime o PDF
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}
