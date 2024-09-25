import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../data/models/vistoria.dart';

void generatePdf(Vistoria vistoria) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Detalhes da Vistoria', style: pw.TextStyle(fontSize: 24)),
              pw.Text('Placa: ${vistoria.placa}'),
              pw.Text('Data: ${vistoria.dataVistoria}'),
              pw.Text('Marca: ${vistoria.marcaModelo}'),
              pw.Text('Cor: ${vistoria.cor}'),
              // Adicione mais detalhes da vistoria
            ],
          ),
        );
      },
    ),
  );

  // Imprime o PDF
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}
