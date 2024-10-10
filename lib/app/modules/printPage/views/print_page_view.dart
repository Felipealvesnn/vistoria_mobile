import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/printPage/components/PdfPreviewPage.dart';
import 'package:vistoria_mobile/app/utils/themaapp.dart';
import '../controllers/print_page_controller.dart';

class PrintPageView extends GetView<PrintPageController> {
  const PrintPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('PrintPageView'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PrinterDropdown(controller: controller),
                    const SizedBox(height: 20),
                    Obx(() => ElevatedButton.icon(
                          onPressed: controller.isConnecting.value
                              ? null
                              : () => controller.connectToPrinter(),
                          icon: controller.isConnecting.value
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.bluetooth_connected),
                          label: Text(controller.isConnecting.value
                              ? 'Conectando...'
                              : controller.isConnectedToPrinter.value
                                  ? 'Conectado a: ${controller.selectedPrinter.value}'
                                  : 'Conectar à Impressora'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                controller.isConnectedToPrinter.value
                                    ? colorAzulinfo
                                    : Get.theme.primaryColor,
                            minimumSize: const Size.fromHeight(50),
                          ),
                        )),
                    //const SizedBox(height: 10),
                    // ElevatedButton.icon(
                    //   onPressed: () {
                    //     // Ação futura para enviar PDF via WhatsApp
                    //   },
                    //   icon: const Icon(FontAwesomeIcons.whatsapp),
                    //   label: const Text('WhatsApp'),
                    //   style: ElevatedButton.styleFrom(
                    //     minimumSize: const Size.fromHeight(50),
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.to(() =>
                            PdfPreviewPage(ocorrencia: controller.vistoria));
                      },
                      icon: const Icon(Icons.picture_as_pdf),
                      label: const Text('Visualizar PDF'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: controller.isConnectedToPrinter.value &&
                              !controller.isPrinting.value
                          ? () => controller.printDocument()
                          : null,
                      icon: const Icon(Icons.print),
                      label: Obx(() => Text(
                            controller.isPrinting.value
                                ? 'Imprimindo...'
                                : 'Imprimir',
                          )),
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: Colors.grey,
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}

class PrinterDropdown extends StatelessWidget {
  final PrintPageController controller;

  const PrinterDropdown({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Impressoras:',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          width: 20,
        ),
        Obx(() => DropdownButton<String>(
              value: controller.tempSelectedPrinter.value,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.tempSelectedPrinter.value = newValue;
                }
              },
              items: controller.availablePrinters.isNotEmpty
                  ? controller.availablePrinters
                      .map<DropdownMenuItem<String>>((String printer) {
                      return DropdownMenuItem<String>(
                        value: printer,
                        child: Text(printer),
                      );
                    }).toList()
                  : [
                      const DropdownMenuItem<String>(
                        value: 'Não disponível',
                        child: Text('Não disponível'),
                      ),
                    ],
            )),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.scanForPrinters();
            },
          ),
        ),
      ],
    );
  }
}
