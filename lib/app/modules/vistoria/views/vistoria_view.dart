import 'package:brasil_fields/brasil_fields.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/MyDrawer.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/listvistoria.dart';
import 'package:vistoria_mobile/app/modules/vistoria/views/adicionar_vistoria.dart';
import '../controllers/vistoria_controller.dart';
import 'package:intl/intl.dart'; // Biblioteca para manipular datas

class VistoriaView extends GetView<VistoriaController> {
  const VistoriaView({super.key});

  @override
  Widget build(BuildContext context) {
    double tamanho = 100;
    void showFilterModal(BuildContext context) {
      Get.bottomSheet(
        backgroundColor: Colors.white,
        Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GetBuilder<VistoriaController>(
              builder: (controller) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Filtros',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    // Campo de texto para filtrar por placa
                    TextFormField(
                      controller: controller.placaSeacherController,
                      inputFormatters: [
                        TextInputMask(
                            mask: 'AAA-9N99',
                            placeholder: '_',
                            maxPlaceHolders: 11,
                            reverse: false),
                        PlacaVeiculoInputFormatter()
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Placa',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Campo para selecionar data inicial
                    TextFormField(
                      controller: controller.dataInicioController,
                      decoration: const InputDecoration(
                        labelText: 'Data Inicial',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true, // Impede edição manual
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          controller.dataInicioController.text =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Campo para selecionar data final
                    TextFormField(
                      controller: controller.dataFimController,
                      decoration: const InputDecoration(
                        labelText: 'Data Final',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true, // Impede edição manual
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          controller.dataFimController.text =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                        }
                      },
                    ),
                    const SizedBox(height: 20),

                    // Botão para aplicar os filtros
                    OverflowBar(
                      spacing: 16,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Lógica para resetar os filtros aqui
                            controller.reseteFiltroVistorias();
                            // Fechar o modal após resetar os filtros
                            Get.back();
                          },
                          child: const Text('Resetar Filtros'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Obter os textos dos controladores
                            String plateText = controller
                                .placaSeacherController.text
                                .replaceAll('-', '')
                                .replaceAll('_', '');
                            controller.placaSeacherController.text = plateText;
                            String dataInicioText =
                                controller.dataInicioController.text.trim();
                            String dataFimText =
                                controller.dataFimController.text.trim();

                            // Verificar se pelo menos a placa ou uma data foi preenchida
                            if (plateText.isEmpty &&
                                dataInicioText.isEmpty &&
                                dataFimText.isEmpty) {
                              // Mostrar mensagem de erro
                              Get.snackbar(
                                'Erro',
                                'Por favor, preencha a placa ou uma data para aplicar o filtro.',
                              );
                              return; // Não prosseguir
                            }

                            // Se a placa estiver preenchida, verificar se tem pelo menos 7 caracteres
                            if (plateText.isNotEmpty && plateText.length < 7) {
                              // Mostrar mensagem de erro
                              Get.snackbar(
                                'Erro',
                                'A placa deve ter pelo menos 7 caracteres.',
                              );
                              return; // Não prosseguir
                            }

                            // Lógica para aplicar os filtros aqui
                            controller.fetchFiltroVistorias();
                            // Fechar o modal após aplicar os filtros
                            Get.back();
                          },
                          child: const Text('Aplicar Filtros'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      );
    }
  
  
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          tamanho, // Define a altura do AppBar
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
          child: SizedBox(
            height: tamanho, // Ajusta a altura do AppBar
            child: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () => showFilterModal(context),
                ),
              ],
              title: const Text(
                'Vistoria',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              elevation: 10, // Adiciona a elevação (sombra)
              shadowColor:
                  Colors.black.withOpacity(0.5), // Personaliza a cor da sombra
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(16),
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => VistoriaFormPage());
          },
          // Cor do botão e do ícone
          foregroundColor: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.add),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.currentPage.value = 1;
          controller.hasMoreVistorias.value = true;
          controller.isLoadingVistoriaInicial.value = true;
          controller.vistoriasAll.clear();
          await controller.fetchVistorias();
          await controller.fetchVistoriasMobileDTO();
          controller.isLoadingVistoriaInicial.value = false;
        },
        child: Obx(() {
          if (controller.isLoadingVistoriaInicial.value) {
            // Mostra o indicador de carregamento enquanto está carregando
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Carregando vistorias...'),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }

          if (controller.vistoriasTela.isEmpty) {
            // Mostra a mensagem somente após o carregamento estar completo
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Nenhuma vistoria encontrada.',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            );
          }

          // Exibe a lista de vistorias
          return ListVistoria(controller: controller);
        }),
      ),
    );
  }
}
