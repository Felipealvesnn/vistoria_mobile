import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:vistoria_mobile/app/modules/printPage/components/PdfPreviewPage.dart';
import 'package:vistoria_mobile/app/modules/printPage/views/print_page_view.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/WidgetFotoDetalhes.dart';
import 'package:vistoria_mobile/app/modules/vistoria/controllers/vistoria_controller.dart';
import 'package:vistoria_mobile/app/modules/vistoria/ultis/utilsVistoriaMaps.dart';
import 'package:vistoria_mobile/app/routes/app_pages.dart';

class VistoriaDetalhesView extends StatefulWidget {
  final Vistoria vistoria;

  const VistoriaDetalhesView({super.key, required this.vistoria});

  @override
  State<VistoriaDetalhesView> createState() => _VistoriaDetalhesViewState();
}

class _VistoriaDetalhesViewState extends State<VistoriaDetalhesView> {
  RxBool loadingImagemPdf = false.obs;
  VistoriaController controller = Get.find<VistoriaController>();
  Future<void> _fetchImages() async {
    List<FotosVistorium> imagens =
        await controller.GetimagensVistoria(widget.vistoria.vistoriaId!);
    if (imagens.isNotEmpty) {
      setState(() {
        widget.vistoria.FotosVistoria = imagens;
      });
    }
    loadingImagemPdf.value = true;
  }

  @override
  void initState() {
    _fetchImages();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String?>> camposVistoria = MapDeVistoriaDetails(widget.vistoria, incluirCamposVeiculos: true);
    double alturaContainer = 270;
    // Top Content (com as informações da vistoria e a imagem de fundo)
    final topContent = Stack(
      children: <Widget>[
        //container da imagem,
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
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Feito por: ${widget.vistoria.usuarioNome! ?? "False"}',
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

    final readButton = Obx(() => Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          width: MediaQuery.of(context).size.width,
          child: (loadingImagemPdf.value)
              ? ElevatedButton.icon(
                  onPressed: () async {
                     Get.toNamed(Routes.PRINT_PAGE, arguments: widget.vistoria);
                   //await Get.to(() => PrintPageView(vistoria: widget.vistoria));
                  },
                  icon: const Icon(Icons.download),
                  label: const Text(
                    "Print View",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      // Defina as propriedades do botão aqui
                      // backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
                      ),
                )
              : const Center(
                  child: Text(
                    "Carregando PDF...",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
        ));

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