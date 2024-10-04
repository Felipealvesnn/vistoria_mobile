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
import 'package:auto_size_text/auto_size_text.dart';

class VistoriaFormPage extends StatelessWidget {
  final VistoriaController controller = Get.find<VistoriaController>();
  final formKey = GlobalKey<FormState>();
  final comentarioController = TextEditingController();
  final FocusNode myFocusNode = FocusNode();
  final FocusNode radioFocusNode = FocusNode();

  VistoriaFormPage({super.key});

  void handlePlacaChange(String value) async {
    value = value.replaceAll('-', '').replaceAll('_', '');
    if (value.length == 7) {
      final response = await controller.getInforVeiculoDetran(value);
      if (response.placa != null) {
        controller.updateCampo('placa', response.placa);
      }
    }
  }

  void _showImageSourceSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              _imageSourceTile(
                icon: Icons.photo_library,
                label: 'Selecionar da galeria',
                source: ImageSource.gallery,
              ),
              _imageSourceTile(
                icon: Icons.camera_alt,
                label: 'Tirar foto',
                source: ImageSource.camera,
              ),
            ],
          ),
        );
      },
    );
  }

  ListTile _imageSourceTile({
    required IconData icon,
    required String label,
    required ImageSource source,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () async {
        await controller.pickImage(source);
        Get.back();
      },
    );
  }

  Widget _buildCamposCondicionais() {
    return Column(
      children: [
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (result, _) {
        if (result) {
          controller.limparCampos();
          controller.RecarregarDropwndoTipo.value = false;
          controller.placaController.clear();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Formulário de Vistoria"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(height: 16.0),
                _buildPlacaField(),
                const SizedBox(height: 16.0),
                Obx(() => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : _buildFormFields(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlacaField() {
    return TextFormField(
      focusNode: myFocusNode,
      controller: controller.placaController,
      decoration: const InputDecoration(
        labelText: "Placa",
        border: OutlineInputBorder(),
      ),
      inputFormatters: [
        TextInputMask(mask: 'AAA-9N99', placeholder: '_', maxPlaceHolders: 11),
        PlacaVeiculoInputFormatter(),
      ],
      onChanged: (String? value) {
        if (value != null) handlePlacaChange(value);
      },
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      children: [
        Obx(() => controller.RecarregarDropwndoTipo.value
            ? Column(
                children: [
                  _buildVeiculoTipoDropdown(),
                  const SizedBox(height: 16.0),
                  _buildTipoPermissionarioDropdown(),
                  const SizedBox(height: 16.0),
                  _buildCamposCondicionais(),
                  const SizedBox(height: 16.0),
                  _buildStatusVistoriaRadio(),
                  if (controller.statusVistoria.value == "REPROVADO")
                    _buildComentarioField(),
                  const SizedBox(height: 16.0),
                  _buildAddPhotoButton(context),
                  const SizedBox(height: 20),
                  _buildSelectedImages(context),
                  const SizedBox(height: 16.0),
                  _buildEnviarButton(context),
                  const SizedBox(height: 16.0),
                ],
              )
            : const SizedBox.shrink()),
      ],
    );
  }

  Widget _buildVeiculoTipoDropdown() {
    return DropdownButtonFormField<VeiculoTipo>(
      decoration: const InputDecoration(
        labelText: "Tipo de Veículo",
        border: OutlineInputBorder(),
      ),
      value: controller.veiculoTipoSelecionado.value,
      items: controller.vistoriaMobileDTOs.first.veiculoTipos
          ?.map((veiculoTipo) => DropdownMenuItem(
                value: veiculoTipo,
                child: Text(veiculoTipo.veiTipDesc?.trim() ?? ''),
              ))
          .toList(),
      onChanged: controller.isVeiculoTipoLocked.value
          ? null
          : (VeiculoTipo? newValue) {
              controller.veiculoTipoSelecionado.value = newValue;
              controller.filterVeiculoTipo(newValue?.veiTipDesc ?? '');
              controller.filtrarTipoPermissionarios(newValue?.veiTipDesc ?? '');
            },
    );
  }

  Widget _buildTipoPermissionarioDropdown() {
    return DropdownButtonFormField<TipoPermissionario>(
      decoration: const InputDecoration(
        labelText: "Tipo Permissionário",
        border: OutlineInputBorder(),
      ),
      items: controller.tipoPermissionariosFiltrados
          .map((permissionario) => DropdownMenuItem(
                value: permissionario,
                child: Text(permissionario.descricao ?? ''),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Campo obrigatório!';
        }
        return null;
      },
      value: controller.permisionarioSelecionado.value,
      onChanged: controller.isPermissionarioipoLocked.value
          ? null
          : (TipoPermissionario? newValue) {
              controller.updateCampo('codTipoPermissao',
                  newValue?.codTipoPermissao.toString() ?? '');
              controller.updateVisibility(
                newValue?.codTipoPermissao.toString() ?? '',
                controller.veiculoTipoSelecionado.value?.veiTipDesc ?? '',
              );
            },
    );
  }

  Widget _buildStatusVistoriaRadio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Status da Vistoria",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: const AutoSizeText(
                  'APROVADO',
                  maxLines: 1, // Limita a uma linha para evitar a quebra
                  minFontSize:
                      10, // Define o tamanho mínimo da fonte ao redimensionar
                  overflow: TextOverflow
                      .ellipsis, // Adiciona "..." se o texto for muito longo
                ),
                value: 'APROVADO',
                groupValue: controller.statusVistoria.value,
                onChanged: (String? value) {
                  controller.statusVistoria.value = value ?? '';
                },
                controlAffinity: ListTileControlAffinity.leading,
                focusNode: radioFocusNode,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: RadioListTile<String>(
                title: const AutoSizeText(
                  'REPROVADO',
                  maxLines: 1, // Limita a uma linha para evitar a quebra
                  minFontSize:
                      10, // Define o tamanho mínimo da fonte ao redimensionar
                  overflow: TextOverflow
                      .ellipsis, // Adiciona "..." se o texto for muito longo
                ),
                value: 'REPROVADO',
                groupValue: controller.statusVistoria.value,
                onChanged: (String? value) {
                  controller.statusVistoria.value = value ?? '';
                },
                controlAffinity: ListTileControlAffinity.leading,
                focusNode: radioFocusNode,
              ),
            ),
          ],
        ),
        if (controller.statusVistoria.value.isEmpty)
          const Text(
            'Selecione um status',
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
      ],
    );
  }

  Widget _buildComentarioField() {
    return TextFormField(
      validator: (value) {
        if (controller.statusVistoria.value == "REPROVADO" && value!.isEmpty) {
          return 'Campo obrigatório!';
        }
        return null;
      },
      onChanged: (String value) {
        controller.updateCampo("reprovadoObs", value);
      },
      controller: comentarioController,
      maxLines: 5,
      decoration: const InputDecoration(
        labelText: 'Comentário',
        hintText: 'Digite seu comentário aqui...',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildAddPhotoButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _showImageSourceSelection(context),
      icon: const Icon(Icons.image),
      label: const Text('Adicionar Foto'),
    );
  }

  Widget _buildSelectedImages(BuildContext context) {
    return Obx(
      () {
        return controller.selectedImages.isEmpty
            ? const Text("Nenhuma imagem selecionada")
            : Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: controller.selectedImages.map((imageFile) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipOval(
                        child: Image.file(
                          imageFile,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () {
                            Get.dialog(
                              AlertDialog(
                                title: const Text("Confirmar"),
                                content:
                                    const Text("Você deseja excluir a imagem?"),
                                actions: [
                                  TextButton(
                                    child: const Text("Cancelar"),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text("Excluir"),
                                    onPressed: () {
                                      controller.selectedImages
                                          .remove(imageFile);
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              );
      },
    );
  }

  Widget _buildEnviarButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: controller.RecarregarDropwndoTipo.value
                ? () {
                    if ((formKey.currentState?.validate() ?? false) &&
                        controller.statusVistoria.value.isNotEmpty) {
                      Get.dialog(
                        AlertDialog(
                          title: const Text('Confirmação'),
                          content: const Text(
                              'Você tem certeza que deseja registrar a vistoria?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('Cancelar'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final jsonFinal = controller.generateJson();
                                print(jsonFinal);
                                Get.back();
                              },
                              child: const Text('Confirmar'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      Get.snackbar(
                          'Erro', 'Preencha todos os campos obrigatórios');
                    }
                  }
                : () {
                    myFocusNode.requestFocus();
                    Get.snackbar('Erro', 'Digite uma placa válida');
                  },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text("Enviar"),
            ),
          ),
        ),
      ],
    );
  }
}
