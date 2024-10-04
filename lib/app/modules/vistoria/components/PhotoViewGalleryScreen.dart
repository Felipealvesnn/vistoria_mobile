import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';

class PhotoViewGalleryScreen extends StatelessWidget {
  final List<FotosVistorium> fotosVistoria;
  final int initialIndex;

  const PhotoViewGalleryScreen({
    super.key,
    required this.fotosVistoria,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizar Imagem'),
      ),
      body: PhotoViewGallery.builder(
        itemCount: fotosVistoria.length,
        pageController: PageController(initialPage: initialIndex),
        builder: (context, index) {
          final foto = fotosVistoria[index];
          final imageBytes = const Base64Decoder().convert(foto.nomeFoto!);

          return PhotoViewGalleryPageOptions(
            imageProvider: MemoryImage(imageBytes),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
      ),
    );
  }
}
