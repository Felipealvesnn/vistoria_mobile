import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/PhotoViewGalleryScreen.dart';

class WidgetFotoDetalhes extends StatelessWidget {
  const WidgetFotoDetalhes({
    super.key,
    required this.vistoria,
  });

  final Vistoria vistoria;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          physics:
              const NeverScrollableScrollPhysics(), // Para desativar o scroll do GridView
          shrinkWrap:
              true, // Para ajustar o tamanho do GridView dentro do Sliver
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Número de miniaturas por linha
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: vistoria.FotosVistoria!.length,
          itemBuilder: (context, index) {
            final fotoVistoria = vistoria.FotosVistoria![index];

              
            // Decodifica a string Base64 para bytes
            final imageBytes = const Base64Decoder()
                .convert(fotoVistoria.nomeFoto!);
    
            return GestureDetector(
              onTap: () {
                // Quando a miniatura for clicada, abrir a visualização em tela cheia
                Get.to(
                  () => PhotoViewGalleryScreen(
                    fotosVistoria: vistoria.FotosVistoria!,
                    initialIndex: index,
                  ),
                );
              },
              child: Image.memory(
                imageBytes,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}


Future<Uint8List> _getImageBytes(String? nomeFoto) async {
  // Se `nomeFoto` for nula ou vazia, retorna os bytes da imagem de fallback
  if (nomeFoto == null || nomeFoto.isEmpty) {
    return (await rootBundle.load('assets/images/notfound.jpg')).buffer.asUint8List();
  }

  // Caso contrário, decodifica a string Base64 normalmente
  return const Base64Decoder().convert(nomeFoto);
}
