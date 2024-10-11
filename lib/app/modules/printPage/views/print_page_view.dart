import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/printPage/components/PdfPreviewPage.dart';
import 'package:vistoria_mobile/app/utils/themaapp.dart';
import '../controllers/print_page_controller.dart';

class PrintPageView extends GetView<PrintPageController> {
  const PrintPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impressão de Vistoria'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PrinterDropdown(controller: controller),
                    const SizedBox(height: 20),
                    Obx(() => ElevatedButton.icon(
                          onPressed: controller.isConnecting.value
                              ? null
                              : controller.isConnectedToPrinter.value
                                  ? controller.disconnectPrinter
                                  : controller.connectToPrinter,
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
                                  ? 'Desconectar Impressora'
                                  : 'Conectar à Impressora'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                controller.isConnectedToPrinter.value
                                    ? Colors.red
                                    : Get.theme.primaryColor,
                            minimumSize: const Size.fromHeight(50),
                          ),
                        )),
                    const SizedBox(height: 10),
                    // ElevatedButton.icon(
                    //   onPressed: () {
                    //     // Ação futura para enviar PDF via WhatsApp
                    //   },
                    //   icon: const Icon(FontAwesomeIcons.whatsapp),
                    //   label: const Text('Enviar via WhatsApp'),
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
                    Obx(() => ElevatedButton.icon(
                          onPressed: controller.isConnectedToPrinter.value &&
                                  !controller.isPrinting.value
                              ? controller.printDocument
                              : null,
                          icon: controller.isPrinting.value
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.print),
                          label: Text(
                            controller.isPrinting.value
                                ? 'Imprimindo...'
                                : 'Imprimir',
                          ),
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Colors.grey,
                            minimumSize: const Size.fromHeight(50),
                          ),
                        )),
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
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecione a Impressora:',
            style: TextStyle(fontSize: 18,),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: controller.selectedPrinter.value,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  ),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.selectedPrinter.value = newValue;
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
                            
                            value: null,
                            child: Text('Nenhuma impressora disponível',),
                          ),
                        ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  controller.scanForPrinters();
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}
