import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Obx(
        () {
          if (controller.vistoriaMobileDTOs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // Pega o primeiro item da lista para o exemplo
            final vistoria = controller.vistoriaMobileDTOs.first;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: ListView(
                  children: [
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Placa",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (String? value) {
                        // Atualiza o valor do campo no controlador
                        //  controller.updateCampo(campo['campo']!, value ?? '');
                      },
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<TipoPermissionario>(
                      decoration: const InputDecoration(
                        labelText: "Tipo Permissionário",
                        border: OutlineInputBorder(),
                      ),
                      value: vistoria.tipoPermissionario?.first,
                      items: vistoria.tipoPermissionario
                          ?.map((permissionario) => DropdownMenuItem(
                                value: permissionario,
                                child: Text(permissionario.descricao ?? ''),
                              ))
                          .toList(),
                      onChanged: (TipoPermissionario? newValue) {
                        // Atualizar estado
                      },
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<VeiculoTipo>(
                      decoration: const InputDecoration(
                        labelText: "Tipo de Veículo",
                        border: OutlineInputBorder(),
                      ),
                      value: vistoria.veiculoTipos?.first,
                      items: vistoria.veiculoTipos
                          ?.map((veiculoTipo) => DropdownMenuItem(
                                value: veiculoTipo,
                                child:
                                    Text(veiculoTipo.veiTipDesc?.trim() ?? ''),
                              ))
                          .toList(),
                      onChanged: (VeiculoTipo? newValue) {
                        // Atualizar estado
                      },
                    ),
                    const SizedBox(height: 16.0),
                    DadosVeiculoWidget(),
                    MotoFieldsWidget(),
                    CarFieldsWidget(),
                    CarAndMotoFieldsWidget(),

                    // Botão para capturar/selecionar imagem
                    Row(
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
                                                controller.selectedImage.value =
                                                    null;
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
                    ElevatedButton(
                      onPressed: () {
                        final jsonFinal = controller.generateJson();
                        print(jsonFinal); // Aqui você pode enviar o JSON gerado
                      },
                      child: const Text("Enviar"),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
