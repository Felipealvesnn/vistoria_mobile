import 'package:flutter/material.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/generatePdf.dart';

class VistoriaDetalhesView extends StatelessWidget {
  final Vistoria vistoria;

  const VistoriaDetalhesView({super.key, required this.vistoria});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String?>> dadosVeiclos = [
      {"label": "Marca", "value": vistoria.marcaModelo},
      {"label": "Placa", "value": vistoria.placa},
      {"label": "Chassi", "value": vistoria.chassi},
      {"label": "Ano", "value": vistoria.ano},
      {"label": "Cor", "value": vistoria.cor},
      {"label": "Tipo", "value": vistoria.tipo},
      {"label": "KM", "value": vistoria.km.toString()},
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

    // Determina os campos a serem exibidos com base no tipo de veículo
    List<Map<String, String?>> camposVistoria = [];

    if (vistoria.tipo == "MOTOCICLETA" || vistoria.tipo == "MOTONETA") {
      // Mostrar campos de moto + campos compartilhados
      camposVistoria = [...dadosVeiclos, ...camposMoto, ...camposCarroMoto];
    } else {
      // Mostrar campos de carro + campos compartilhados
      camposVistoria = [...dadosVeiclos, ...camposCarro, ...camposCarroMoto];
    }
    // Indicador de progresso para KM
    final levelIndicator = Container(
      child: LinearProgressIndicator(
        backgroundColor: const Color.fromRGBO(209, 224, 224, 0.2),
        value: vistoria.km != null
            ? vistoria.km! / 100000
            : 0, // Verificação para KM nulo
        valueColor: const AlwaysStoppedAnimation(Colors.green),
      ),
    );

    // Informação de KM
    final vistoriaInfo = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        'KM: ${vistoria.km ?? 'Não disponível'}', // Corrige a exibição do KM
        style: const TextStyle(color: Colors.white),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 50.0), // Diminui o espaço entre os itens

        Text(
          vistoria.placa ?? "Placa não disponível",
          style: const TextStyle(
              color: Colors.white, fontSize: 40.0), // Diminui a fonte
        ),
        const Divider(color: Colors.green, thickness: 2),

        const SizedBox(height: 10.0), // Diminui o espaço entre os itens
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
                      color: Colors.white, fontSize: 16.0), // Diminui a fonte
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: levelIndicator, // Ajuste no nível de quilometragem
            ),
            Flexible(
              flex: 2,
              child: vistoriaInfo, // Exibição do KM
            ),
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height *
              0.4, // Reduzi um pouco a altura
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/onix-hatch-showroom-1920x960.webp"), // Coloque sua imagem
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height *
              0.4, // Ajustei para não causar overflow
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(58, 66, 86, .9),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Reduzi um pouco o padding
            child: Center(
              child: SingleChildScrollView(child: topContentText),
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 45.0,
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
          // Lógica para gerar e baixar o PDF
          generatePdf(vistoria); // Chama a função para gerar o PDF
        },
        icon: const Icon(Icons.download),
        label: const Text("Baixar PDF", style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              const Color.fromRGBO(58, 66, 86, 1.0), // Cor do botão
        ),
      ),
    );

    final bottomContentText = ListView.separated(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Desabilita rolagem interna para rolar a view inteira
      itemCount: camposVistoria.length,
      separatorBuilder: (context, index) =>
          const Divider(color: Colors.grey), // Divisor entre os itens
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.info_outline,
              color: Colors.green), // Ícone ao lado de cada item
          title: Text(
            camposVistoria[index]["label"]!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(
            camposVistoria[index]["value"] ?? "Não disponível",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        );
      },
    );

    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 300, // Define o tamanho da área de rolagem
            child: SingleChildScrollView(
              child: bottomContentText,
            ),
          ),
          const SizedBox(height: 20), // Espaço entre o texto e o botão
          readButton, // Botão para gerar o PDF
        ],
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        // Adicionei um scroll para evitar overflow
        child: Column(
          children: <Widget>[
            topContent,
            bottomContent,
          ],
        ),
      ),
    );
  }
}
