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
  final formKey = GlobalKey<FormState>();
  var comentarioController = TextEditingController();
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
                onTap: () async {
                  await controller.pickImage(ImageSource.gallery);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tirar foto'),
                onTap: () async {
                  await controller.pickImage(ImageSource.camera);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        );
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
      onPopInvokedWithResult: (result, dinamic) {
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
                // Campo de placa sempre visível
                TextFormField(
                  focusNode: myFocusNode,
                  controller: controller.placaController,
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
                                  value:
                                      controller.veiculoTipoSelecionado.value,
                                  items: controller
                                      .vistoriaMobileDTOs.first.veiculoTipos
                                      ?.map((veiculoTipo) => DropdownMenuItem(
                                            value: veiculoTipo,
                                            child: Text(veiculoTipo.veiTipDesc
                                                    ?.trim() ??
                                                ''),
                                          ))
                                      .toList(),
                                  onChanged: controller
                                          .isVeiculoTipoLocked.value
                                      ? null // Desabilita a seleção se o tipo estiver travado
                                      : (VeiculoTipo? newValue) {
                                          // Atualiza o valor selecionado do controlador
                                          controller.veiculoTipoSelecionado
                                              .value = newValue;
                                          controller.filterVeiculoTipo(
                                              newValue?.veiTipDesc ?? '');
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
                              ? Column(
                                  children: [
                                    DropdownButtonFormField<TipoPermissionario>(
                                      decoration: const InputDecoration(
                                        labelText: "Tipo Permissionário",
                                        border: OutlineInputBorder(),
                                      ),
                                      items: controller
                                          .tipoPermissionariosFiltrados
                                          .map((permissionario) =>
                                              DropdownMenuItem(
                                                value: permissionario,
                                                child: Text(
                                                    permissionario.descricao ??
                                                        ''),
                                              ))
                                          .toList(),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Campo obrigatório!';
                                        }
                                        return null;
                                      },
                                      value: controller
                                          .permisionarioSelecionado.value,
                                      onChanged: controller
                                              .isPermissionarioipoLocked.value
                                          ? null
                                          : (TipoPermissionario? newValue) {
                                              // Atualizar estado conforme necessário
                                              // Atualiza visibilidade com base na seleção
                                              controller.updateCampo(
                                                  'codTipoPermissao',
                                                  newValue?.codTipoPermissao
                                                          .toString() ??
                                                      '');
                                              controller.updateVisibility(
                                                  newValue?.codTipoPermissao
                                                          .toString() ??
                                                      '',
                                                  controller
                                                          .veiculoTipoSelecionado
                                                          .value
                                                          ?.veiTipDesc ??
                                                      '');
                                            },
                                    ),
                                    const SizedBox(height: 16.0),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),

                        // Campos Condicionais
                        _buildCamposCondicionais(),

                        Obx(
                          () => controller.RecarregarDropwndoTipo.value
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Status da Vistoria",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: RadioListTile<String>(
                                            title: const Text('APROVADO'),
                                            value: 'APROVADO',
                                            groupValue:
                                                controller.statusVistoria.value,
                                            onChanged: (String? value) {
                                              controller.statusVistoria.value =
                                                  value ?? '';
                                            },
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            focusNode:
                                                radioFocusNode, // If you need to manage focus
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: RadioListTile<String>(
                                            title: const Text('REPROVADO'),
                                            value: 'REPROVADO',
                                            groupValue:
                                                controller.statusVistoria.value,
                                            onChanged: (String? value) {
                                              controller.statusVistoria.value =
                                                  value ?? '';
                                            },
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            focusNode:
                                                radioFocusNode, // If you need to manage focus
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (controller.statusVistoria.value
                                        .isEmpty) // Exibe mensagem de erro
                                      const Text(
                                        'Selecione um status',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                    const SizedBox(height: 16.0),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),

                        // Botão para capturar/selecionar imagem
                        Obx(
                          () => controller.RecarregarDropwndoTipo.value
                              ? (controller.statusVistoria.value == "REPROVADO"
                                  ? TextFormField(
                                      validator: (value) {
                                        if (controller.statusVistoria.value ==
                                                "REPROVADO" &&
                                            value!.isEmpty) {
                                          return 'Campo obrigatório!';
                                        }
                                        return null;
                                      },
                                      onChanged: (String value) {
                                        controller.updateCampo(
                                            "reprovadoObs", value);
                                      },
                                      controller:
                                          comentarioController, // Controlador do campo de texto
                                      maxLines:
                                          5, // Número de linhas visíveis para tornar o campo grande
                                      decoration: const InputDecoration(
                                        labelText: 'Comentário',

                                        hintText:
                                            'Digite seu comentário aqui...',

                                        border:
                                            OutlineInputBorder(), // Adiciona uma borda ao redor do campo
                                      ),
                                    )
                                  : const SizedBox.shrink())
                              : const SizedBox.shrink(),
                        ),

                        Obx(
                          () => controller.RecarregarDropwndoTipo.value
                              ? Column(
                                  children: [
                                    const SizedBox(height: 16.0),
                                    ElevatedButton.icon(
                                      onPressed: () =>
                                          _showImageSourceSelection(context),
                                      icon: const Icon(Icons.image),
                                      label: const Text('Adicionar Foto'),
                                    ),
                                    const SizedBox(height: 20),
                                    Obx(
                                      () {
                                        return Column(
                                          children: [
                                            OverflowBar(
                                              spacing: 8.0,
                                              children: [
                                                // Mostrar mensagem se não houver imagens selecionadas
                                                if (controller
                                                    .selectedImages.isEmpty)
                                                  const Text(
                                                      "Nenhuma imagem selecionada"),
                                                // Exibir imagens selecionadas
                                                ...controller.selectedImages
                                                    .map((imageFile) {
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
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.delete,
                                                            color: Colors.red),
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    "Confirmar"),
                                                                content: const Text(
                                                                    "Você deseja excluir a imagem?"),
                                                                actions: [
                                                                  TextButton(
                                                                    child: const Text(
                                                                        "Cancelar"),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                  TextButton(
                                                                    child: const Text(
                                                                        "Excluir"),
                                                                    onPressed:
                                                                        () {
                                                                      controller
                                                                          .selectedImages
                                                                          .remove(
                                                                              imageFile);
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
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
                                                }),
                                              ],
                                            ),
                                            const SizedBox(height: 16.0),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),

                        // Botão de envio
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: controller
                                        .RecarregarDropwndoTipo.value
                                    ? () {
                                        if ((formKey.currentState?.validate() ??
                                                false) &&
                                            controller.statusVistoria.value
                                                .isNotEmpty) {
                                          // Se o formulário for válido, gera e envia o JSON

                                          final jsonFinal =
                                              controller.generateJson();
                                          print(
                                              jsonFinal); // Aqui você pode enviar o JSON gerado
                                        } else {
                                          Get.snackbar('Erro',
                                              'Preencha todos os campos obrigatórios');
                                        }
                                      }
                                    : () {
                                        myFocusNode.requestFocus();
                                        Get.snackbar(
                                            'Erro', 'Digite uma placa válida');
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
      ),
    );
  }
}
