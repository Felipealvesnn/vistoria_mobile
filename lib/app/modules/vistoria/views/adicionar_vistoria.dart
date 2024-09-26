import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_mask/easy_mask.dart';
// ignore: depend_on_referenced_packages
import 'package:brasil_fields/brasil_fields.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vistoria_mobile/app/data/models/TipoPermissionario%20.dart';
import 'package:vistoria_mobile/app/data/models/VeiculoTipo.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/CamposCarro.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/CamposMoto.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/DadosVeiculoWidget.dart';
import 'package:vistoria_mobile/app/modules/vistoria/components/camposCarroMoto.dart';
import 'package:vistoria_mobile/app/modules/vistoria/controllers/vistoria_controller.dart';

class VistoriaFormPage extends StatelessWidget {
  final VistoriaController controller = Get.find<VistoriaController>();

  VistoriaFormPage({super.key});
  void handlePlacaChange(String value) async {
    value = value.replaceAll('-', '').replaceAll('_', '');
    if (value.length == 7) {
      final response = await controller.getInforVeiculoDetran(value);
      if (response.placa != null) {
        controller.updateCampo('placa', response.placa);
      }
      // print(response);
    }
  }

  // Função para mostrar o modal com opções de selecionar imagem ou tirar foto
  void _showImageSourceSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Selecionar da galeria'),
                onTap: () {
                  controller.pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tirar foto'),
                onTap: () {
                  controller.pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de Vistoria"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              const SizedBox(height: 16.0),
              // Campo de placa sempre visível
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Placa",
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  TextInputMask(
                      mask: 'AAA-9N99',
                      placeholder: '_',
                      maxPlaceHolders: 11,
                      reverse: false),
                  PlacaVeiculoInputFormatter()
                ],
                onChanged: (String? value) {
                  if (value != null) handlePlacaChange(value);
                },
              ),
              const SizedBox(height: 16.0),

              // Verifica se está carregando
              Obx(() {
                // Se estiver carregando, mostra o CircularProgressIndicator
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  // Caso contrário, mostra os demais campos
                  return Column(
                    children: [
                      Obx(
                        () => controller.RecarregarDropwndoTipo.value
                            ? DropdownButtonFormField<VeiculoTipo>(
                                decoration: const InputDecoration(
                                  labelText: "Tipo de Veículo",
                                  border: OutlineInputBorder(),
                                ),
                                // Usa o valor selecionado do controlador
                                value: controller.veiculoTipoSelecionado.value,
                                items: controller
                                    .vistoriaMobileDTOs.first.veiculoTipos
                                    ?.map((veiculoTipo) => DropdownMenuItem(
                                          value: veiculoTipo,
                                          child: Text(
                                              veiculoTipo.veiTipDesc?.trim() ??
                                                  ''),
                                        ))
                                    .toList(),
                                onChanged: controller.isVeiculoTipoLocked.value
                                    ? null // Desabilita a seleção se o tipo estiver travado
                                    : (VeiculoTipo? newValue) {
                                        // Atualiza o valor selecionado do controlador
                                        controller.veiculoTipoSelecionado
                                            .value = newValue;
                                        // Atualiza o filtro de tipo permissionário
                                        controller.filtrarTipoPermissionarios(
                                            newValue?.veiTipDesc ?? '');
                                      },
                              )
                            : const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 16.0),
                      Obx(
                        () => controller.RecarregarDropwndoTipo.value
                            ? DropdownButtonFormField<TipoPermissionario>(
                                decoration: const InputDecoration(
                                  labelText: "Tipo Permissionário",
                                  border: OutlineInputBorder(),
                                ),
                                items: controller.tipoPermissionariosFiltrados
                                    .map((permissionario) => DropdownMenuItem(
                                          value: permissionario,
                                          child: Text(
                                              permissionario.descricao ?? ''),
                                        ))
                                    .toList(),
                                onChanged: (TipoPermissionario? newValue) {
                                  // Atualizar estado conforme necessário
                                  // Atualiza visibilidade com base na seleção
                                  controller.updateVisibility(
                                      newValue?.codTipoPermissao.toString() ??
                                          '',
                                      controller.veiculoTipoSelecionado.value
                                              ?.veiTipDesc ??
                                          '');
                                },
                              )
                            : const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 16.0),

                      // Campos Condicionais
                      Obx(() => controller.showDadosVeiculo.value
                          ? DadosVeiculoWidget()
                          : const SizedBox.shrink()),
                      Obx(() => controller.showMotoFields.value
                          ? MotoFieldsWidget()
                          : const SizedBox.shrink()),
                      Obx(() => controller.showCarFields.value
                          ? CarFieldsWidget()
                          : const SizedBox.shrink()),
                      Obx(() => controller.showCarAndMotoFields.value
                          ? CarAndMotoFieldsWidget()
                          : const SizedBox.shrink()),

                      // Botão para capturar/selecionar imagem
                      OverflowBar(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _showImageSourceSelection(context),
                            icon: const Icon(Icons.image),
                            label: const Text('Adicionar Foto'),
                          ),
                          const SizedBox(width: 16.0),
                          Obx(() {
                            if (controller.selectedImage.value != null) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipOval(
                                    child: Image.file(
                                      controller.selectedImage.value!,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Confirmar"),
                                            content: const Text(
                                                "Você deseja excluir a imagem?"),
                                            actions: [
                                              TextButton(
                                                child: const Text("Cancelar"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text("Excluir"),
                                                onPressed: () {
                                                  controller.selectedImage
                                                      .value = null;
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              );
                            } else {
                              return const Text("Nenhuma imagem selecionada");
                            }
                          }),
                        ],
                      ),
                      const SizedBox(height: 16.0),

                      // Botão de envio
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                final jsonFinal = controller.generateJson();
                                print(
                                    jsonFinal); // Aqui você pode enviar o JSON gerado
                              },
                              child: const Text("Enviar"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
