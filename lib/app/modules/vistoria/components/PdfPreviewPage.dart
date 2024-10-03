import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:printing/printing.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/generatePdf.dart';

class PdfPreviewPage extends StatelessWidget {
  final Vistoria ocorrencia;
  const PdfPreviewPage({super.key, required this.ocorrencia});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF'),
      ),
      body: PdfPreview(
        canDebug : false,
        build: (context) => generatePdf(ocorrencia),
      ),
    );
  }
}
