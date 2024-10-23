import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:vistoria_mobile/app/modules/vistoria/ultis/utilsVistoriaMaps.dart';
import 'package:vistoria_mobile/app/utils/funcoesUtils.dart';

class TestPrintVistoria {
  static BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  static Future<void> printVistoria(Vistoria vistoria) async {
    // Formatação da data
    String dataVistoria = vistoria.dataVistoria != null
        ? DateFormat("dd/MM/yyyy HH:mm:ss")
            .format(vistoria.dataVistoria!.toLocal())
        : 'N/A';

    // Determina quais campos serão exibidos com base no tipo de veículo
    List<Map<String, String?>> camposVistoria =
        MapDeVistoriaDetails(vistoria, incluirCamposExtras: true);

    // Verifica se está conectado à impressora
    bool? isConnected = await bluetooth.isConnected;

    if (isConnected == true) {
      try {
        // Início da impressão
        ByteData bytesAsset = await rootBundle.load("assets/icon/iconebranco.jpg");
        Uint8List imageBytesFromAsset = bytesAsset.buffer
            .asUint8List(bytesAsset.offsetInBytes, bytesAsset.lengthInBytes);

        await bluetooth.printNewLine();
        await bluetooth.printImageBytes(imageBytesFromAsset);
        await bluetooth.printNewLine();
        await bluetooth.printCustom(
            "DETALHES DA VISTORIA", 3, 1); // Título centralizado
        await bluetooth.printNewLine();

        // Imprimir os campos dinamicamente
        for (var campo in camposVistoria) {
          if (campo['label'] == "Realizada") {
            continue; // Pula para o próximo campo
          }
          await bluetooth.printCustom(
              "${removeSpecialCharacters(campo['label']!)} : ${removeSpecialCharacters(campo['value']!)}",
              1,
              0);
          // await bluetooth.printNewLine();
          if (campo['Obs'] != null && campo['Obs']!.isNotEmpty) {
            await bluetooth.printCustom(
                "Observacao: ${removeSpecialCharacters(campo['Obs']!)}", 0, 0);
            await bluetooth.printNewLine();
          }
        }

        // Data da Vistoria
        await bluetooth.printCustom("Data da Vistoria: $dataVistoria", 1, 0);

        // Finaliza a impressão e corta o papel
        await bluetooth.printNewLine();
        await bluetooth.printNewLine();
        await bluetooth.paperCut();
      } catch (e) {
        print('Erro ao imprimir: $e');
      }
    } else {
      print('Bluetooth não está conectado.');
    }
  }
}

