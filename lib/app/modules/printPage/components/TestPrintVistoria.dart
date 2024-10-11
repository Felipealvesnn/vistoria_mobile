import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:intl/intl.dart';
import 'package:vistoria_mobile/app/data/models/vistoria.dart';
import 'package:vistoria_mobile/app/modules/vistoria/ultis/utilsVistoriaMaps.dart';
import 'package:vistoria_mobile/app/utils/funcoesUtils.dart';

class TestPrintVistoria {
  static BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  static printVistoria(Vistoria vistoria) async {
    // Formatação da data
    String dataVistoria = vistoria.dataVistoria != null
        ? DateFormat("dd/MM/yyyy HH:mm:ss")
            .format(vistoria.dataVistoria!.toLocal())
        : 'N/A';

    // Dados do veículo (compartilhados para carro e moto)

    // Determina quais campos serão exibidos com base no tipo de veículo
    List<Map<String, String?>> camposVistoria = [];

    camposVistoria = MapDeVistoriaDetails(vistoria);
    String pathImage = 'assets/icon/icon.png';
    // Imprimir os campos conforme o tipo do veículo
    bluetooth.isConnected.then((isConnected) {
      if (isConnected!) {
        // Início da impressão
        bluetooth.printNewLine();
        bluetooth.printImage(pathImage); // Caminho da imagem/logo
        bluetooth.printNewLine();
        bluetooth.printCustom(
            "DETALHES DA VISTORIA", 3, 1); // Título centralizado
        bluetooth.printNewLine();

        // Imprimir os campos dinamicamente
        for (var campo in camposVistoria) {
          bluetooth.printCustom(
              "${removeSpecialCharacters(campo['label']!)} : ${removeSpecialCharacters(campo['value']!)}",
              1,
              0);
          bluetooth.printNewLine();
          if (campo['Obs'] != null && campo['Obs']!.isNotEmpty) {
            bluetooth.printCustom(
                "Observacao: ${removeSpecialCharacters(campo['Obs']!)}", 0, 0);
          }
        }

        // Data da Vistoria
        bluetooth.printCustom("Data da Vistoria: $dataVistoria", 0, 0);

        // Cortar o papel no final
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }
}
