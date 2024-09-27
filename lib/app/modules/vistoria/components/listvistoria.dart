import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/vistoria/views/VistoriaDetalhesView.dart';
import '../controllers/vistoria_controller.dart'; // Importa a tela de detalhes

class ListVistoria extends StatelessWidget {
  final VistoriaController controller;

  const ListVistoria({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.vistorias.length,
      itemBuilder: (context, index) {
        var vistoria = controller.vistorias[index];

        // Escolhe o ícone com base no tipo do veículo
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
                Text('Data da Vistoria: ${vistoria.dataVistoria!.toLocal()}'),
                Text('Cor: ${vistoria.cor}'),
              ],
            ),
            trailing: const Icon(Icons.info_outline, color: Colors.red),
            onTap: () {
              // Navega para a página de detalhes da vistoria ao clicar
              Get.to(() => VistoriaDetalhesView(vistoria: vistoria));
            },
          ),
        );
      },
    );
  }
}
