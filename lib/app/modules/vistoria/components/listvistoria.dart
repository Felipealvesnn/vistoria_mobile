import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vistoria_mobile/app/modules/vistoria/views/VistoriaDetalhesView.dart';
import '../controllers/vistoria_controller.dart'; // Importa a tela de detalhes

class ListVistoria extends StatelessWidget {
  final VistoriaController controller;

  const ListVistoria({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        controller: controller.scrollController, // Usa o ScrollController
        physics: const BouncingScrollPhysics(),
        itemCount: controller.vistoriasTela.length +
            1, // Adiciona 1 para o item de carregamento
        itemBuilder: (context, index) {
          if (index == controller.vistoriasTela.length) {
            // Se chegou ao final da lista, mostra o item de carregamento ou mensagem de fim
            return Obx(() {
              if (controller.isLoadingMore.value) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (!controller.hasMoreVistorias.value) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text('Não tem mais vistoria')),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text('Carregar mais...')),
                );
              }
            });
          }

          // Escolhe o ícone com base no tipo do veículo
          var vistoria = controller.vistoriasTela[index];
          IconData leadingIcon;
          if (vistoria.tipo != null &&
              (vistoria.tipo == "MOTOCICLETA" || vistoria.tipo == "MOTONETA")) {
            leadingIcon = Icons.motorcycle; // Ícone para moto/motoneta
          } else {
            leadingIcon = Icons.car_rental; // Ícone para carro ou outros
          }

          return Card(
            elevation: 3,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(leadingIcon), // Usa o ícone correto
              title: Text('Placa: ${vistoria.placa}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Modelo: ${vistoria.marcaModelo}'),
                  Text(
                      'Realizada: ${DateFormat('dd/MM/yyyy HH:mm').format(vistoria.dataVistoria!)}'),
                  Text('Cor: ${vistoria.cor}'),
                  Text(
                      'Vistoria status: ${(vistoria.statusVistoria != null ? vistoria.statusVistoria!.toUpperCase() : "NAO APROVADO")}'),
                ],
              ),
              trailing: (vistoria.statusVistoria != null &&
                      vistoria.statusVistoria!.toUpperCase() == "APROVADO")
                  ? const Icon(Icons.check, color: Colors.green)
                  : const Icon(Icons.info_outline, color: Colors.red),

              onTap: () {
                // Navega para a página de detalhes da vistoria ao clicar
                Get.to(() => VistoriaDetalhesView(vistoria: vistoria));
              },
            ),
          );
        },
      );
    });
  }
}
