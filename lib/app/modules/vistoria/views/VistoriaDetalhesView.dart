import 'package:flutter/material.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/generatePdf.dart';

class VistoriaDetalhesView extends StatelessWidget {
  final Vistoria vistoria;

  const VistoriaDetalhesView({super.key, required this.vistoria});

  @override
  Widget build(BuildContext context) {
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
      itemCount: 12,
      separatorBuilder: (context, index) =>
          const Divider(color: Colors.grey), // Divisor entre os itens
      itemBuilder: (context, index) {
        final List<Map<String, String?>> camposVistoria = [
          {"label": "Marca", "value": vistoria.marcaModelo},
          {"label": "Placa", "value": vistoria.placa},
          {"label": "Chassi", "value": vistoria.chassi},
          {"label": "Ano", "value": vistoria.ano},
          {"label": "Cor", "value": vistoria.cor},
          {"label": "Tipo", "value": vistoria.tipo},
          {
            "label": "Quilometragem",
            "value": vistoria.km != null ? "${vistoria.km} km" : null
          },
          {
            "label": "Parachoques",
            "value": vistoria.parachoques == true ? "OK" : "Não disponível"
          },
          {
            "label": "Retrovisores",
            "value": vistoria.retrovisores == true ? "OK" : "Não disponível"
          },
          {
            "label": "Faróis Principais",
            "value": vistoria.faroisPrincipaisDianteiros == true
                ? "OK"
                : "Não disponível"
          },
          {
            "label": "Cinto de Segurança",
            "value": vistoria.cintoSeguranca == true ? "OK" : "Não disponível"
          },
          {
            "label": "Data",
            "value": vistoria.dataVistoria != null
                ? vistoria.dataVistoria!.toString()
                : "Data não disponível"
          },
        ];

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
