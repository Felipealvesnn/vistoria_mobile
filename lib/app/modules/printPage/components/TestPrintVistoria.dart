import 'dart:io';

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

    String pathImage = await initSavetoPath();

    // Verifica se está conectado à impressora
    bool? isConnected = await bluetooth.isConnected;

    if (isConnected == true) {
      try {
        // Início da impressão
        await bluetooth.printNewLine();
        await bluetooth.printImage(pathImage); // Caminho da imagem/logo
        await bluetooth.printNewLine();
        await bluetooth.printCustom(
            "DETALHES DA VISTORIA", 3, 1); // Título centralizado
        await bluetooth.printNewLine();

        // Imprimir os campos dinamicamente
        for (var campo in camposVistoria) {
          await bluetooth.printCustom(
              "${removeSpecialCharacters(campo['label']!)} : ${removeSpecialCharacters(campo['value']!)}",
              1,
              0);
          await bluetooth.printNewLine();
          if (campo['Obs'] != null && campo['Obs']!.isNotEmpty) {
            await bluetooth.printCustom(
                "Observacao: ${removeSpecialCharacters(campo['Obs']!)}", 0, 0);
            await bluetooth.printNewLine();
          }
        }

        // Data da Vistoria
        await bluetooth.printCustom("Data da Vistoria: $dataVistoria", 0, 0);

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

Future<String> initSavetoPath() async {
  //read and write
  //image max 300px X 300px
  final filename = 'icon.png';
  //var bytes = await rootBundle.load("assets/images/yourlogo.png");
  var bytes = await rootBundle.load("assets/icon/icon.png");
  String dir = (await getApplicationDocumentsDirectory()).path;
  writeToFile(bytes, '$dir/$filename');

  var pathImage = '$dir/$filename';
  return pathImage;
}

Future<void> writeToFile(ByteData data, String path) {
  final buffer = data.buffer;
  return new File(path).writeAsBytes(
    buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
  );
}
